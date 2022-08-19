// import 'dart:convert';
// import 'dart:math';
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:http/http.dart' as http;
// import 'package:cabby/driver/Models/allUsers.dart';
// import 'package:cabby/driver/configMaps.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// //import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';

// class Config {
//   static todayDate(date) {
//     var formatter = DateFormat('dd-MM-yyyy');
//     // String formattedTime = DateFormat('kk:mm:a').format(date);
//     String formattedDate = formatter.format(date);

//     return (formattedDate);
//   }

//   Color? pColor = const Color(0xffC9C900);

//   static const String PAYSTACK_KEY =
//       "pk_test_0b4931121ee630abc05b850f06924f9fb7e234c2";

//   static User? user;
//   static FirebaseAuth? auth;
//   static FirebaseFirestore? firestore;

//   static String globalUrl = 'http://192.168.1.241/laravel/zeus/apicall/';

// // static String globalUrl = 'https://zeusapi.envio.com.ng/';

//   static CollectionReference users =
//       FirebaseFirestore.instance.collection('users');

//   static svg(assets, height, color) {
//     return SvgPicture.asset(
//       assets,
//       height: height.toDouble(),
//       color: (color == '') ? null : color,
//     );
//   }

//   String title = "";
//   double starCounter = 0.0;

//   String rideType = "";

//   static style(fontWeight, Color color, size) {
//     return GoogleFonts.lato(
//         textStyle: TextStyle(
//             fontWeight: fontWeight, fontSize: size.toDouble(), color: color));
//   }
// }

// CollectionReference customers =
//     FirebaseFirestore.instance.collection('customers');

// CollectionReference drivers = FirebaseFirestore.instance.collection('drivers');

// CollectionReference rideRequestRef = FirebaseFirestore.instance
//     .collection("drivers")
//     .doc(currentfirebaseUser!.uid)
//     .collection("newRide");

// Position? currentPosition;
// String mapKey = "AIzaSyDXua-cpwWEOGI5sekYuVRS2qEPEwT_pCo";
// // ignore: unused_element
// FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// User? firebaseUser;

// UserModel? driverCurrentInfo;
// //CustomerModel? userCurrentInfo;

// StreamSubscription<Position>? rideStreamSubscription;

// UserModel? driversInformation;
// displayToastMessage(String message, context) {
//   Fluttertoast.showToast(msg: message);
// }

// random(min, max) {
//   var rn = Random();
//   return min + rn.nextInt(max - min);
// }

// numformat(number) {
//   return NumberFormat.currency(name: 'NGN ').format(number).toString();
// }

// goToReplacement(Widget page, BuildContext context) {
//   Navigator.of(context).pushReplacement(_createRoute(page));
// }

// goTo(Widget page, BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) {
//         return page;
//       },
//     ),
//   );
// }

// Route _createRoute(nav) {
//   return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => nav,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var begin = const Offset(0.0, 1.0);
//         var end = Offset.zero;
//         var curve = Curves.ease;

//         var tween = Tween(begin: begin, end: end);
//         var curvedAnimation = CurvedAnimation(
//           parent: animation,
//           curve: curve,
//         );

//         return SlideTransition(
//           position: tween.animate(curvedAnimation),
//           child: child,
//         );
//       });
// }

// String globalUrl = 'https://api-cabby.raadaa.com/api/';


// Future<UserModel> startLoginNow(String token, context) async {
//   String apiurl = "https://api.cabby.raadaa.com/api/user/";
//   var response = await http.get(Uri.parse(apiurl), headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $token',
//   }).timeout(const Duration(seconds: 15));

//   var jsondata = json.decode(response.body);

//   final userModel = UserModel.fromJson(jsondata);
//   return userModel;
// }

// void show(context, Widget widget) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return widget;
//       });
// }

// final assetsAudioPlayer = AssetsAudioPlayer();

// backButton(context) {
//   return IconButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       icon: const Icon(Icons.arrow_back));
// }
