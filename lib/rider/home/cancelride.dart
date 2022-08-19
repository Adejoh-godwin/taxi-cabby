// ignore_for_file: avoid_print, prefer_collection_literals

import 'dart:convert';

import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:cabby/driver/widget/shared/widgets/driver_info_icons.dart';
import 'package:cabby/driver/widget/shared/widgets/ride_viewdetailstwo.dart';
import 'package:cabby/rider/Notifications/pushnotificationservice.dart';
// import 'package:cabby/rider/Notifications/pushnotificationservice.dart';
import 'package:cabby/rider/home/chatDriver.dart';
import 'package:cabby/rider/home/message/chat.dart';
import 'package:cabby/rider/home/notificatio_rider.dart';
import 'package:cabby/rider/home/paymet.dart';
import 'package:cabby/rider/AllWidgets/popup.dart';
import 'package:cabby/rider/Assistants/assistantMethods.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/rider_home.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CancelRide extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;
  final AvailableModel? availableModel;

  const CancelRide(
      {Key? key, this.userModel, this.userModel2, this.availableModel})
      : super(key: key);

  @override
  CancelRideState createState() => CancelRideState();
}

class CancelRideState extends State<CancelRide> {
  double listenPercent = 0.0;
  // var currentSelectedValueThree;
  final List<String> typeOfRide = ["Interstate", "Border", "InterCountry"];
  double systemHeight = 0;
  bool loading = false;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  double systemWidth = 0;

