import 'package:cabby/rider/auth/login.dart';
import 'package:cabby/rider/auth/signup.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserData {
  dynamic userID;
  dynamic userName;
  dynamic phoneNumber;
  dynamic email;
  dynamic image;
  dynamic meter;
  dynamic address;

  UserData(
      {this.userID,
      this.userName,
      this.phoneNumber,
      this.email,
      this.image,
      this.address,
      this.meter});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        userID: json['id'],
        userName: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        image: json['image'],
        address: json['address'],
        meter: json['meter']);
  }
}

class AuthFirstScreen extends StatefulWidget {
  const AuthFirstScreen({Key? key}) : super(key: key);

  @override
  AuthFirstScreenState createState() => AuthFirstScreenState();
}

class AuthFirstScreenState extends State<AuthFirstScreen> {
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
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool isEnabled = false;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const DelayedDisplay(
                delay: Duration(milliseconds: 600),
                child: Image(image: AssetImage('assets/svg/logo.png'))),
            DelayedDisplay(
              delay: const Duration(milliseconds: 600),
              child: Center(
                child: Text('Select User Type',
                    style: Config.style(FontWeight.bold, Colors.black, 14.0)),
              ),
            ),
            const DelayedDisplay(
              delay: Duration(milliseconds: 700),
              child: Image(
                image: AssetImage('assets/svg/authSren1.png'),
                width: 250,
              ),
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 700),
              child: Center(
                child: Text('Signup?',
                    style: Config.style(FontWeight.bold, Colors.black, 14.0)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 850),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    goTo(const Login(), context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: pColor,
                    fixedSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text("As a Customer",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0,
                      ))),
                ),
              ),
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 950),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const Signup()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: sColor,
                    fixedSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text("As a Driver",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0,
                      ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
