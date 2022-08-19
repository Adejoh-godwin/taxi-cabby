// ignore_for_file: use_build_context_synchronously

import 'package:cabby/driver/widget/shared/components/driver_header.dart';
import 'package:cabby/driver/widget/shared/components/rideViewType.dart';
import 'package:cabby/driver/widget/shared/widgets/ridevehicledetails.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/cancelride.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../driver/widget/shared/all_shared_widgets.dart' as all;

class BookRide extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;
  final AvailableModel? availableModel;

  const BookRide(
      {Key? key,
      required this.userModel,
      required this.userModel2,
      required this.availableModel})
      : super(key: key);
  @override
  BookRideState createState() => BookRideState();
}

class BookRideState extends State<BookRide> {
  final TextEditingController promo = TextEditingController();

  double systemHeight = 0;

  double systemWidth = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    all.backButton(context),
                    all.topIconRight(
                      const Icon(
                        Icons.doorbell,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                DriverHeader('${widget.availableModel!.driverImage}',
                    "${widget.availableModel!.driverName}", 'Driver'),
                const SizedBox(
                  height: 30,
                ),
                RideViewType('${widget.availableModel!.carImage}',
                    '${widget.availableModel!.ride_type}'),
                const SizedBox(
                  height: 30,
                ),
                RideViewDetails(
                    '${widget.availableModel!.carName}',
                    '${widget.availableModel!.carType}',
                    '${widget.availableModel!.vehiclePlateNo}',
                    widget.availableModel!.amount,
                    widget.availableModel!.durationText),
                const Text(
                  '',
                  style: k12400Faint,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                userTypeTextWithIcon("Promo", promo),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      bookride();
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
                            color: Colors.white,
                            size: 30.0,
                          )
                        : Text("Book Ride",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16.0,
                            )))),
              ],
            )),
      ),
    ));
  }

  Future<void> bookride() async {
    var data = {
      "driverId": "${widget.availableModel!.driverId}",
      "ride_id": "${widget.availableModel!.id}",
      "riderId": "${widget.userModel!.id}"
    };
    // print(data);
    var headers = {
      'Authorization': 'Bearer ${Config.sharedPreferences!.getString('token')}',
      'Content-Type': 'application/json'
    };
    var url = '${globalUrl}book-ride2';
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    setState(() {
      loading = false;
    });
    print(res);
    var resp = jsonDecode(res);
    if (response.statusCode == 402) {
      displayToastMessage(resp['message'], context);
      return;
    }
    if (response.statusCode == 200) {
      displayToastMessage('Booked successfully', context);

      goTo(
          CancelRide(
            userModel2: widget.userModel2,
            availableModel: widget.availableModel,
            userModel: widget.userModel,
          ),
          context);
    } else {
      // print(response.reasonPhrase);
    }
  }
}
