// ignore_for_file: avoid_print

import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/address.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cabby/driver/Assistants/request_assistant.dart';
import 'package:cabby/driver/Models/direct_details.dart';
import 'package:cabby/driver/config_maps.dart';
import 'dart:convert';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AssistantMethods {
  static Future<DirectionDetails> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {}

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
    double timeTraveledFare = (directionDetails.durationValue! / 60) * 0.20;
    double distancTraveledFare =
        (directionDetails.distanceValue! / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distancTraveledFare;

    //Local Currency
    //1$ = 160 RS
    //double totalLocalAmount = totalFareAmount * 160;
    if (rideType == "uber-x") {
      double result = (totalFareAmount.truncate()) * 2.0;
      return result.truncate();
    } else if (rideType == "uber-go") {
      return totalFareAmount.truncate();
    } else if (rideType == "bike") {
      double result = (totalFareAmount.truncate()) / 2.0;
      return result.truncate();
    } else {
      return totalFareAmount.truncate();
    }
  }

  static void disableHomeTabLiveLocationUpdates() {
    homeTabPageStreamSubscription!.pause();
    Geofire.removeLocation(currentfirebaseUser!.uid);
  }

  static void enableHomeTabLiveLocationUpdates() {
    homeTabPageStreamSubscription!.resume();
    Geofire.setLocation(currentfirebaseUser!.uid, currentPosition!.latitude,
        currentPosition!.longitude);
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }

  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    // String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

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

  static double createRandomNumber(int num) {
    var random = Random();
    int radNumber = random.nextInt(num);
    return radNumber.toDouble();
  }

  static Future<dynamic> getRequest(String url, data) async {
    var headers = {
      'Authorization': 'Bearer 21|q4Y5mKorWFlXzuc6OxDJUqgGQuk0Z5tV3WT48KFW',
      'Content-Type': 'application/json'
    };

    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    print(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        String jsonData = response.body;
        // print(jsonData);
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
    }
  }

  static getRequestToken(String url, data, token) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));

    print(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        String jsonData = response.body;
        print(jsonData);
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
    }
  }

  static Future<dynamic> getRequest2(String url, data) async {
    var headers = {
      'Authorization': 'Bearer 21|q4Y5mKorWFlXzuc6OxDJUqgGQuk0Z5tV3WT48KFW',
      'Content-Type': 'application/json'
    };

    // 09059059233
    print(url);
    // masudabdullahi2017@gmail.com

    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
      return jsonDecode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<dynamic> getRequest3(String url, data) async {
    var headers = {
      'Authorization': 'Bearer 21|q4Y5mKorWFlXzuc6OxDJUqgGQuk0Z5tV3WT48KFW',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.cabby.raadaa.com/api/verify-otp'));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(await response.stream.bytesToString());

    if (response.statusCode == 200 || response.statusCode == 401) {
      var res = jsonDecode(await response.stream.bytesToString());
      return res;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<dynamic> get(String url) async {
    var response = await http.post(Uri.parse(url));
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
