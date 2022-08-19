import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/auth/forgot_pwd.dart';
import 'package:cabby/driver/auth/signup.dart';
import 'package:cabby/driver/home/map/map_screen.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverLogin extends StatefulWidget {
  const DriverLogin({Key? key}) : super(key: key);

  @override
  DriverLoginState createState() => DriverLoginState();
}

class DriverLoginState extends State<DriverLogin> {
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

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
  void initState() {
    super.initState();
  }

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
                    const Center(
                        child: Image(image: AssetImage('assets/svg/logo.png'))),
                    SizedBox(
                      height: mediaHeight * 0.1,
                    ),
                    const Center(child: Text('Welome back')),
                    SizedBox(
                      height: mediaHeight * 0.05,
                    ),
                    Text(
                      'Email Address',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF505050),
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaHeight * 0.02,
                    ),
                    buildTextFormField(emailController),
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
                      height: mediaHeight * 0.02,
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
                      height: mediaHeight * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPwd())),
                        child: const Text(
                          "FORGOT PASSWORD ?",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                        onPressed: () {
                          if (!emailController.text.contains("@")) {
                            displayToastMessage(
                                "Email address is not Valid.", context);
                          } else if (passwordController.text.isEmpty) {
                            displayToastMessage(
                                "Password is mandatory.", context);
                          } else {
                            setState(() {
                              loading = true;
                            });
                            login();
                          }
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
                                color: Colors.amber,
                                size: 30.0,
                              )
                            : Text("Login",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Don't have an Account ? ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DriverSignup())),
                child: const Text("Signup",
                    style: TextStyle(
                        color: Color(0xff020529),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        decoration: TextDecoration.underline)),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  TextFormField buildTextFormField(controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            //borderSide: const BorderSide(),
          ),
          hintStyle:
              TextStyle(color: Color(0Xff969799), fontFamily: "WorkSansLight"),
          filled: true,
          fillColor: Color(0XFFf5f5f5),
          hintText: 'example@gmail.com'),
    );
  }

  Future login() async {
    String? token = await firebaseMessaging.getToken();

    var headers = {'Content-Type': 'application/json'};
    var url = '${globalUrl}login';
    print(token);
    var request = http.Request('POST', Uri.parse(url));
    // String? token = await FirebaseMessaging.instance.getToken();
    // var token = "";

    request.body = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": token
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      // print(res['access_token']);
      var resp = jsonDecode(res);
      // print(resp);

      var model2 = UserModel.fromJson(resp);
      var model = UserModel.fromJson(resp['user']);
      Config.sharedPreferences!.setString('id', model.id!);
      Config.sharedPreferences!.setString('token', model2.token!);
      Config.sharedPreferences!.setString('type', model.type!);
      // print(model.acctBal);
      if (!mounted) return;
      if (model.type != "2") {
        displayToastMessage("You are not registered as a driver", context);
        return;
      }
      if (!mounted) return;
      goToReplacement(
          MapScreen(
            userModel2: model2,
            userModel: model,
          ),
          context);
    } else {
      if (!mounted) return;
      displayToastMessage("Invalid login details", context);
      // print(response.reasonPhrase);
    }
  }
}
