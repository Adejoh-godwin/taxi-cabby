import 'package:cabby/rider/auth/create_pwd.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Verification extends StatefulWidget {
  final String? email;

  const Verification({Key? key, this.email}) : super(key: key);
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
              padding: const EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verification',
                        style: Config.style(FontWeight.bold, Colors.black, 14)),
                    Text(
                        'Enter the OTP code sent to your email \n${widget.email!}',
                        style: Config.style(
                            FontWeight.w100, const Color(0x0ff222cc), 12)),
                    SizedBox(
                      height: mediaHeight* 0.05,
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
                      height: mediaHeight* 0.07,
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
                          height: mediaHeight* 0.07,
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
                          verify();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: pColor,
                            fixedSize: const Size(400, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        child: (loading)
                            ? SpinKitWave(
                                color: pColor,
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

  resendOtp() {
    var otp = random(1111, 9999);
    drivers.where("email", isEqualTo: widget.email).get().then((value) {
      value.docs.forEach((result) {
        if (result.exists) {
          drivers.doc(result.id).update({
            'otp': otp,
          });
        } else {
          displayToastMessage('An error occured', context);
        }
      });
    });
  }

  void verify() {
    var otp2 = n1.text + n2.text + n3.text + n4.text;

    drivers
        .where('email', isEqualTo: widget.email)
        .where('otp', isEqualTo: otp2)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        displayToastMessage('Otp is invalid', context);
        // Navigator.of(context).pop();
      } else {
        querySnapshot.docs.forEach((doc) async {
          // drivers.doc(doc['firebaseUserId']).update({
          //   'otp': 'Verified',
          // });
          // print(doc['firebaseUserId']);
          setState(() {
            loading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CreatePwd(email: widget.email)));
        });
      }
    });
  }
}
