// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/auth/add_account.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddVehicle extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final String? token;

   const AddVehicle({Key? key, this.userModel, this.userModel2, this.token}) : super(key: key);

  @override
  AddVehicleState createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  final vehicleType = TextEditingController();
  final product = TextEditingController();
  final model = TextEditingController();
  final plateNumber = TextEditingController();
  final manufactureyear = TextEditingController();

  bool loading = false;
  bool? isEnabled = false;
  var carColour = [
    "Black",
    "Blue",
    "Gold",
    "Grey",
    "Red",
    "Silver",
    "White",
  ];
  var selectColour = 'White';

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
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 700),
                      child: Text(
                        'Add Vehicle',
                        style:
                            Config.style(FontWeight.w500, Colors.black, 15.0),
                      ),
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 700),
                      child: Text(
                        'Your personal documents are required to verify your personality and ',
                        style: Config.style(FontWeight.w500, textColor, 13.0),
                      ),
                    ),
                    SizedBox(
                      height: mediaHeight * 0.06,
                    ),
                    buildTextFormField('Vehicle Type', vehicleType,
                        'Eg. Saloon Car', TextInputType.name),
                    const SizedBox(height: 10.0),
                    buildTextFormField(
                      'Product',
                      product,
                      'Toyota',
                      TextInputType.name,
                    ),
                    const SizedBox(height: 10.0),
                    buildTextFormField(
                        'Model', model, 'Camry 2012 Model', TextInputType.name),
                    const SizedBox(height: 10.0),
                    buildTextFormField('Plate Number', plateNumber, 'ABC123ZW',
                        TextInputType.name),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: const Color(0xffEEEEEE),
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state2) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                contentPadding: EdgeInsets.all(13)),
                            // isEmpty: _currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectColour,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectColour = newValue!;
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
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 850),
                      child: ElevatedButton(
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
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 860),
                      child: Center(
                        child: Text(
                          'By clicking Next, you agree to our terms and conditions',
                          style: Config.style(FontWeight.w500, textColor, 13.0),
                        ),
                      ),
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
    return DelayedDisplay(
      delay: const Duration(milliseconds: 800),
      child: Column(
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
            height: mediaHeight * 0.02,
          ),
          TextFormField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
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
      ),
    );
  }

  BuildContext? buildContext;
  Future saveLast() async {
    try {
      var data = {
        'car_type': vehicleType.text,
        'car_name': product.text,
        'car_model': model.text,
        'plateNumber': plateNumber.text,
        'colour': selectColour,
        'userId': widget.userModel!.id,
      };
      // print(data);
      var url = '${globalUrl}addCar';
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      print(json.encode(data));
      print(url);

      var resp = jsonDecode(response.body);

      print(response.body);

      //print(response);
      if (resp['response'] == 'failed') {
        setState(() {
          loading = false;
          // By adding this you can close your po
        });
        if (!mounted) return;

        displayToastMessage('An eror occured', context);
        return;
      }
      if (!mounted) return;

      displayToastMessage('Saved successful', context);

      goTo(
          AddAccount(
            userModel2: widget.userModel2,
            userModel: widget.userModel,
          ),
          context);
    } catch (err) {
      // print(err);
      //  await DialogBuilderMode(context).hideOpenDialog();
      setState(() {
        loading = false;
      });
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
