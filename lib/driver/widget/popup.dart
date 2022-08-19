// ignore_for_file: unused_local_variable, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:cabby/driver/AllScreens/navigate_to_user.dart';
import 'package:cabby/driver/AllScreens/new_ride_screen.dart';
import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/Models/available_model.dart';
import 'package:cabby/driver/Models/direct_details.dart';
import 'package:cabby/driver/assistant/assist.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/home/ride_summary.dart';
import 'package:cabby/driver/home/rideinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgressDialog extends StatelessWidget {
  final String? message;
  const ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6.0,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              const SizedBox(
                width: 26.0,
              ),
              Text(
                '$message',
                style: const TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopUp extends StatefulWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final Route route;
  const PopUp(
      {Key? key, this.text1, this.text2, this.text3, required this.route})
      : super(key: key);

  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  bool loading = false;

  TextEditingController otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: mediaHeight * 0.24),
        Center(
          child: Stack(
            children: [
              Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            // margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(32.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('yyyy',
                                    style: Config.style(FontWeight.w600,
                                        const Color(0xff888888), 15)),
                                SizedBox(
                                  height: mediaHeight * 0.04,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(3),
                                          minimumSize: const Size(80, 40),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ),
                                        ),
                                        child: Text(
                                          'iiii',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.lightGreen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context, widget.route);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(3),
                                          minimumSize: const Size(80, 40),
                                          primary: Colors.white,
                                          side: const BorderSide(
                                            width: 2.0,
                                            color: Colors.lightGreenAccent,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ),
                                        ),
                                        child: (loading)
                                            ? const SpinKitPulse(
                                                color: Colors.amber,
                                                size: 30.0,
                                              )
                                            : Center(
                                                child: Text(
                                                  'hhhh',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors
                                                          .lightGreenAccent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: mediaHeight * 0.14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: pColor,
                    child: const Expanded(
                        child: Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WalletPop extends StatelessWidget {
  final dynamic text1;
  final dynamic text2;
  final dynamic text3;
  final UserModel? userModel;
  final UserModel? userModel2;
  const WalletPop(
      {Key? key,
      this.text1,
      this.text2,
      this.text3,
      this.userModel,
      this.userModel2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(
                // margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0),
                          border: Border.all(color: textColor)),
                      child: RichText(
                        text: TextSpan(
                            text: 'NGN ',
                            style: Config.style(FontWeight.bold, sColor!, 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$text1',
                                style:
                                    Config.style(FontWeight.bold, pColor, 14),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(text2!,
                        style: Config.style(
                            FontWeight.w600, const Color(0xff888888), 15)),
                    SizedBox(
                      height: mediaHeight * 0.04,
                    ),
                    Text(text3!,
                        style: Config.style(
                            FontWeight.w600, const Color(0xff888888), 13)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RideSummary(
                                      userModel: userModel,
                                      userModel2: userModel2,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(3),
                        minimumSize: const Size(80, 40),
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: pColor,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'View Summary',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: pColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewRide extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? model;

  const NewRide({
    Key? key,
    this.model,
    this.userModel,
    this.userModel2,
  }) : super(key: key);

  @override
  State<NewRide> createState() => _NewRideState();
}

class _NewRideState extends State<NewRide> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  color: sColor,
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: sColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('New Ride',
                                      style: Config.style(
                                        FontWeight.w700,
                                        Colors.white,
                                        14,
                                      )),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.schedule_outlined,
                                        color: pColor,
                                        size: 15,
                                      ),
                                      Expanded(
                                        child: Text(
                                            '${widget.model!.durationText}',
                                            style: Config.style(
                                              FontWeight.w700,
                                              Colors.white,
                                              12,
                                            )),
                                      ),
                                      Icon(
                                        Icons.room_outlined,
                                        color: pColor,
                                        size: 15,
                                      ),
                                      Expanded(
                                        child: Text(
                                            '${widget.model!.distanctText}',
                                            style: Config.style(
                                              FontWeight.w700,
                                              Colors.white,
                                              12,
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                              TextButton(
                                onPressed: () {
                                  declineRide(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(3),
                                  minimumSize: const Size(80, 40),
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                    ),
                                    (loading)
                                        ? const SpinKitWave(
                                            color: Colors.amber,
                                            size: 30.0,
                                          )
                                        : Text(
                                            ' Decline',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        const Divider(
                          color: Colors.white,
                        ),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 14,
                                        color: textColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${widget.model!.pickUpLoc}',
                                          style: Config.style(FontWeight.w400,
                                              Colors.white, 14),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.circle,
                                          size: 14, color: pColor),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${widget.model!.dropOffLoc}',
                                          style: Config.style(FontWeight.w400,
                                              Colors.white, 14),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                            ],
                          ),
                        )),
                        const Divider(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: ',
                                      style: Config.style(
                                        FontWeight.w700,
                                        Colors.white,
                                        12,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(numformat(widget.model!.amount),
                                        style: Config.style(
                                          FontWeight.w700,
                                          pColor,
                                          14,
                                        )),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rating',
                                      style: Config.style(
                                        FontWeight.w700,
                                        Colors.white,
                                        12,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: pColor,
                                    size: 13,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('${widget.model!.rating}',
                                      style: Config.style(
                                        FontWeight.w700,
                                        pColor,
                                        14,
                                      )),
                                ],
                              )),
                            ],
                          ),
                        )),
                        TextButton(
                          onPressed: () {
                            acceeptRide(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: (loading)
                                ? const SpinKitWave(
                                    color: Colors.amber,
                                    size: 30.0,
                                  )
                                : Text(
                                    'Tap to Accept',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> declineRide(context) async {
    setState(() {
      loading = true;
    });
    final url =
        '${globalUrl}driver/decline-ride/${widget.model!.id}/${widget.userModel!.id}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    // print(response.body);
    final body = json.decode(response.body);

    // print(body);
    if (body['reponse'] == 'empty') {
      displayToastMessage('An erro occured', context);
      return;
    }
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
    return displayToastMessage('Ride has been cancelled', context);

    // setState(() {
    //   todayAmt = body['tm'];
    //   todayTrip = body['tp'];
    //   todayDate = body['day'];
    // });
  }

  acceeptRide(context) async {
    assetsAudioPlayer.stop();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    setState(() {
      loading = true;
    });
    var driverLatLng =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    var userLatLng = LatLng(widget.model!.pickUpLat, widget.model!.pickUpLong);
    var direction = await AssistantMethods.obtainPlaceDirectionDetails(
        driverLatLng, userLatLng);
    // return direction;

    final url =
        '${globalUrl}driver/accept-ride/${widget.model!.id}/${widget.userModel!.id}';
    print(url);
    // try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);
    final body = json.decode(response.body);

    print(body);
    if (response.statusCode == 402) {
      setState(() {
        loading = false;
      });
      displayToastMessage('An error occured', context);
      return;
    }
    setState(() {
      loading = false;
    });
    displayToastMessage('Ride has been Accepted', context);
    Navigator.pop(context);
    goTo(
        NavigateToUser(
            direction: direction,
            userModel2: widget.userModel2,
            userModel: widget.userModel,
            model: widget.model),
        context);
    // } catch (exp) {
    //   setState(() {
    //     loading = false;
    //   });
    //   displayToastMessage("An error occured, please try again", context);
    //   print(exp);
    //   return;
    // }

    // setState(() {
    //   todayAmt = body['tm'];
    //   todayTrip = body['tp'];
    //   todayDate = body['day'];
    // });
  }
}

class Arrival extends StatelessWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? model;
  final DirectionDetails? direction;
  const Arrival({
    Key? key,
    this.userModel,
    this.userModel2,
    this.model,
    this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: sColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        model!.dropOffLoc,
                                        style: Config.style(
                                            FontWeight.w400, Colors.white, 12),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      model!.distanctText,
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      model!.durationText,
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 12),
                                    ),
                                    const Expanded(
                                        child: SizedBox(
                                      width: 5,
                                    )),
                                    Expanded(
                                      child: Text(
                                        ' Waiting',
                                        style: Config.style(
                                            FontWeight.w400, Colors.white, 12),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '${model!.pickUpLoc}',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(model!.riderName))),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.schedule_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('${direction!.durationText}'),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${model!.riderImage}'),
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              const Icon(Icons.room_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('${direction!.distanceText}'),
                            ],
                          ),
                        )),
                        const Divider(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //TODO: chat
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: sColor,
                                    child: const Icon(Icons.chat),
                                  ),
                                  const Text('Chat')
                                ],
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      declineRide(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: sColor,
                                      child: const Icon(Icons.cancel),
                                    ),
                                  ),
                                  const Text('Canel Trip')
                                ],
                              ),
                            ],
                          ),
                        )),
                        TextButton(
                          onPressed: () {
                            startPickUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Start Pickup',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> declineRide(context) async {
    final url = '${globalUrl}driver/decline-ride/${model!.id}/${userModel!.id}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userModel2!.token}',
    });
    print(response.body);
    final body = json.decode(response.body);

    print(body);
    if (body['reponse'] == 'empty') {
      displayToastMessage('An error occured', context);
      return;
    }
    Navigator.pop(context);
    return displayToastMessage('Ride has been cancelled', context);

    // setState(() {
    //   todayAmt = body['tm'];
    //   todayTrip = body['tp'];
    //   todayDate = body['day'];
    // });
  }

  Future<void> startPickUp(context) async {
    final url = '${globalUrl}driver/drverStatusUpdate/${model!.id}/Coming';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userModel2!.token}',
    });

    // AssistantMethods.
    Navigator.pop(context);
    show(
        context,
        PickupScreen(
            userModel2: userModel2,
            userModel: userModel,
            model: model,
            direction: direction));
  }
}

