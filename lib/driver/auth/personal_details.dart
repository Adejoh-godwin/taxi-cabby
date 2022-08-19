// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:cabby/driver/home/map/map_screen.dart';
import 'package:http/http.dart' as http;

import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDetails extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;

  const PersonalDetails({Key? key, this.userModel, this.userModel2})
      : super(key: key);
  @override
  PersonalDetailsState createState() => PersonalDetailsState();
}

class PersonalDetailsState extends State<PersonalDetails> {
  bool? value = false;
  bool loading = false;
  bool loading1 = false;
  bool loading1a = false;
  bool loading2 = false;
  bool loading2a = false;
  bool loading3 = false;
  bool loading3a = false;
  bool loading4 = false;
  bool loading4a = false;
  bool loading5 = false;
  bool loading5a = false;
  bool loading6a = false;
  bool loading7a = false;
  bool loading7 = false;
  bool loading6 = false;

  bool? isEnabled = false;
  String? email;
  // var _image, _image7, _image2, _image6;

  var carImage, imagePassport, driverLicense, govtId;
  var imagePicker;

  var classRide = ["Economy", "Classic", "Luxury"];
  var selectClass = 'Economy';
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  bool? rideType1 = false;
  bool? rideType2 = false;
  bool? rideType3 = false;
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
                      'Add Personal Document',
                      style: Config.style(FontWeight.bold, Colors.black, 15.0),
                    ),
                    Text(
                      'Your personal documents are required to verify your personality and ',
                      style: Config.style(
                          FontWeight.bold, const Color(0xff7B7896), 12.0),
                    ),
                    SizedBox(
                      height: mediaHeight * 0.02,
                    ),
                    // buildTextFormField('Passport Sized Photograph',
                    //     'Upload your document here', save(), 'name'),
                    const SizedBox(height: 10.0),
                    buildTextFormField(
                      'Car Image',
                      TextButton(
                        onPressed: () async {
                          var source = ImageSource.gallery;

                          try {
                            XFile image = await imagePicker.pickImage(
                                source: source,
                                imageQuality: 50,
                                preferredCameraDevice: CameraDevice.rear);
                            setState(() {
                              loading7 = true;
                            });
                            String imageFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            FirebaseStorage storageReference =
                                FirebaseStorage.instance;
                            await storageReference
                                .ref()
                                .child(imageFileName)
                                .putFile(File(image.path));
                            var userImageUrl = await storageReference
                                .ref(imageFileName)
                                .getDownloadURL();
                            setState(() {
                              carImage = userImageUrl;
                              loading7 = true;
                              loading7a = true;
                            });
                            print(carImage);
                          } catch (e) {
                            displayToastMessage(
                                "You didn't select any image", context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          minimumSize: const Size(60, 40),
                          primary: const Color(0xffEEEEEE),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: Row(children: [
                          Text(
                            (loading6a)
                                ? 'Uploaded successful'
                                : 'Upload your document here',
                            style: Config.style(
                              FontWeight.w600,
                              const Color(0xff7B7896),
                              13,
                            ),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 2,
                          )),
                          (loading7a)
                              ? const Icon(Icons.check)
                              : Expanded(
                                  child: (loading7 == false)
                                      ? const Icon(Icons.cancel_outlined)
                                      : const SpinKitCircle(
                                          color: Colors.blue, size: 30))
                        ]),
                      ),
                    ),

                    const SizedBox(height: 10.0),
                    buildTextFormField(
                      'Passpoort Photograph',
                      TextButton(
                        onPressed: () async {
                          var source = ImageSource.gallery;

                          try {
                            XFile image = await imagePicker.pickImage(
                                source: source,
                                imageQuality: 50,
                                preferredCameraDevice: CameraDevice.rear);
                            setState(() {
                              loading6 = true;
                            });
                            String imageFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            FirebaseStorage storageReference =
                                FirebaseStorage.instance;
                            await storageReference
                                .ref()
                                .child(imageFileName)
                                .putFile(File(image.path));
                            var userImageUrl = await storageReference
                                .ref(imageFileName)
                                .getDownloadURL();
                            setState(() {
                              imagePassport = userImageUrl;

                              loading6a = true;
                            });
                            print(imagePassport);
                          } catch (e) {
                            displayToastMessage(
                                "You didn't select any image", context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          minimumSize: const Size(60, 40),
                          primary: const Color(0xffEEEEEE),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: Row(children: [
                          Text(
                            (loading6a)
                                ? 'Uploaded successful'
                                : 'Upload your document here',
                            style: Config.style(
                              FontWeight.w600,
                              const Color(0xff7B7896),
                              13,
                            ),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 2,
                          )),
                          (loading6a)
                              ? const Icon(Icons.check)
                              : Expanded(
                                  child: (loading6 == false)
                                      ? const Icon(Icons.cancel_outlined)
                                      : const SpinKitCircle(
                                          color: Colors.blue, size: 30))
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    buildTextFormField(
                      'Divers License',
                      TextButton(
                        onPressed: () async {
                          var source = ImageSource.gallery;

                          try {
                            XFile image = await imagePicker.pickImage(
                                source: source,
                                imageQuality: 50,
                                preferredCameraDevice: CameraDevice.rear);
                            setState(() {
                              loading1 = true;
                            });
                            String imageFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            FirebaseStorage storageReference =
                                FirebaseStorage.instance;
                            await storageReference
                                .ref()
                                .child(imageFileName)
                                .putFile(File(image.path));
                            var userImageUrl = await storageReference
                                .ref(imageFileName)
                                .getDownloadURL();
                            setState(() {
                              driverLicense = userImageUrl;
                              loading1 = true;
                              loading1a = true;
                            });
                          } catch (e) {
                            displayToastMessage(
                                "You didn't select any image", context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          minimumSize: const Size(60, 40),
                          primary: const Color(0xffEEEEEE),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: Row(children: [
                          Text(
                            (loading1a)
                                ? 'Uploaded successful'
                                : 'Upload your document here',
                            style: Config.style(
                              FontWeight.w600,
                              const Color(0xff7B7896),
                              13,
                            ),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 2,
                          )),
                          (loading1a)
                              ? const Icon(Icons.check)
                              : Expanded(
                                  child: (loading1 == false)
                                      ? const Icon(Icons.cancel_outlined)
                                      : const SpinKitCircle(
                                          color: Colors.blue, size: 30))
                        ]),
                      ),
                    ),

                    const SizedBox(height: 10.0),
                    buildTextFormField(
                      'Nin',
                      TextButton(
                        onPressed: () async {
                          var source = ImageSource.gallery;

                          try {
                            XFile image = await imagePicker.pickImage(
                                source: source,
                                imageQuality: 50,
                                preferredCameraDevice: CameraDevice.rear);
                            setState(() {
                              loading2 = true;
                            });
                            String imageFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            FirebaseStorage storageReference =
                                FirebaseStorage.instance;
                            await storageReference
                                .ref()
                                .child(imageFileName)
                                .putFile(File(image.path));
                            var userImageUrl = await storageReference
                                .ref(imageFileName)
                                .getDownloadURL();
                            setState(() {
                              govtId = userImageUrl;
                              loading2 = true;
                              loading2a = true;
                            });
                          } catch (e) {
                            displayToastMessage(
                                "You didn't select any image", context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          minimumSize: const Size(60, 40),
                          primary: const Color(0xffEEEEEE),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: Row(children: [
                          Text(
                            (loading2a)
                                ? 'Uploaded successful'
                                : 'Upload your document here',
                            style: Config.style(
                              FontWeight.w600,
                              const Color(0xff7B7896),
                              13,
                            ),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 2,
                          )),
                          (loading2a)
                              ? const Icon(Icons.check)
                              : Expanded(
                                  child: (loading2 == false)
                                      ? const Icon(Icons.cancel_outlined)
                                      : const SpinKitCircle(
                                          color: Colors.blue, size: 30))
                        ]),
                      ),
                    ),

                    const SizedBox(height: 10.0),
                    const Text('Class Of Ride'),
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
                                value: selectClass,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectClass = newValue!;
                                    state2.didChange(newValue);
                                  });
                                },
                                items: classRide.map((String value) {
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
                    const Text('Ride Type'),
                    Row(
                      children: [
                        Checkbox(
                          value: rideType1,
                          onChanged: (bool? value) {
                            setState(() {
                              rideType1 = value;
                            });
                          },
                        ),
                        const Text('Inter-city')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: rideType2,
                          onChanged: (bool? value) {
                            setState(() {
                              rideType2 = value;
                            });
                          },
                        ),
                        const Text('Intra-city')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: rideType3,
                          onChanged: (bool? value) {
                            setState(() {
                              rideType3 = value;
                            });
                          },
                        ),
                        const Text('Delivery and Logistics')
                      ],
                    ),
                    SizedBox(
                      height: mediaHeight * 0.05,
                    ),
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
                    const SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        'By clicking Next, you agree to our terms and conditions',
                        style: Config.style(
                            FontWeight.bold, const Color(0xff7B7896), 13.0),
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

  buildTextFormField(text1, button) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: Config.style(
            FontWeight.w400,
            const Color(0xFF505050),
            13.0,
          ),
        ),
        SizedBox(
          height: mediaHeight * 0.01,
        ),
        button
      ],
    );
  }

  BuildContext? buildContext;

  saveLast() async {
    var data = {
      'passport': imagePassport,
      'carImage': carImage,
      'driverLicense': driverLicense,
      'classRide': selectClass,
      'rideType1': rideType1,
      'rideType2': rideType2,
      'rideType3': rideType3,
      "userId": widget.userModel!.id,   
      "token": widget.userModel2!.token,
    };

    print(jsonEncode(data));
    // Navigator.push(context, MaterialPageRoute(builder: (_) => AddVehicle()));
    var headers = {
      'Authorization': 'Bearer 349|5mw1RdYGdhBDZUZ9djDZOnt4bWoIhuHK1yoKagam',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('${globalUrl}personalDetails'));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = (await response.stream.bytesToString());
    print(res);
    setState(() {
      loading = false;
    });
    if (!mounted) return;

    var resp = jsonDecode(res);
    if (response.statusCode == 200) {
      var userModel2 = UserModel.fromJson(resp);
      var userModel = UserModel.fromJson(resp['user']);
      goTo(
          MapScreen(
            userModel2: userModel2,
            userModel: userModel,
          ),
          context);
    } else {
      print(response.reasonPhrase);
    }
  }
}
