// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/home/rider_home.dart';
import 'package:http/http.dart' as http;

import 'package:cabby/rider/config/config.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp extends StatefulWidget {
  final email;
  final phone;
  final name;
  final password;

  const Otp({Key? key, this.email, this.phone, this.name, this.password})
      : super(key: key);
  @override
  OtpState createState() => OtpState();
}

class OtpState extends State<Otp> {
  final n1 = TextEditingController();
  final n2 = TextEditingController();
  final n3 = TextEditingController();
  final n4 = TextEditingController();
  FocusNode t1 = FocusNode();
  FocusNode t2 = FocusNode();
  FocusNode t3 = FocusNode();
  FocusNode t4 = FocusNode();

  bool loading = false;
  bool? isEnabled = false;

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verification',
                        style: Config.style(FontWeight.bold, Colors.black, 14)),
                    Text(
                        'Enter the OTP code sent to your phone \n+234 7031040178',
                        style: Config.style(
                            FontWeight.w100, const Color(0x0ff222cc), 12)),
                    SizedBox(
                      height: mediaHeight * 0.05,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          maxLength: 1,
                          controller: n1,
                          onChanged: (_) {
                            t2.requestFocus();
                          },
                          focusNode: t1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                //borderSide: const BorderSide(),
                              ),
                              hintStyle: TextStyle(
                                  color: Color(0Xff969799),
                                  fontFamily: "WorkSansLight"),
                              filled: true,
                              fillColor: Color(0XFFf5f5f5),
                              hintText: '1'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          controller: n2,
                          onChanged: (_) {
                            t3.requestFocus();
                          },
                          focusNode: t2,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                //borderSide: const BorderSide(),
                              ),
                              hintStyle: TextStyle(
                                  color: Color(0Xff969799),
                                  fontFamily: "WorkSansLight"),
                              filled: true,
                              fillColor: Color(0XFFf5f5f5),
                              hintText: '1'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          controller: n3,
                          onChanged: (_) {
                            t4.requestFocus();
                          },
                          focusNode: t3,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                //borderSide: const BorderSide(),
                              ),
                              hintStyle: TextStyle(
                                  color: Color(0Xff969799),
                                  fontFamily: "WorkSansLight"),
                              filled: true,
                              fillColor: Color(0XFFf5f5f5),
                              hintText: '1'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          maxLength: 1,
                          controller: n4,
                          focusNode: t4,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                //borderSide: const BorderSide(),
                              ),
                              hintStyle: TextStyle(
                                  color: Color(0Xff969799),
                                  fontFamily: "WorkSansLight"),
                              filled: true,
                              fillColor: Color(0XFFf5f5f5),
                              hintText: '1'),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: mediaHeight * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Didn't receive any code ?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: mediaHeight * 0.07,
                        ),
                        InkWell(
                          onTap: () => resendOtp(),
                          child: Text(" Resend",
                              style: TextStyle(
                                  color: pColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          verifyOtp();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: pColor,
                            fixedSize: const Size(400, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        child: (loading)
                            ? const SpinKitWave(
                                color: Colors.white,
                                size: 30.0,
                              )
                            : Text("Verify",
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
        ],
      ),
    );
  }

  buildTextFormField(controller, textField, fNode) {
    return SizedBox(
      height: 55,
      width: 55,
      child: TextFormField(
        controller: controller,
        onChanged: (_) {
          textField.requestFocus();
        },
        focusNode: fNode,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,

              //borderSide: const BorderSide(),
            ),
            hintStyle: TextStyle(
                color: Color(0Xff969799), fontFamily: "WorkSansLight"),
            filled: true,
            fillColor: Color(0XFFf5f5f5),
            hintText: '1'),
      ),
    );
  }

  BuildContext? buildContext;

  verifyOtp() async {
    var otp = n1.text + n2.text + n3.text + n4.text;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${globalUrl}verify-otp'));
    print('${globalUrl}verify-otp');

    request.body = json.encode({"phone": "${widget.phone}", "otp": otp});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    var resp = jsonDecode(res);
    if (response.statusCode == 200) {
      var model2 = RiderUserModel?.fromJson(resp);
      var model = RiderUserModel?.fromJson(resp['user']);
      Config.sharedPreferences!.setString('id', model.id!);
      Config.sharedPreferences!.setString('token', model2.token!);
      Config.sharedPreferences!.setString('type', model.type!);
      if (!mounted) return;
      goTo(
          RiderHome(
            userModel: model,
            userModel2: model2,
          ),
          context);
    } else {
      print(response.reasonPhrase);
    }
  }

  var deviceId;

  resendOtp() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId; // unique ID on Android
    }

    try {
      var headers = {
        'Authorization': 'Bearer 21|q4Y5mKorWFlXzuc6OxDJUqgGQuk0Z5tV3WT48KFW',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${globalUrl}resend-otp'));
      request.body = json.encode({
        'name': widget.name,
        'email': widget.email,
        'phone': widget.phone,
        'type': 1,
        'password': widget.password,
        'device_token': deviceId
      });
      request.headers.addAll(headers);
      print('${globalUrl}resend-otp');
      http.StreamedResponse response = await request.send();
      var res = jsonDecode(await response.stream.bytesToString());
      print(res);
      if (response.statusCode == 200) {
        if (!mounted) return;

        displayToastMessage(res['message'], context);

        goToReplacement(
            Otp(
                phone: widget.phone,
                name: widget.name,
                email: widget.email,
                password: widget.password),
            context);
      } else {
        print(response.reasonPhrase);
        setState(() {
          displayToastMessage(res['message'], context);
        });
      }

      print(response);
    } catch (err) {
      print("our catch");
      if (!mounted) return;

      //  await DialogBuilderMode(context).hideOpenDialog();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          content: Text('$err')));
      //on any erro here you can stop loading and display error notification
      //throw ("user registration failed: $err");
    }
  }
}
