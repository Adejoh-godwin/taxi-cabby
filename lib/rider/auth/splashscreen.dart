// ignore_for_file: avoid_print

import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/home/map/map_screen.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/auth/Onboarding.dart';
import 'package:cabby/rider/auth/SelectUserType.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/rider_home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  bool nav = false;
  @override
  void initState() {
    super.initState();
    _navigateTo();
  }

  void _navigateTo() async {
    setState(() {
      nav = true;
    });
    var token = (Config.sharedPreferences!.getString('token'));
    var tk = (Config.sharedPreferences!.getString('id'));
    print(token);
    await Future.delayed(const Duration(milliseconds: 2000), () async {
      (Config.sharedPreferences!.getString('id') == 'null' ||
              Config.sharedPreferences!.getString('id') == null)
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const Onboarding(),
              ),
            )
          : login();
    });
  }

  double systemHeight = 0;
  double systemWidth = 0;
  @override
  Widget build(BuildContext context) {
    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: systemWidth,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: systemHeight / 3,
            child: Center(
              child: Image.asset(
                'assets/onboarding/logo.png',
                height: systemHeight / 3,
              ),
            ),
          ),
          (nav)
              ? Center(
                  child: SpinKitHourGlass(
                  color: pColor,
                ))
              : const Text(''),
          SizedBox(
            width: systemWidth,
            child: Image.asset(
              'assets/onboarding/botomsplash.png',
              height: systemHeight / 3,
              fit: BoxFit.cover,
            ),
          )
          // Text(
          //   " TAXI CABBY",
          //   style: TextStyle(color: Colors.blue),
          // ),
        ],
      ),
    ));
  }

  login() {
    // print(Config.sharedPreferences!.getString('type'));
    if (Config.sharedPreferences!.getString('type') == '1') {
      // print('rider');

      riderLogin();
      return;
    }
    if (Config.sharedPreferences!.getString('type') == '2') {
      // print('driver');
      driverLogin();
      return;
    }
    goToReplacement(SelectUserType(), context);
  } 

  Future riderLogin() async {
     String? token = await firebaseMessaging.getToken();
    print(Config.sharedPreferences!.getString('id'));
    print(Config.sharedPreferences!.getString('token'));

    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var url =
        '${globalUrl}main-login/${Config.sharedPreferences!.getString('id')}';
    print(url);
    var request = http.Request('GET', Uri.parse(url));
    request.body =
        json.encode({"id": "${Config.sharedPreferences!.getString('id')}",
        "device_token": token});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    if (!mounted) return;

    if (response.statusCode == 200) {
      var resp = jsonDecode(res);
      print(resp);
      if (resp['statusCode'] == 402) {
           goToReplacement(SelectUserType(), context);

      }

      var model2 = RiderUserModel?.fromJson(resp);
      var model = RiderUserModel?.fromJson(resp['user']);

      await Config.sharedPreferences!.setString('token', model2.token!);
      
      if (!mounted) return;
      goToReplacement(
          RiderHome(
            userModel: model,
            userModel2: model2,
          ),
          context);
    } else {
          goToReplacement(SelectUserType(), context);

    }
  }

  Future driverLogin() async {
    print(Config.sharedPreferences!.getString('id'));
     String? token = await firebaseMessaging.getToken();

    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var url =
        '${globalUrl}main-login/${Config.sharedPreferences!.getString('id')}';
    print(url);
    var request = http.Request('GET', Uri.parse(url));
    request.body =
        json.encode({"userId": "${Config.sharedPreferences!.getString('id')}",  "device_token": token});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      var resp = jsonDecode(res);
      print(resp['statusCode']);
      if (resp['statusCode'] == 402) {
        if (!mounted) return;
        goTo(SelectUserType(), context);
        return;
      }
      var model2 = UserModel.fromJson(resp);
      var model = UserModel.fromJson(resp['user']);
      print(model.acctBal);
        await Config.sharedPreferences!.setString('token', model2.token!);
      if (!mounted) return;
      goToReplacement(
          MapScreen(
            userModel: model,
            userModel2: model2,
          ),
          context);
    } else {
      if (!mounted) return;
      goTo(SelectUserType(), context);
    }
  }
}
