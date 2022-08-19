// ignore_for_file: avoid_print, must_be_immutable

import 'dart:async';
import 'package:cabby/driver/Assistants/assistant_methods.dart';
import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/Notifications/pushnotificationservice.dart';

import 'package:cabby/driver/home/destination.dart';
import 'package:cabby/driver/widget/constant.dart' as constant;
import 'package:cabby/driver/widget/mydrawer.dart';
import 'package:cabby/driver/widget/popup.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  UserModel? userModel;
  UserModel? userModel2;
  String? token;

  MapScreen(
      {Key? key, required this.userModel, required this.userModel2, this.token})
      : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  UserModel? model;
  Timer? timer;

  Completer<GoogleMapController> controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 200.0;
  double driverDetailsContainerHeight = 0;

  bool drawerOpen = true;
  bool nearbyAvailableDriverKeysLoaded = false;

  bool isRequestingPositionDetails = false;

  String? balance = '00';
  int? cancel = 0;
  int? rating = 0;
  int? acceptance = 0;

  String uName = "";
  dynamic todayAmt = 0;
  dynamic todayDate = "";
  dynamic todayTrip = 0;
  //getting the account balance

  var driverStat = 'You are offline';
  var driverAction = 'Go';
  bool driverAvailable = false;

  @override
  void initState() {
    today();
    // if (onlineStatus == 'online') {
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      goOnline2();
      print('checked');
    });
    //}
    //WidgetsBinding.instance?.addPostFrameCallback((_) => show());

    super.initState();

    // AssistantMethods.getCurrentOnlineDriverInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //this help change go to stop

  var onlineStatus = 'offline';
  //TODO: hours onlibe

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
    pushNotificationService.getToken();

    //initGeoFireListner();

    //uName = userCurrentInfo!.name!;

    // AssistantMethods.retrieveHistoryInfo(context);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;
    //createIconMarker();

    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(
        userModel: widget.userModel,
        userModel2: widget.userModel2,
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller) {
              controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              locatePosition();
            },
          ),

          //HamburgerButton for Drawer
          Positioned(
            top: 36.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                if (drawerOpen) {
                  scaffoldKey.currentState!.openDrawer();
                } else {
                  //resetApp();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: Icon(
                    (drawerOpen) ? Icons.menu : Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            right: mediaWidth * 0.35,
            child: GestureDetector(
              onTap: () {
                showWallet(balance, '7th Nove', '11');
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: constant.sColor,
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: RichText(
                  text: TextSpan(
                      text: 'NGN ',
                      style: Config.style(FontWeight.bold, Colors.white, 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${widget.userModel2!.acctBal}',
                          style: Config.style(FontWeight.bold, pColor, 14),
                        ),
                      ]),
                ),
              ),
            ),
          ),

          //Search Ui
          onlineStack(driverAction, driverStat),
        ],
      ),
    );
  }

  onlineStack(text1, text2) {
    //Search Ui
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: AnimatedSize(
        // vsync: this,
        curve: Curves.bounceIn,
        duration: const Duration(milliseconds: 160),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (widget.userModel!.image == null ||
                    widget.userModel!.image == "null") {
                  displayToastMessage("Upload Image ", context);
                  return;
                }
                goOnline();
              },
              child: CircleAvatar(
                backgroundColor: (onlineStatus == 'offline')
                    ? pColor
                    : (onlineStatus == 'loading')
                        ? Colors.amber[300]
                        : Colors.red,
                radius: 29,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: CircleAvatar(
                    backgroundColor: (onlineStatus == 'offline')
                        ? pColor
                        : (onlineStatus == 'loading')
                            ? Colors.amber[300]
                            : Colors.red,
                    radius: 22,
                    child: (onlineStatus == 'loading')
                        ? const SpinKitChasingDots(
                            size: 24,
                            color: Colors.white,
                          )
                        : Text(
                            text1,
                            style:
                                Config.style(FontWeight.bold, Colors.white, 18),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: searchContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        const Icon(Icons.wifi),
                        Text((onlineStatus != 'loading')
                            ? 'You are $onlineStatus'
                            : " $onlineStatus"),
                        const Expanded(child: SizedBox(width: 5)),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Destination())),
                        ),
                      ],
                    ),
                    // Center(
                    //   child: RichText(
                    //     text: TextSpan(
                    //         text: 'Hours Online ',
                    //         style:
                    //             Config.style(FontWeight.bold, textColor!, 16),
                    //         children: <TextSpan>[
                    //           TextSpan(
                    //             text: 'coming soon',
                    //             style:
                    //                 Config.style(FontWeight.bold, sColor!, 18),
                    //           ),
                    //         ]),
                    //   ),
                    // ),
                    const Divider(),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: pColor,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${widget.userModel!.acceptance}%',
                                style: Config.style(
                                    FontWeight.bold, constant.sColor!, 15),
                              ),
                              const Text('Acceptance'),
                            ],
                          )),
                          const VerticalDivider(),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: pColor,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${widget.userModel!.rating}%',
                                style: Config.style(
                                    FontWeight.bold, constant.sColor!, 15),
                              ),
                              const Text('Cancel'),
                            ],
                          )),
                          const VerticalDivider(),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.star,
                                color: pColor,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${widget.userModel!.rating}%',
                                style: Config.style(
                                    FontWeight.bold, constant.sColor!, 15),
                              ),
                              const Text('Rating'),
                            ],
                          )),
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

  goOnline() async {
    // if (double.parse(widget.userModel2!.acctBal) < 200) {
    //   displayToastMessage('Account is low, fund your wallet', context);
    //   return;
    // }

    if (onlineStatus == 'offline') {
      setState(() {
        onlineStatus = "loading";
      });
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var url = "${globalUrl}driver/go-online";
      print(url);
      var data = {
        "userId": widget.userModel!.id,
        'longitude': position.longitude,
        'latitude': position.latitude
      };
      print(jsonEncode(data));
      var response = await AssistantMethods.getRequestToken(
          url, data, widget.userModel2!.token);

      print(response);
      setState(() {
        onlineStatus = 'online';
        driverAction = 'Stop';
      });
      // checkForRide();
    } else if (onlineStatus == 'online') {
      //deletinf the driver from avaliable drivers
      var url = "${globalUrl}driver/go-offline";
      var data = {
        "userId": widget.userModel!.id,
      };

      AssistantMethods.getRequestToken(url, data, widget.userModel2!.token);
      // if (response['statusCode'] == 402) {
      // displayToastMessage("An error occured", context);
      setState(() {
        onlineStatus = 'offline';
        driverAction = 'Go';
      });
      // }
    } else if (onlineStatus == 'loading') {
      setState(() {
        onlineStatus = 'offline';
        driverAction = 'Go';
      });
    }
  }

  // void getLocationLiveUpdates() {
  //   homeTabPageStreamSubscription =
  //       Geolocator.getPositionStream().listen((Position position) {
  //     currentPosition = position;
  //     if (driverAvailable == true) {
  //       Geofire.setLocation(
  //           currentfirebaseUser!.uid, position.latitude, position.longitude);
  //     }
  //     LatLng latLng = LatLng(position.latitude, position.longitude);
  //     newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
  //   });
  // }

  void showWallet(amount, date, trips) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WalletPop(
            userModel: widget.userModel,
            userModel2: widget.userModel2,
            text1: todayAmt,
            text2: 'Today $todayDate',
            text3: '$todayTrip Trips completed',
          );
        });
  }

  void newRide(model) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: NewRide(
                  userModel: widget.userModel,
                  userModel2: widget.userModel2,
                  model: model));
        });
  }

  Future<void> today() async {
    print('ssss');
    final url = '${globalUrl}driver/today/${widget.userModel!.id!}';
    // print(widget.userModel2!.token);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);
    final body = json.decode(response.body);

    print(body);
    setState(() {
      todayAmt = body['tm'];
      todayTrip = body['tp'];
      todayDate = body['day'];
    });
  }

  Future<void> acceeptRide() async {
    final url = '${globalUrl}driver/accept-ride/${widget.userModel!.id!}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);
    final body = json.decode(response.body);
    if (!mounted) return;
    if (body['reponse'] == 'empty') {
      displayToastMessage('An erro occured', context);
      return;
    }
    displayToastMessage('Ride has been cancelled', context);

    return newRide(model);

    // setState(() {
    //   todayAmt = body['tm'];
    //   todayTrip = body['tp'];
    //   todayDate = body['day'];
    // });
  }

  dialog(text, status) {
    return showDialog(
        context: context,
        barrierDismissible: false, // <-- Set this to false.
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                backgroundColor: Colors.black54,
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
                              action(status);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: pColor,
                                fixedSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: Text("Ok",
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
        '${globalUrl}driver/change-action/$status/${widget.userModel!.id!}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    // print(response.body);
    final body = json.decode(response.body);
    if (!mounted) return;

    if (body['message'] == 'Success') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => MapScreen(
                    userModel2: widget.userModel2,
                    userModel: widget.userModel,
                  )),
          (route) => false);
    }
  }

  void goOnline2() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var url = "${globalUrl}driver/go-online";
    print(url);
    var data = {
      "userId": widget.userModel!.id,
      'longitude': position.longitude,
      'latitude': position.latitude
    };
    print(jsonEncode(data));
    var response = await AssistantMethods.getRequestToken(
        url, data, widget.userModel2!.token);
    if (!mounted) return;
    print(response);
    setState(() {
      onlineStatus = 'online';
      driverAction = 'Stop';
    });
  }
}
