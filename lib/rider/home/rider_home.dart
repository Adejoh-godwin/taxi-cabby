// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:cabby/rider/Notifications/pushnotificationservice.dart';
import 'package:http/http.dart' as http;
import 'package:cabby/driver/widget/shared/widgets/destination.dart';
import 'package:cabby/rider/AllWidgets/mydrawer.dart';
import 'package:cabby/rider/AllWidgets/progressDialog.dart';
import 'package:cabby/rider/Assistants/assistantMethods.dart';
import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/Models2/direct_details.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/cancelride.dart';
import 'package:cabby/rider/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cabby/rider/home/savedplaces.dart';
import 'package:provider/provider.dart';

class RiderHome extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const RiderHome({Key? key, this.userModel, this.userModel2})
      : super(key: key);
  @override
  RiderHomeState createState() => RiderHomeState();
}

class RiderHomeState extends State<RiderHome> {
  double listenPercent = 0.0;
  var currentSelectedValueThree = "Intra-city";
  final List<String> typeOfRide = [
    "Intra-city",
    "Inter-city",
  ];
  double systemHeight = 0;

  double systemWidth = 0;

  DirectionDetails? tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  //final UserProfileService _userProfileService = UserProfileService();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    if (!mounted) return;
    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: $address");

    if (!mounted) return;
    PushNotificationService pushNotificationService =
        PushNotificationService(widget.userModel!, widget.userModel2!, context);

    pushNotificationService.initialize(context);

    //initGeoFireListner();

    //uName = widget.userModel!.name!;

    // AssistantMethods.retrieveHistoryInfo(context);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  final LatLng center = const LatLng(45.521563, -122.677433);

  final GlobalKey _scaffoldKey = GlobalKey();
  var name = '';
  var email = '';
  var phoneNumber = '';
  Timer? timer;

  @override
  void initState() {
    // AssistantMethods.getCurrentOnlineCustomerInfo();
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      checkRide();
      print('checked');
    });
  }

  @override
  Widget build(BuildContext context) {
    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;

    if (widget.userModel?.name != null) {
      setState(() {
        name = widget.userModel!.name!;
        email = widget.userModel!.email!;
        phoneNumber = widget.userModel!.phone!;
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(
        userModel: widget.userModel,
        userModel2: widget.userModel2,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // image
            Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 0.3,
              child: GoogleMap(
                // padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,

                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                polylines: polylineSet,
                markers: markersSet,
                zoomControlsEnabled: false,
                circles: circlesSet,
                onMapCreated: (GoogleMapController controller) {
                  controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;

                  setState(() {
                    // bottomPaddingOfMap = 300.0;
                  });

                  locatePosition();
                },
              ),
            ),
            Positioned(
                left: 20,
                top: 20,
                child: Builder(
                  builder: (context) => InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Ensure Scaffold is in context
                )),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                // height: 200,
                width: systemWidth,
                decoration: BoxDecoration(
                  color: w,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 40,
                          color: Colors.grey,
                          height: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  'Good ${greeting()} , ${widget.userModel!.name}',
                                  style: Config.style(
                                      FontWeight.w700, sColor!, 14),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Set your destination address',
                                style: kOnboardDetail,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              DashMenu(
                                background: const Color(0xFFF5F1EB),
                                icon: Icons.search,
                                text: 'Search for destination',
                                textStyle: kMiniTitleSmall,
                                onTap: () async {
                                  if (currentSelectedValueThree ==
                                      'Please select ride type') {
                                    return displayToastMessage(
                                        'Please select ride type', context);
                                  }
                                  var res = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                              userModel: widget.userModel,
                                              userModel2: widget.userModel2,
                                              rideType:
                                                  currentSelectedValueThree)));

                                  if (res == "obtainDirection") {
                                    //  displayRideDetailsContainer();
                                    print('object');
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DashMenu(
                                background: const Color(0xFFFFFFFF),
                                icon: Icons.my_location_rounded,
                                text: 'Saved Places',
                                onTap: () {
                                  goTo(
                                      SavedPlaces(
                                        userModel: widget.userModel,
                                        userModel2: widget.userModel2,
                                      ),
                                      context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos!.latitude!, initialPos.longitude!);
    var dropOffLatLng = LatLng(finalPos!.latitude!, finalPos.longitude!);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Please wait...",
            ));

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details;
    });

    if (!mounted) {
      return;
    }

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints!);

    pLineCoordinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
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

    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow:
          InfoWindow(title: initialPos.placeName, snippet: "my Location"),
      position: pickUpLatLng,
      markerId: const MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: finalPos.placeName, snippet: "DropOff Location"),
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
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }

  checkRide() async {
    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('${globalUrl}user/check-ride-home'));
    request.body = json
        .encode({"riderId": "${Config.sharedPreferences!.getString('id')}"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
      var resp = jsonDecode(res);
      print(resp['status']);
      var availableModel = AvailableModel.fromJson(resp);
      if (resp['status'].toUpperCase() == 'ACCEPTED' ||
          resp['status'] == "Arrived") {
        // dialog('', 'Accepted', availableModel);
        timer?.cancel();
        if (!mounted) {
          return;
        }

        goTo(
            CancelRide(
              userModel2: widget.userModel2,
              availableModel: availableModel,
              userModel: widget.userModel,
            ),
            context);

        // dialog('', 'Accepted', availableModel);
      }

      return;
    } else {
      print(response.reasonPhrase);
    }
  }

  dialog(text, status, availableModel) {
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
                        const Text(
                          "You have an unfinished ride",
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              goTo(
                                  CancelRide(
                                    userModel2: widget.userModel2,
                                    availableModel: availableModel,
                                    userModel: widget.userModel,
                                  ),
                                  context);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: pColor,
                                fixedSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: Text("Goto ride",
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
}
