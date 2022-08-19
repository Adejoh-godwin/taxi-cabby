// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'dart:convert';
import 'package:cabby/rider/auth/splashscreen.dart';
import 'package:cabby/rider/home/message/chat.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

BuildContext? context;
Future<void> _messageHandler(RemoteMessage message) async {
  print("message ");
  print(message.notification!.body);
  print(message.data['riderId']);

  //  print(message.data.values);
  //getRide(message.data['rideId'], context);
}

// Future<void> getRide(id, context) async {
//   final url = globalUrl + 'get-ride/' + id!;
//   print(url);

//   final response = await http.get(Uri.parse(url), headers: {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
//   });
//   print(response.body);
//   final body = json.decode(response.body);
//   print(body['status']);

//   // if (body['status'] == 'Booked') {
//   final AvailableModel? model =
//       AvailableModel.fromJson(json.decode(response.body));

//   assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
//   assetsAudioPlayer.play();
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return WillPopScope(
//             onWillPop: () async => false,
//             child: NewRide(
//                 userModel: userModel, userModel2: userModel2, model: model));
//       });
//   // }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  Config.auth = FirebaseAuth.instance;
  // String? token = await FirebaseMessaging.instance.getToken();
  Config.sharedPreferences = await SharedPreferences.getInstance();

  Config.firestore = FirebaseFirestore.instance;

  Config.sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");
DatabaseReference driversRef =
    FirebaseDatabase.instance.reference().child("drivers");
DatabaseReference rideRequestRef =
    FirebaseDatabase.instance.reference().child("Ride Requests");

DatabaseReference newRequestsRef =
    FirebaseDatabase.instance.reference().child("Ride Requests");

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _navKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    updaeCheck(context);
  }

  @override
  Widget build(BuildContext context) {
    //Config.sharedPreferences!.getString('userId');
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(home: Splash());
          } else {
            // Loading is done, return the app:
            return ChangeNotifierProvider(
              create: (context) => AppData(),
              child:
                  ResponsiveSizer(builder: (context, orientation, screenType) {
                return MaterialApp(
                    navigatorKey: _navKey,
                    debugShowCheckedModeBanner: false,
                    title: 'Taxi Cabby',
                    theme: ThemeData(
                      scaffoldBackgroundColor: Colors.grey.shade300,
                      colorScheme:
                          ColorScheme.fromSwatch(primarySwatch: Colors.red)
                              .copyWith(secondary: Colors.indigo),
                    ),
                    // home: Payment(
                    //   availableModel: AvailableModel(
                    //       id: "90",
                    //       driverId: "080486b1-4b5b-4eee-855a-0923d183d270",
                    //       driverName: "Adejoh ",
                    //       driverImage:
                    //           "https://firebasestorage.googleapis.com/v0/b/taxi-cabby-map1.appspot.com/o/1657783169287?alt=media&token=14ede576-e79c-49e1-a03d-3d46272b817e"),
                    //   userModel2: RiderUserModel(),
                    //   userModel: RiderUserModel(
                    //       id: "0a36d7a2-6729-4cec-b262-c7371746de5f"),
                    // ),

                    home: const SplashScreen());
              }),
            );
          }
        });
  }

  updaeCheck(context) async {
    // BuildContext? context;
    // Check internet connection with created instance
    await internetCheck(context);
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      // String appName = packageInfo.appName;
      // String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      // String buildNumber = packageInfo.buildNumber;
      // print('object');
      // print(version);
      var deviceId;
      if (Platform.isIOS) {
        // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId = androidDeviceInfo.androidId; // unique ID on Android
      }
      var url = '${globalUrl}update-check/$deviceId/$version';
      // print(url);
      var response = await http.get(Uri.parse(url));
      // print(response.body);
      var jsonData = response.body;
      var decodeData = jsonDecode(jsonData);
      if (decodeData['response']) {
        // displayToastMessage('message', context);
        showDialog(
          context: context!,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
                child: Platform.isAndroid
                    ? AlertDialog(
                        title: const Text("New Update"),
                        content: const Text(
                            "A new update is available please update the app"),
                        actions: [
                          TextButton(
                            child: const Text("Update Now"),
                            onPressed: () {
                              launchAppStore(
                                  'https://play.google.com/store/apps/details?id=com.taxi_cabby.cabby');
                            },
                          )
                        ],
                      )
                    : CupertinoAlertDialog(
                        title: const Text("New Update"),
                        content: const Text(
                            "A new update is available please update the app"),
                        actions: [
                          TextButton(
                            child: const Text("Update Now"),
                            onPressed: () {
                              launchAppStore(
                                  'https://play.google.com/store/apps/details?id=com.taxi_cabby.cabby');
                            },
                          )
                        ],
                      ),
                onWillPop: () => Future.value(false));
          },
        );
      } else {}
    } catch (e) {
      print(e);
      // displayToastMessage('', context);
    }
  }

  Future<void> launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    if (await canLaunchUrl(Uri.parse(appStoreLink))) {
      launchUrl(Uri.parse(appStoreLink));
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffe1f5fe).withOpacity(1.0),
      body: Center(child: Image.asset('assets/svg/logo.png')),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {}
}
