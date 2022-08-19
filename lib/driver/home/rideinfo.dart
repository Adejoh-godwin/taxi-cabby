import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/Models/available_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/config/size_dimension.dart';
import 'package:cabby/driver/home/raterider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideInfo extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? availableModel;

  const RideInfo(
      {Key? key, this.userModel, this.userModel2, this.availableModel})
      : super(key: key);
  @override
  RideInfoState createState() => RideInfoState();
}

class RideInfoState extends State<RideInfo> {
  String? pickUp;
  String? dropOff;

  @override
  Widget build(BuildContext context) {
    String placeAddress = widget.availableModel!.pickUpLoc;
    pickUp = placeAddress;
    String finalPos = widget.availableModel!.dropOffLoc;
    dropOff = finalPos;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButton(context),
                      const Expanded(
                          child: SizedBox(
                        width: 5,
                      )),
                      const Icon(
                        Icons.doorbell,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Dimensions().getWidth(context),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 100,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 8,
                                    child: Icon(
                                      Icons.trip_origin,
                                      color: pColor,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: DottedLine(
                                    dashColor: Colors.amber,
                                    direction: Axis.vertical,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PICK UP',
                                    style: Config.style(
                                        FontWeight.w100, Colors.black, 10),
                                  ),
                                  Text(
                                    pickUp.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(),
                                width: Dimensions().getWidth(context) / 1.2,
                                child: const Divider(
                                  thickness: 0.8,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DROP OFF',
                                    style: Config.style(
                                        FontWeight.w100, Colors.black, 10),
                                  ),
                                  Text(
                                    dropOff.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ride Completed',
                        style: Config.style(FontWeight.w400, textColor, 16),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: pColor),
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: RichText(
                          text: TextSpan(
                              text: 'NGN ',
                              style: Config.style(FontWeight.bold, pColor, 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${widget.userModel2!.acctBal}',
                                  style: Config.style(
                                      FontWeight.bold, textColor, 14),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Collect Cash from ${widget.availableModel!.riderName}',
                        style: Config.style(FontWeight.w400, textColor, 16),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            const Icon(Icons.timer),
                            Text('${widget.availableModel!.distanctText}'),
                            const Expanded(
                                child: SizedBox(
                              width: 15,
                            )),
                            const Icon(Icons.location_on),
                            Text('${widget.availableModel!.durationText}'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            goTo(
                                RateRider(
                                    userModel2: widget.userModel2,
                                    userModel: widget.userModel,
                                    availableModel: widget.availableModel),
                                context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: pColor,
                              fixedSize: const Size(400, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          child: Text("Rate Rider",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 13.0,
                              )))),
                    ],
                  )
                ],
              )),
        ),
      ),
    ));
  }
}
