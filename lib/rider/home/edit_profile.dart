// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cabby/rider/Assistants/assistantMethods.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final RiderUserModel? userModel;

  const EditProfile({Key? key, this.userModel}) : super(key: key);
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(
        userModel: widget.userModel,
      ),
    );
  }
}

class Body extends StatefulWidget {
  final RiderUserModel? userModel;

  const Body({Key? key, this.userModel}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loading = false;
  bool? isEnabled = false;
  var _image;
  var imagePicker;
  var imgUrl;
  bool loadImg = false;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  var states = [
    "Abuja",
    "Lagos",
    "Port Harourt",
  ];
  var selectState = 'Abuja';

  var gender = [
    "Female",
    "Male",
  ];
  var selectGender = 'Male';

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;
    imgUrl = widget.userModel!.image;

    return Scaffold(
      backgroundColor: Colors.white,
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
        centerTitle: true,
        title: Text('Edit Profile',
            style: Config.style(FontWeight.w500, Colors.black, 20)),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Profile',
                      style: Config.style(FontWeight.bold, Colors.black, 13.0),
                    ),
                    SizedBox(
                      height: mediaHeight * 0.06,
                    ),
                    InkWell(
                      onTap: () async {
                        var source = ImageSource.gallery;

                        try {
                          XFile image = await imagePicker.pickImage(
                              source: source,
                              imageQuality: 50,
                              preferredCameraDevice: CameraDevice.rear);

                          setState(() {
                            _image = File(image.path);
                          });
                          // print(imgUrl);
                        } catch (e) {
                          displayToastMessage(
                              "You didn't select any image", context);
                        }
                      },
                      child: Center(
                        child: CircleAvatar(
                          foregroundColor: Colors.amber,
                          radius: mediaWidth * 0.15,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              _image == null ? null : FileImage(_image),
                          child: (_image == null)
                              ? Icon(Icons.add_photo_alternate,
                                  size: mediaWidth * 0.15, color: Colors.grey)
                              : null,
                        ),
                      ),
                    ),
                    buildTextFormField('Full Name', 'name', TextInputType.name,
                        widget.userModel!.name),
                    const SizedBox(height: 10.0),
                    buildTextFormField('Email', '@gmail.com',
                        TextInputType.emailAddress, widget.userModel!.email),
                    const SizedBox(height: 10.0),
                    buildTextFormField('Phone Number', '', TextInputType.number,
                        widget.userModel!.phone),
                    const SizedBox(height: 10.0),
                    Container(
                      color: const Color(0xffEEEEEE),
                      child: FormField<String>(
                        builder: (FormFieldState<String> gender2) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                                fillColor: Color(0xffEEEEEE),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(13)),
                            // isEmpty: _currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectGender,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectGender = newValue!;
                                    gender2.didChange(newValue);
                                  });
                                },
                                items: gender.map((String value) {
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
                                value: selectState,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectState = newValue!;
                                    state2.didChange(newValue);
                                  });
                                },
                                items: states.map((String value) {
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
                    SizedBox(
                      height: mediaHeight * 0.05,
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
                                color: Colors.amber,
                                size: 30.0,
                              )
                            : Text("Submit",
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
        ],
      ),
    );
  }

  buildTextFormField(text1, hint, type, value) {
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
          height: mediaHeight * 0.02,
        ),
        TextFormField(
          initialValue: value,
          keyboardType: type,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),
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

  BuildContext? buildContext;

  Future register() async {
    var otp = random(1111, 9999);
    String? token = await FirebaseMessaging.instance.getToken();
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storageReference = FirebaseStorage.instance;
    await storageReference.ref().child(imageFileName).putFile(_image);
    var urlImg = await storageReference.ref(imageFileName).getDownloadURL();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(imgUrl);

    try {
      var data = {
        'name': nameController.text.isEmpty
            ? widget.userModel!.name
            : nameController.text,
        'email': emailController.text.isEmpty
            ? widget.userModel!.email
            : emailController.text,
        'phone': phoneNumberController.text.isEmpty
            ? widget.userModel!.name
            : phoneNumberController.text,
        'type': 1,
        'token': token,
        'image': urlImg,
        'id': widget.userModel!.id
      };
      print(jsonEncode(data));
      var url = '${globalUrl}edit-create';
      // print(url);
      print(data);
      var response = await AssistantMethods.getRequest(url, data);
      setState(() {
        loading = false;
      });
      // print(response);
      if (!mounted) {
        return;
      }
      var userModel = RiderUserModel.fromJson(response['user']);
      displayToastMessage(response['respone'].toString(), context);
    } catch (err) {
      if (!mounted) {
        return;
      }
      print("our catch");
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
