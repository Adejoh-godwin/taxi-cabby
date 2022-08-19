// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/Models2/coupon_model.dart';
import 'package:cabby/rider/Models2/faq.dart';
import 'package:cabby/rider/Models2/moneymodel.dart';
import 'package:cabby/rider/Models2/notification.dart';
import 'package:cabby/rider/Models2/ridehistory.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ActivityApi {
  static Future<List<NotificationModel>> getNotification(userId, token) async {
    var url = globalUrl + 'notification/' + userId;
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(response.body);


    return body.map<NotificationModel>(NotificationModel.fromJson).toList();
  }

  static Future<List<RideModel>> getToday(userId, context, token) async {
    var url = globalUrl + 'rideHistoryToday/' + userId + '/riderId/' + token;
    print(url);
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    //TODO: trips counter

    return body.map<RideModel>(RideModel.fromJson).toList();
  }

  static Future<List<RideModel>> getRide(userId, context, token) async {
    var url = globalUrl + 'user/ride-history/' + userId + '/riderId';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    final body = json.decode(response.body);

    return body.map<RideModel>(RideModel.fromJson).toList();
  }

  static Future<List<MoneyModel>> getPayHisory(userId, context, token) async {
    var url = '${globalUrl}user/pay-history/$userId';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final body = json.decode(response.body);

    return body.map<MoneyModel>(MoneyModel.fromJson).toList();
  }

  static Future<List<AvailableModel>> getAvailable(
      classOfRide, context, rideType, token) async {
    var url =
        globalUrl + 'user/available-driver/' + classOfRide + "/" + rideType;
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });

    final body = json.decode(response.body);

    return body.map<AvailableModel>(AvailableModel.fromJson).toList();
  }

  static Future<List<AvailableModel>> getAvailable2(
      classOfRide, context, rideType) async {
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;
    var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var data = {
      "pickUpLatitude": "${pickUp!.latitude}",
      "pickUpLongitude": "${pickUp.longitude}",
      "dropOffLatitude": "${dropOff!.latitude}",
      "dropOffLongitude": "${dropOff.longitude}",
      "class": classOfRide,
      "ridetype": rideType,
      "riderId": Config.sharedPreferences!.get('id')
    };

    print(jsonEncode(data));

    var request =
        http.Request('POST', Uri.parse('${globalUrl}user/available-driver'));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    print(body);
    
    return jsonDecode(body)
        .map<AvailableModel>(AvailableModel.fromJson)
        .toList();
  }

  static Future<List<RideModel>> getWeek(userId, context) async {
    var url = globalUrl + 'rideHistoryWeek/' + userId + '/driverId';
    print(url);
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body.map<RideModel>(RideModel.fromJson).toList();
  }

  static Future<List<FaqModel>> getFaq() async {
    var url = globalUrl + 'faq';
    print(url);
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);

    return body.map<FaqModel>(FaqModel.fromJson).toList();
  }

  static Future<List<CouponModel>> getCoupon() async {
    var url = globalUrl + 'coupon';
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.body);

    final body = json.decode(response.body);

    return body.map<CouponModel>(CouponModel.fromJson).toList();
  }
}