class CanCelRide extends StatelessWidget {
  final int? text1;
  final String? text2;
  final String? text3;
  const CanCelRide({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xff1E1D34).withOpacity(0.7),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Ajose Adeogun Street Utako',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '3km',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              'Shoprite, Jabi  Mall Lake Jabi',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Cancel Ride with Chindinma'))),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const RideSummary()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel Ride',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const RideSummary()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: pColor),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: sColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Call extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  const Call({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Text('Make A call'),
                                  Expanded(
                                      child: SizedBox(
                                    width: 15,
                                  )),
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                  )
                                ],
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RideSummary()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(3),
                          minimumSize: const Size(80, 40),
                          primary: Colors.grey,
                        ),
                        child: Row(
                          children: [
                            Text('Call',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )),
                            const Expanded(
                                child: SizedBox(
                              width: 5,
                            )),
                            Expanded(
                              child: Text(
                                '+2349037016221',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'You can call your rider to get response on his whereabout.'),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArrivedDestination extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? model;
  final DirectionDetails? direction;
  const ArrivedDestination({
    Key? key,
    this.userModel,
    this.userModel2,
    this.model,
    this.direction,
  }) : super(key: key);

  @override
  State<ArrivedDestination> createState() => _ArrivedDestinationState();
}

class _ArrivedDestinationState extends State<ArrivedDestination> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: sColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${widget.model!.dropOffLoc}',
                                        style: Config.style(
                                            FontWeight.w400, Colors.white, 14),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '${widget.model!.pickUpLoc}',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Arrived Destination',
                          style:
                              Config.style(FontWeight.w500, Colors.black, 13),
                        ),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          dropOff(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(3),
                          minimumSize: const Size(80, 40),
                          primary: pColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Center(
                          child: (loading)
                              ? const SpinKitWave(
                                  color: Colors.amber,
                                  size: 30.0,
                                )
                              : Text(
                                  'Drop Off',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> dropOff(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    setState(() {
      loading = true;
    });

    final url = '${globalUrl}driver/dropoff-action';
    print(url);
    var headers = {
      'Authorization': 'Bearer  ${widget.userModel2!.token}',
      'Content-Type': 'application/json'
    };
    var data = {
      "pickUpLatitude": "${widget.model!.pickUpLat}",
      "pickUpLongitude": "${widget.model!.pickUpLong}",
      "dropOffLatitude": "${currentPosition!.latitude}",
      "dropOffLongitude": "${currentPosition!.longitude}",
      "driverId": widget.userModel!.id,
      "rideId": widget.model!.id
    };
    print(jsonEncode(data));
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    print(body);
    final AvailableModel newmodel = AvailableModel.fromJson(json.decode(body));

    setState(() {
      loading = false;
    });
    if (!mounted) return;
    goTo(
        RideInfo(
          userModel2: widget.userModel2,
          userModel: widget.userModel,
          availableModel: newmodel,
        ),
        context);
  }
}

class PickupScreen extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? model;
  final DirectionDetails? direction;
  const PickupScreen({
    Key? key,
    this.userModel,
    this.userModel2,
    this.model,
    this.direction,
  }) : super(key: key);

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: sColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.model!.dropOffLoc,
                                        style: Config.style(
                                            FontWeight.w400, Colors.white, 12),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.model!.distanctText,
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.model!.durationText,
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 12),
                                    ),
                                    const Expanded(
                                        child: SizedBox(
                                      width: 5,
                                    )),
                                    Expanded(
                                      child: Text(
                                        ' Waiting',
                                        style: Config.style(
                                            FontWeight.w400, Colors.white, 12),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '${widget.model!.pickUpLoc}',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.model!.riderName))),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.schedule_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('${widget.direction!.durationText}'),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${widget.model!.riderImage}'),
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              const Icon(Icons.room_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('${widget.model!.distanctText}'),
                            ],
                          ),
                        )),
                        const Divider(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: sColor,
                                    child: const Icon(Icons.chat),
                                  ),
                                  const Text('Chat')
                                ],
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      declineRide(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: sColor,
                                      child: const Icon(Icons.cancel),
                                    ),
                                  ),
                                  const Text('Canel Trip')
                                ],
                              ),
                            ],
                          ),
                        )),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            arrived(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: (loading)
                                ? const SpinKitWave(
                                    color: Colors.amber,
                                    size: 30.0,
                                  )
                                : Text(
                                    'Arrived',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> declineRide(context) async {
    final url = '${globalUrl}driver/decline-ride/${widget.model!.id}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);
    final body = json.decode(response.body);

    print(body);
    if (body['reponse'] == 'empty') {
      displayToastMessage('An erro occured', context);
      return;
    }
    Navigator.pop(context);
    return displayToastMessage('Ride has been cancelled', context);

    // setState(() {
    //   todayAmt = body['tm'];
    //   todayTrip = body['tp'];
    //   todayDate = body['day'];
    // });
  }

  Future<void> arrived(context) async {
    final url =
        '${globalUrl}driver/driverStatusUpdate/${widget.model!.id}/Arrived';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
    show(
        context,
        StartRide(
            userModel2: widget.userModel2,
            userModel: widget.userModel,
            model: widget.model,
            direction: widget.direction));
  }
}

class StartRide extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? model;
  final DirectionDetails? direction;
  const StartRide({
    Key? key,
    this.userModel,
    this.userModel2,
    this.model,
    this.direction,
  }) : super(key: key);

  @override
  State<StartRide> createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: sColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${widget.model!.dropOffLoc}',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '${widget.model!.pickUpLoc}',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Head to destination'))),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: pColor,
                                    child: const Icon(Icons.chat),
                                  ),
                                  const Text('Chat')
                                ],
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${widget.model!.riderImage}'),
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => declineRide(context),
                                    child: CircleAvatar(
                                      backgroundColor: pColor,
                                      child: const Icon(Icons.cancel),
                                    ),
                                  ),
                                  const Text('Canel Trip')
                                ],
                              ),
                            ],
                          ),
                        )),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            startRide(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: (loading)
                                ? const SpinKitWave(
                                    color: Colors.amber,
                                    size: 30.0,
                                  )
                                : Text(
                                    'Start Ride',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> declineRide(context) async {
    final url = '${globalUrl}driver/decline-ride/${widget.model!.id}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    print(response.body);
    final body = json.decode(response.body);

    print(body);
    if (body['reponse'] == 'empty') {
      displayToastMessage('An erro occured', context);
      return;
    }
    Navigator.pop(context);
    return displayToastMessage('Ride has been cancelled', context);
  }

  Future<void> startRide(BuildContext context) async {
    final url =
        '${globalUrl}driver/driverStatusUpdate/${widget.model!.id}/Started';
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.userModel2!.token}',
    });
    setState(() {
      loading = false;
    });
    if (!mounted) return;
    Navigator.pop(context);
    goTo(
        NewRideScreen(
            userModel2: widget.userModel2,
            userModel: widget.userModel,
            model: widget.model,
            direction: widget.direction),
        context);
  }
}
