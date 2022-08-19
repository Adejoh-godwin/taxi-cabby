// ignore_for_file: avoid_print

import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/rider_home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PushNotificationService {
  final RiderUserModel userModel;
  final RiderUserModel userModel2;
  final BuildContext context;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  PushNotificationService(this.userModel, this.userModel2, this.context);

  Future initialize(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // print(" recieved");
      print(event.notification!.body);
      // displayToastMessage("Ride has been accepted", context);
      print(event.data['riderId']);

      getRide(event.data['rideId'], context);

      //retrieveRideRequestInfo(getRideRequestId(event), context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print("message ");
      print(event.notification!.body);
      print(event.data['riderId']);

      //  print(event.data.values);
      getRide(event.data['rideId'], context);
      //retrieveRideRequestInfo(getRideRequestId(event), context);
    });

    FirebaseMessaging.onBackgroundMessage(messageHandler);
  }

  getToken() async {
    String? token = await firebaseMessaging.getToken();
    print("This is token :: ");
    print(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    firebaseMessaging.subscribeToTopic("allusers");
  }

  Future<void> messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');

    // retrieveRideRequestInfo(getRideRequestId(message), context);
  }

  String getRideRequestId(RemoteMessage message) {
    String rideRequestId = "";
    if (Platform.isAndroid) {
      rideRequestId = message.data['ride_request_id'];
    } else {
      rideRequestId = message.data['ride_request_id'];
    }

    return rideRequestId;
  }

  Future<void> getRide(id, context) async {
    // ignore: prefer_interpolation_to_compose_strings
    final url = '${globalUrl}get-ride/' + id!;
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
    });
    print(response.body);
    final body = json.decode(response.body);

    var availableModel = AvailableModel.fromJson(body);
    print(body['status']);

    if (body['status'] == 'Cancelled') {
      displayToastMessage('Ride Request has been cancelled', context);
      goToReplacement(
          RiderHome(
            userModel2: userModel2,
            userModel: userModel,
          ),
          context);
      return;
    }

    if (body['status'] == 'Ended') {
      displayToastMessage('Rider has ended the trip', context);
      goToReplacement(
          RiderHome(
            userModel2: userModel2,
            userModel: userModel,
          ),
          context);
      return;
    }

    if (body['status'] == 'Accepted') {
      // goTo(
      //     AcceptedRide(
      //       userModel2: userModel2,
      //       availableModel: availableModel,
      //       userModel: userModel,
      //     ),
      //     context);
      // displayToastMessage('Driver has accepted your request', context);

      dialog('', 'Accepted', context);
    }
    if (body['status'] == 'Arrived') {
      displayToastMessage('Driver has arrived ', context);
    }
    if (body['message'] == 'Empty') {
      displayToastMessage('Ride is no longer available', context);
      goToReplacement(
          RiderHome(
            userModel2: userModel2,
            userModel: userModel,
          ),
          context);
      return;
    }
  }

  dialog(text, status, context) {
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
                              Navigator.pop(context);
                              // action(status, context);
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

  Future<void> action(status, context) async {
    final url = '${globalUrl}driver/change-action/$status/${userModel.id!}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userModel2.token}',
    });
    // print(response.body);
    final body = json.decode(response.body);
    if (body['message'] == 'Success') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => RiderHome(
                    userModel2: userModel2,
                    userModel: userModel,
                  )),
          (route) => false);
    }
  }
}
