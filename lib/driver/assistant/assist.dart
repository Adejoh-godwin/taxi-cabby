// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/Models/direct_details.dart';
import 'package:cabby/driver/assistant/request_assistant.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssistantMethods {
  static sendNotification(String token, context, String docid) async {
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization':
          'AAAAjuJz4Ek:APA91bG3Su2WNxxVU6AEnjrhjslxMQOYqbKh9baFkVotwGnOs9G_BqtpTBUf-zPjkfyC8i5729774d7WlGLe5Ahi3PETQfZwoJVln6-_sdCgsXotYk7e0HV_uXrHUdKMq8EBcfK-AjT',
    };

    Map notificationMap = {
      'body': 'Please Verify this car',
      'title': 'New Inspect/Installation'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_request_id': docid,
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
    print(res);
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }

  static Future<dynamic> getRequest(String url, data) async {
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);

        return decodeData;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
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

  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    // String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      print(response);
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

  static Future<dynamic> newr(data) async {
    // var headers = {
    //   // 'Authorization': 'Bearer 17|qc8GHXLTY8YkAS0LRbn7gESwNNHSZ64zeimtyjco',
    //   'Content-Type': 'application/json'
    // };
    var request = http.Request(
        'POST', Uri.parse('https://api.cabby.raadaa.com/api/register'));
    request.body = json.encode({data});
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  currentUser(context) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    var token = shared.getString('token');
    try {
      String apiurl = "https://api.cabby.raadaa.com/api/user/";
      var response = await http.get(Uri.parse(apiurl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        print(jsondata);
        final userModel = UserModel.fromJson(jsondata);

        print(userModel.name);
      }
    } catch (e) {
      print('not fecthed');
      //DialogBuilderMode(context).hideOpenDialog();

      print(e);
    }
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
}