  Completer<GoogleMapController> controllerGoogleMap = Completer();
  GoogleMapController? newRideGoogleMapController;
  Set<Marker> markersSet = Set<Marker>();
  Set<Circle> circleSet = Set<Circle>();
  Set<Polyline> polyLineSet = Set<Polyline>();
  List<LatLng> polylineCorOrdinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double mapPaddingFromBottom = 0;
  var geoLocator = Geolocator();
  var locationOptions =
      const LocationOptions(accuracy: LocationAccuracy.bestForNavigation);
  BitmapDescriptor? animatingMarkerIcon;
  Position? myPostion;
  String status = "accepted";
  String durationRide = "";
  bool isRequestingDirection = false;
  String btnTitle = "Arrived";
  Color btnColor = Colors.black87;
  Timer? timer;
  int durationCounter = 0;
  var textMsg = "Cancel";

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      checkRide();
      print('checked');
    });
  }

  void createIconMarker() {
    if (animatingMarkerIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "images/car_android.png")
          .then((value) {
        animatingMarkerIcon = value;
      });
    }
  }

  Future<void> getRideLiveLocationUpdates() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng oldPos = const LatLng(0, 0);

    rideStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      myPostion = position;
      LatLng mPostion = LatLng(position.latitude, position.longitude);

      var rot = MapKitAssistant.getMarkerRotation(oldPos.latitude,
          oldPos.longitude, myPostion!.latitude, myPostion!.latitude);

      Marker animatingMarker = Marker(
        markerId: const MarkerId("animating"),
        position: mPostion,
        icon: animatingMarkerIcon!,
        rotation: rot,
        infoWindow: const InfoWindow(title: "Current Location"),
      );
      if (!mounted) return;
      setState(() {
        CameraPosition cameraPosition =
            CameraPosition(target: mPostion, zoom: 17);
        newRideGoogleMapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        markersSet
            .removeWhere((marker) => marker.markerId.value == "animating");
        markersSet.add(animatingMarker);
      });
      oldPos = mPostion;

      PushNotificationService pushNotificationService = PushNotificationService(
          widget.userModel!, widget.userModel2!, context);

      pushNotificationService.initialize(context);
      // pushNotificationService.getToken();
      // updateRideDetails();

      // String rideRequestId = widget.rideDetails!.ride_request_id!;
      // Map locMap = {
      //   "latitude": currentPosition!.latitude.toString(),
      //   "longitude": currentPosition!.longitude.toString(),
      // };
      // newRequestsRef.child(rideRequestId).child("driver_location").set(locMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    createIconMarker();
    // final size = Dimensions().getSize(context);

    systemHeight = Dimensions().getHeight(context);
    systemWidth = Dimensions().getWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //image
            Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 0.3,
              child: GoogleMap(
                padding: EdgeInsets.only(bottom: mapPaddingFromBottom),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.availableModel!.pickUpLat!,
                      widget.availableModel!.pickUpLong),
                  zoom: 14.4746,
                ),
                myLocationEnabled: true,
                markers: markersSet,
                circles: circleSet,
                polylines: polyLineSet,
                onMapCreated: (GoogleMapController controller) async {
                  controllerGoogleMap.complete(controller);
                  newRideGoogleMapController = controller;

                  setState(() {
                    mapPaddingFromBottom = 265.0;
                  });
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  currentPosition = position;

                  var dropOff = LatLng(widget.availableModel!.dropOffLat,
                      widget.availableModel!.dropOffLong);
                  var pickUpLatLng = LatLng(widget.availableModel!.pickUpLat,
                      widget.availableModel!.pickUpLong);

                  await getPlaceDirection(pickUpLatLng, dropOff);

                  getRideLiveLocationUpdates();
                },
              ),
            ),
            Positioned(
                left: 20,
                top: 20,
                child: Builder(
                  builder: (context) => InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Ensure Scaffold is in context
                )),
            Positioned(
              right: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotificationSection();
                  }));
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.doorbell_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                // height: 200,
                width: systemWidth,
                decoration: BoxDecoration(
                  color: w,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DriverInfoIcons(
                        imageUrl: "${widget.availableModel!.driverImage}",
                        driverName: "${widget.availableModel!.driverName}",
                        designation: "Driver",
                        rating: 4.2,
                        chatDriver: () {
                          goTo(
                              Chat(
                                availableModel: widget.availableModel!,
                                userModel: widget.userModel,
                              ),
                              context);
                        },
                        callDriver: () async {
                          var url = "tel:${widget.availableModel!.driverPhone}";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: systemWidth,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 100,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4.0),
                                          child: Icon(
                                            Icons.trip_origin,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            dashColor: primaryColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Icon(
                                            Icons.location_on,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.availableModel!.pickUpLoc}',
                                            style: Config.style(FontWeight.w400,
                                                const Color(0xff1E1D34), 12),
                                          )
                                        ],
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(),
                                        width: systemWidth / 1.2,
                                        child: const Divider(
                                          thickness: 0.8,
                                          color: textFaintColorGrey,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.availableModel!.dropOffLoc}',
                                            style: Config.style(FontWeight.w400,
                                                const Color(0xff1E1D34), 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RideViewDetailsTwo(
                              "${widget.availableModel!.carImage}",
                              widget.availableModel!.distanctText,
                              widget.availableModel!.durationText,
                              "${widget.availableModel!.vehiclePlateNo}",
                              widget.availableModel!.amount),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  goTo(const Payment(), context);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.account_balance_wallet,
                                          size: 25,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          'Payment',
                                          style: k12400Faint,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.share,
                                        size: 25,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        'Share',
                                        style: k12400Faint,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (textMsg == "Cancel") {
                                  cancel();
                                } else {
                                  ended("Ended");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  primary: pColor,
                                  fixedSize: const Size(400, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: (loading)
                                  ? const SpinKitWave(
                                      color: Colors.white,
                                      size: 30.0,
                                    )
                                  : Text(textMsg,
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDirection(
      LatLng pickUpLatLng, LatLng dropOffLatLng) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ProgressDialog(
              message: "Please wait...",
            ));

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints!);

    polylineCorOrdinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        polylineCorOrdinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polylineCorOrdinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newRideGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      position: pickUpLatLng,
      markerId: const MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: dropOffLatLng,
      markerId: const MarkerId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: const CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: const CircleId("dropOffId"),
    );

    setState(() {
      circleSet.add(pickUpLocCircle);
      circleSet.add(dropOffLocCircle);
    });
  }

  // void updateRideDetails() async {
  //   if (isRequestingDirection == false) {
  //     isRequestingDirection = true;

  //     if (myPostion == null) {
  //       return;
  //     }

  //     var posLatLng = LatLng(myPostion!.latitude, myPostion!.longitude);
  //     LatLng destinationLatLng;

  //     if (status == "accepted") {
  //       destinationLatLng =
  //           LatLng(widget.model!.pickUpLat, widget.model!.pickUpLong);
  //     } else {
  //       destinationLatLng =
  //           LatLng(widget.model!.dropOffLat, widget.model!.dropOffLong);
  //       ;
  //     }

  //     var directionDetails = await AssistantMethods.obtainPlaceDirectionDetails(
  //         posLatLng, destinationLatLng);
  //     if (directionDetails != null) {
  //       setState(() {
  //         durationRide = directionDetails.durationText!;
  //       });
  //     }

  //     isRequestingDirection = false;
  //   }
  // }

  void initTimer() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      durationCounter = durationCounter + 1;
    });
  }

  Future<void> cancel() async {
    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('${globalUrl}user/cancel-ride'));
    request.body = json.encode({
      "driverId": "${widget.availableModel!.driverId}",
      "ride_id": "${widget.availableModel!.id}",
      "riderId": "${Config.sharedPreferences!.getString('token')}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      if (!mounted) return;
      goTo(
          RiderHome(
            userModel2: widget.userModel2,
            userModel: widget.userModel,
          ),
          context);
    } else {
      print(response.reasonPhrase);
    }
  }

  checkRide() async {
    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('${globalUrl}user/check-ride'));
    request.body = json.encode({
      "driverId": "${widget.availableModel!.driverId}",
      "ride_id": "${widget.availableModel!.id}",
      "riderId": "${Config.sharedPreferences!.getString('token')}"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
      var resp = jsonDecode(res);
      if (resp['status'] == 'Accepted') {
        timer?.cancel();

        dialog('Ride Request has been Accepted', 'Accepted');

        return;
      }
      if (resp['status'] == 'Cancelled') {
        timer?.cancel();

        dialog('Ride Request has been cancelled', 'Cancelled');

        return;
      }
      if (resp['status'] == 'Arrived') {
        timer?.cancel();

        dialog('Driver has Arrived', 'Arrived');

        return;
      }

      if (resp['status'] == 'Ended') {
        timer?.cancel();
        dialog('Driver has ended the trip', 'Ended');

        return;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  dialog(text, status) {
    return showDialog(
        context: context,
        barrierDismissible: false, // <-- Set this to false.
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (status == 'Arrived' || status == 'Accepted') {
                                setState(() {
                                  textMsg = "End Ride";
                                });
                                Navigator.pop(context);
                                return;
                              }
                              if (status == 'Ended') {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Payment(
                                              userModel2: widget.userModel2,
                                              userModel: widget.userModel,
                                              availableModel:
                                                  widget.availableModel,
                                            )),
                                    (route) => false);
                                // ended(status);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: pColor,
                                fixedSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: (loading)
                                ? const SpinKitChasingDots(
                                    color: Colors.white,
                                  )
                                : Text("Ok",
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    )))),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<void> action(status) async {
    final url =
        '${globalUrl}user/change-action/$status/${widget.userModel!.id!}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);

    final body = json.decode(response.body);

    if (body['message'] == 'Success') {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => RiderHome(
                    userModel2: widget.userModel2,
                    userModel: widget.userModel,
                  )),
          (route) => false);
    }
  }

  Future<void> ended(status) async {
    final url =
        '${globalUrl}user/change-action/$status/${widget.userModel!.id!}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);
    // final body = json.decode(response.body);
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => Payment(
                  userModel2: widget.userModel2,
                  userModel: widget.userModel,
                  availableModel: widget.availableModel,
                )),
        (route) => false);
  }
}
