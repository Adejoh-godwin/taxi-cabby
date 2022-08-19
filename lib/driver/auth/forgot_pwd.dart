import 'package:cabby/driver/auth/emai.l_ver.dart';
// ignore: unused_import
import 'package:cabby/driver/auth/signup.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/widget/popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cabby/driver/widget/input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPwd extends StatefulWidget {
  const ForgotPwd({Key? key}) : super(key: key);

  @override
  ForgotPwdState createState() => ForgotPwdState();
}

class ForgotPwdState extends State<ForgotPwd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  static const String path = "lib/src/pages/ForgotPwd/login7.dart";
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Forgot Password',
                        style: Config.style(FontWeight.bold, textColor, 18)),
                    SizedBox(
                      height: mediaHeight* 0.05,
                    ),
                    Text(
                      'Enter your email or phone number to help recover your password',
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
                    InputNumber.buildTextFormField('email', emailController,
                        '@gmail.com', TextInputType.emailAddress),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          webCall();
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
                            : Text("Recover",
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

  BuildContext? buildContext;
  Future webCall() async {
    var otp = random(1111, 9999);
    drivers
        .where('email', isEqualTo: emailController.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length < 1) {
        displayToastMessage('Email doesn\'t exist', context);
        // Navigator.of(context).pop();
      } else {
        querySnapshot.docs.forEach((doc) async {
          drivers.doc(doc['firebaseUserId']).update({
            'otp': otp.toString(),
          });
          displayToastMessage('An OTP has been sent to your mail', context);
          // var url = '${'alpha.envio.com.ng/send-mail/' +
          //     otp}/${emailController.text}/' +
          //     doc['name'];
          // var response = AssistantMethods.getRequest(
          //     '${'alpha.envio.com.ng/send-mail/' +
          //         otp}/${emailController.text}/' +
          //         doc['name'],
          //     'data');

          // print(response);
          // print(url);
          setState(() {
            loading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                  child: PopUp(
                      text1:
                          'Verification code has been sent to your email. kindly check your mail for confirmation',
                      text2: 'cancel',
                      text3: 'Ok',
                      route: MaterialPageRoute(
                          builder: (_) =>
                              Verification(email: emailController.text))));
            },
          );
        });
      }
    });
  }
}
