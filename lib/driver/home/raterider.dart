import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/driver/Models/available_model.dart';
import 'package:cabby/driver/config/size_dimension.dart';
import 'package:cabby/driver/home/map/map_screen.dart';
import 'package:cabby/driver/widget/shared/components/driver_headertwo.dart';
import 'package:cabby/driver/widget/shared/components/header_title.dart';
import 'package:cabby/rider/home/rider_home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateRider extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;
  final AvailableModel? availableModel;

  const RateRider(
      {Key? key, this.userModel, this.userModel2, this.availableModel})
      : super(key: key);
  @override
  RateRiderState createState() => RateRiderState();
}

class RateRiderState extends State<RateRider> {
  double systemHeight = 0;
  TextEditingController comment = TextEditingController();
  var rateCount = 1.0;
  bool loading = false;

  double systemWidth = 0;

  @override
  Widget build(BuildContext context) {
    systemHeight = Dimensions().getHeight(context);
    systemWidth = Dimensions().getWidth(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: w,
          elevation: 0,
          leading: backButton(context),
          centerTitle: true,
          title: const HeaderTitle(
            mainTitle: 'Rating',
            subTitle: '',
          ),
          actions: [topIconRight()],
        ),
        backgroundColor: w,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        DriverHeaderTwo('${widget.availableModel!.riderImage}',
                            '${widget.availableModel!.riderName}', 'Rider'),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            width: Dimensions().getWidth(context),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'How is your Trip?',
                                  style: kOnboardTitle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 18.0),
                                  child: Text(
                                    'Your feedback will help improve ridiing experience',
                                    style: k14400Faint,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: systemWidth,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: const [],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // const StarRating(),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 1,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        // print(rating);
                                        setState(() {
                                          rateCount = rating;
                                        });
                                      },
                                    ),
                                    sb('w', dp),
                                    Expanded(
                                      child: Text(
                                        rateCount.toString(),
                                        style: kOnboardTitle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: systemWidth,
                      child: TextField(
                        controller: comment,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Additional comment',
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            submitRate();
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
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )))),
                    ),
                  ],
                )),
          ),
        ));
  }

  Future<void> submitRate() async {
    final url = '${globalUrl}user/rate-driver';
    print(url);
    var headers = {
      'Authorization': 'Bearer  ${widget.userModel2!.token}',
      'Content-Type': 'application/json'
    };
    var data = {
      "rateCount": "$rateCount",
      "comment": comment.text,
      "riderId": widget.availableModel!.riderId,
      "driverId": widget.userModel!.id,
      "rideId": widget.availableModel!.id
    };
    print(jsonEncode(data));
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    // print(body);
    // var userModel = Rider
    // final AvailableModel newmodel = AvailableModel.fromJson(json.decode(body));

    setState(() {
      loading = false;
    });
    if (!mounted) return;
    goTo(
        MapScreen(
          userModel2: widget.userModel2,
          userModel: widget.userModel,
          // availableModel: newmodel,
        ),
        context);
  }
}
