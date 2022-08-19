// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:cabby/driver/Models/notification.dart';
import 'package:cabby/driver/Models/ridehistory.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:http/http.dart' as http;

class ActivityApi {
  static Future<List<NotificationModel>> getNotification(userId) async {
    var url = '${globalUrl}notification/' + userId;
    print(url);
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    return body.map<NotificationModel>(NotificationModel.fromJson).toList();
  }

  static Future<List<RideModel>> getToday(userId, context, dat) async {
    var url = '${globalUrl + 'rideHistoryToday/' + userId}/driverId/' + dat;
    print(url);
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    //TODO: trips counter

    return body.map<RideModel>(RideModel.fromJson).toList();
  }

  static Future<List<RideModel>> getRide(userId, context, token) async {
    var url = '${'${globalUrl}driver/ride-history/' + userId}/driverId';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(response.body);

    //TODO: trips counter

    return body.map<RideModel>(RideModel.fromJson).toList();
  }

  static Future<List<RideModel>> getWeek(userId, context) async {
    var url = '${'${globalUrl}rideHistoryWeek/' + userId}/driverId';
    print(url);

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body.map<RideModel>(RideModel.fromJson).toList();
  }

  // static Future<List<TransactionModel>> getTransaction(userId) async {
  //   var data = {'id': userId};
  //   const url = 'https://alphaapi.envio.com.ng/fetchTransaction.php';
  //   final response = await http.post(Uri.parse(url), body: json.encode(data));
  //   final body = json.decode(response.body);
  //   return body.map<TransactionModel>(TransactionModel.fromJson).toList();
  // }

  // static Future<List<UserModel>> getUser(userId) async {
  //   var data = {'id': userId};
  //   const url = 'https://alphaapi.envio.com.ng/fetchUser.php';
  //   final response = await http.post(Uri.parse(url), body: json.encode(data));
  //
  //   final body = json.decode(response.body);
  //   return body.map<UserModel>(UserModel.fromJson).toList();
  // }
}
