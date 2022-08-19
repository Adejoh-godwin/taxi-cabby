// ignore_for_file: avoid_print

import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/auth/personal_details.dart';

import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddAccount extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;

  const AddAccount({Key? key, this.userModel, this.userModel2})
      : super(key: key);
  @override
  AddAccountState createState() => AddAccountState();
}

class AddAccountState extends State<AddAccount> {
  final accountNumber = TextEditingController();
  final accountName = TextEditingController();

  bool loading = false;
  bool? isEnabled = false;
  var carColour = [
    "Select Bank",
    'Access Bank Plc',
    'Citibank Nigeria Limited',
    'Ecobank Nigeria Plc',
    'Fidelity Bank Plc',
    'First Bank ltd',
    'First City Monument Bank Plc',
    'Globus Bank Limited',
    'Guaranty Trust Bank Plc',
    'Heritage Banking Company Ltd',
    'Key Stone Bank',
    'Polaris Bank',
    'Providus Bank',
    'Stanbic IBTC Bank Ltd',
    'Standard Chartered Bank Ltd',
    'Sterling Bank Plc',
    'SunTrust Bank Nigeria Limited',
    'Titan Trust Bank Ltd',
    'Union Bank of Nigeria Plc',
    'United Bank For Africa Plc',
    'Unity Bank Plc',
    'Wema Bank Plc',
    'Zenith Bank Plc'
  ];
  var selectBank = 'Select Bank';

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
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Account Details',
                      style: Config.style(FontWeight.w500, Colors.black, 15.0),
                    ),
                    Text(
                      'Add your account details ',
                      style: Config.style(FontWeight.w500, textColor, 13.0),
                    ),
                    SizedBox(
                      height: mediaHeight* 0.06,
                    ),
                    Container(
                      color: const Color(0xffEEEEEE),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state2) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                                fillColor: Color(0xffEEEEEE),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(13)),
                            // isEmpty: _currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectBank,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectBank = newValue!;
                                    state2.didChange(newValue);
                                  });
                                },
                                items: carColour.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    buildTextFormField('Account Number', accountNumber,
                        '12345678', TextInputType.name),
                    const SizedBox(height: 10.0),
                    buildTextFormField('Account Name', accountName,
                        'acccount name', TextInputType.name),
                    SizedBox(height: mediaHeight* 0.1),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          saveLast();
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
                            : Text("Next",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )))),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                borderRadius: BorderRadius.all(Radius.circular(10)),
                //borderSide: const BorderSide(),
              ),
              filled: true,
              fillColor: const Color(0XFFf5f5f5),
              hintText: hint),
        ),
      ],
    );
  }

  BuildContext? buildContext;

  Future saveLast() async {
    try {
      var headers = {
        'Authorization': 'Bearer 349|5mw1RdYGdhBDZUZ9djDZOnt4bWoIhuHK1yoKagam',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${globalUrl}addAccount'));
      request.body = json.encode({
        "bankName": selectBank,
        "acctNumber": accountNumber.text.trim(),
        "acctName": accountName.text.trim(),
        'userId': widget.userModel!.id,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
      if (!mounted) return;

      displayToastMessage('Saved successful', context);

      goTo(
          PersonalDetails(
            userModel2: widget.userModel2,
            userModel: widget.userModel,
          ),
          context);
    } catch (err) {
      setState(() {
        loading = false;
      });
      print("our catch");
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
