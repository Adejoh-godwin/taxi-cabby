// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cabby/rider/auth/otp.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:cabby/rider/auth/login.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final AuthService authService = AuthService();

  bool loading = false;
  bool? isEnabled = false;
  bool _obscureText = true;
  String? email;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Center(
                        child: Image(image: AssetImage('assets/svg/logo.png'))),
                    SizedBox(
                      height: mediaHeight* 0.03,
                    ),
                    Center(
                        child: Text(
                      'Register',
                      style: Config.style(FontWeight.bold, Colors.black, 13.0),
                    )),
                    SizedBox(
                      height: mediaHeight* 0.06,
                    ),
                    buildTextFormField('Full Name', nameController, 'name',
                        TextInputType.name),
                    const SizedBox(height: 10.0),
                    buildTextFormField(
                      'Email',
                      emailController,
                      '@gmail.com',
                      TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10.0),
                    buildTextFormField('Phone Number', phoneNumberController,
                        'number', TextInputType.number),
                    const SizedBox(height: 10.0),
                    Text(
                      'Password',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF505050),
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaHeight* 0.02,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          //borderSide: const BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintStyle: const TextStyle(
                            color: Color(0Xff969799),
                            fontFamily: "WorkSansLight"),
                        filled: true,
                        fillColor: const Color(0XFFf5f5f5),
                        hintText: 'Password',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: () => _toggle(),
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaHeight* 0.05,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          register();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: pColor,
                            fixedSize: const Size(400, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        child: (loading)
                            ? const SpinKitWave(
                                color: Colors.white,
                                size: 30.0,
                              )
                            : Text("Register",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13.0,
                                )))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaWidth* 0.25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: CircleAvatar(
                    backgroundColor: Color(0xffEEEEEE),
                    child: Icon(Icons.facebook_sharp),
                  ),
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffEEEEEE),
                    child: Config.svg('assets/svg/instagram.svg', 10, ''),
                  ),
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffEEEEEE),
                    child: Config.svg('assets/svg/twitter.svg', 10, ''),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Already have an Account ? ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Login())),
                child: const Text("Login",
                    style: TextStyle(
                        color: Color(0xff020529),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        decoration: TextDecoration.underline)),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          )
        ],
      ),
    );
  }

  buildTextFormField(text1, controller, hint, type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF505050),
              fontSize: 11.0,
            ),
          ),
        ),
        SizedBox(
          height: mediaHeight* 0.02,
        ),
        TextFormField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                //borderSide: const BorderSide(),
              ),
              hintStyle: const TextStyle(
                  fontSize: 11,
                  color: Color(0Xff969799),
                  fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: const Color(0XFFf5f5f5),
              hintText: hint),
        ),
      ],
    );
  }

  var response;
  var deviceId;
  BuildContext? buildContext;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId; // unique ID on Android
    }
    String? token = await FirebaseMessaging.instance.getToken();

    // try {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneNumberController.text,
      'type': 1,
      'password': passwordController.text,
      'device_token': token
    };
    print(data);
    var headers = {
      'Authorization': 'Bearer 476|AUcVgQru8TWEb6laDjtM0ZS3pBMteF6vuWxyf8xv',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${globalUrl}register'));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();
      print(resp);

      var res = jsonDecode(resp);

      if (res["status"] == 422) {
        // print(response.reasonPhrase);
        var errors = res["errors"];

        setState(() {
          loading = false;
        });
        if (mounted) {
          // DialogBuilderMode(context).hideOpenDialog();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              content: Text('${errors[0]}')));

          return;
        }
      }
      if (mounted) {
        displayToastMessage(res['message'].toString(), context);

        goToReplacement(
            Otp(
              phone: phoneNumberController.text,
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            ),
            context);
      }
    } else {
      print(response.reasonPhrase);
    }

    //   print(response);
    // } catch (err) {
    //   print("our catch");
    //   //  await DialogBuilderMode(context).hideOpenDialog();
    //   //on any erro here you can stop loading and display error notification
    //   throw ("user registration failed: $err");
    // }
  }
}
