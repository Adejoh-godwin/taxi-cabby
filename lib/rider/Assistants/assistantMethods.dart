// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:cabby/rider/Models2/address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cabby/rider/Assistants/requestAssistant.dart';
import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/direct_details.dart';
import 'package:cabby/rider/config_maps.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    // String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    print(url);
    var response = await RequestAssistant.getRequest(url);
    print(response);
    print('object');
    if (response != 'failed') {
      placeAddress = response["results"][0]["formatted_address"];
      // st1 = response["results"][0]["address_components"][4]["long_name"];
      // st2 = response["results"][0]["address_components"][7]["long_name"];
      // st3 = response["results"][0]["address_components"][6]["long_name"];
      // st4 = response["results"][0]["address_components"][9]["long_name"];
      // placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      Address userPickUpAddress = Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      print('failed 2');
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    //in terms USD
    double timeTraveledFare = (directionDetails.durationValue! / 60) * 75;
    double distancTraveledFare = (directionDetails.distanceValue! / 1000) * 75;
    double totalFareAmount = timeTraveledFare + distancTraveledFare;

    //Local Currency
    //1$ = 160 RS
    //double totalLocalAmount = totalFareAmount * 160;

    return totalFareAmount.truncate();
  }

  static double createRandomNumber(int num) {
    var random = Random();
    int radNumber = random.nextInt(num);
    return radNumber.toDouble();
  }

  static sendNotificationToDriver(
      String token, context, String ride_request_id) async {
    var destionation =
        Provider.of<AppData>(context, listen: false).dropOffLocation;
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverToken,
    };

    Map notificationMap = {
      'body': 'DropOff Address,',
      'title': 'New Ride Request'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_request_id': ride_request_id,
    };

    Map sendNotificationMap = {
      "notification": notificationMap,
      "data": dataMap,
      "priority": "high",
      "to": token,
    };

    var res = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerMap,
      body: jsonEncode(sendNotificationMap),
    );
    print(res.body);
    print('new');
  }

  //history

  // static void retrieveHistoryInfo(context) {
  //   //retrieve and display Trip History
  //   rideRequestRef
  //       .orderByChild("rider_name")
  //       .once()
  //       .then((DataSnapshot dataSnapshot) {
  //     if (dataSnapshot.value != null) {
  //       //update total number of trip counts to provider
  //       Map<dynamic, dynamic> keys = dataSnapshot.value;
  //       int tripCounter = keys.length;
  //       Provider.of<AppData>(context, listen: false)
  //           .updateTripsCounter(tripCounter);

  //       //update trip keys to provider
  //       List<String> tripHistoryKeys = [];
  //       keys.forEach((key, value) {
  //         tripHistoryKeys.add(key);
  //       });
  //       Provider.of<AppData>(context, listen: false)
  //           .updateTripKeys(tripHistoryKeys);
  //       obtainTripRequestsHistoryData(context);
  //     }
  //   });
  // }

  // static void obtainTripRequestsHistoryData(context) {
  //   var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;

  //   for (String key in keys) {
  //     rideRequestRef.child(key).once().then((DataSnapshot snapshot) {
  //       if (snapshot.value != null) {
  //         rideRequestRef
  //             .child(key)
  //             .child("rider_name")
  //             .once()
  //             .then((DataSnapshot snap) {
  //           String name = snap.value.toString();
  //           if (name == userCurrentInfo!.name) {
  //             var history = History.fromSnapshot(snapshot);
  //             Provider.of<AppData>(context, listen: false)
  //                 .updateTripHistoryData(history);
  //           }
  //         });
  //       }
  //     });
  //   }
  // }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }

  static Future<dynamic> getRequest(String url, data) async {
    print(url);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print(res);
      return jsonDecode(res);
      //return res;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<dynamic> get(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var decodeData = jsonDecode(jsonData);
      print(response.body);
      return decodeData;
    } else {
      return "failed";
    }
  }
}
