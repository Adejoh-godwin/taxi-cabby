import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:cabby/rider/widget/input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePwd extends StatefulWidget {
  final String? email;

  const CreatePwd({Key? key, this.email}) : super(key: key);
  @override
  CreatePwdState createState() => CreatePwdState();
}

class CreatePwdState extends State<CreatePwd> {
  final confirm = TextEditingController();
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
              padding: const EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create New Password?',
                        style: Config.style(FontWeight.bold, Colors.black, 14)),
                    SizedBox(
                      height: mediaHeight* 0.05,
                    ),
                    Text(
                      'Your new password must be different from the old one',
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
                    InputNumber.buildTextFormField('email/number', confirm,
                        'Confirm Password', TextInputType.number),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
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
    // Showing CircularProgressIndicator using State.
  }
}
