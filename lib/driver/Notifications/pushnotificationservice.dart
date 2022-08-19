// ignore_for_file: avoid_print

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/Models/available_model.dart';
import 'package:cabby/driver/home/map/map_screen.dart';
import 'package:cabby/driver/widget/popup.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PushNotificationService {
  final UserModel userModel;
  final UserModel userModel2;
  final BuildContext context;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  PushNotificationService(this.userModel, this.userModel2, this.context);

  Future initialize(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(" recieved");
      print(event.notification!.body);
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

    //FirebaseMessaging.onBackgroundMessage(_messageHandler);
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
    final url = '${globalUrl}get-ride/$id';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
    });
    print(response.body);
    final body = json.decode(response.body);
    print(body['status']);

    if (body['status'] == 'Booked') {
      final AvailableModel model =
          AvailableModel.fromJson(json.decode(response.body));

      assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
      assetsAudioPlayer.play();

      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async => false,
                child: NewRide(
                    userModel: userModel,
                    userModel2: userModel2,
                    model: model));
          });
    }

    if (body['status'] == 'Cancelled') {
      dialog('Ride Request has been cancelled', 'Cancelled', context);

      return;
    }

    if (body['status'] == 'Ended') {
      dialog('Rider has ended the trip', 'Ended', context);

      return;
    }
        if (body['message'] == 'Empty') {
      dialog('Ride is no longer available', 'Ended', context);

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
                          style: const TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              action(status, context);
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
    if(status == 'Empty'){
       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => MapScreen(
                    userModel2: userModel2,
                    userModel: userModel,
                  )),
          (route) => false);
    }
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
              builder: (_) => MapScreen(
                    userModel2: userModel2,
                    userModel: userModel,
                  )),
          (route) => false);
    }
  }
}
