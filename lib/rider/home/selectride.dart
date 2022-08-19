import 'package:cabby/driver/widget/shared/components/recommended_ride.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:cabby/rider/home/bookride.dart';
import 'package:provider/provider.dart';

class SelectRide extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;
  final String? rideType;

  const SelectRide(
      {Key? key,
      required this.userModel,
      required this.userModel2,
      required this.rideType})
      : super(key: key);
  @override
  SelectRideState createState() => SelectRideState();
}

class SelectRideState extends State<SelectRide> {
  final TextEditingController pickUp = TextEditingController();
  final TextEditingController dropOff = TextEditingController();

  @override
  void initState() {
    pickUp.addListener(() {
      // _onChanged();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation!.placeName ?? "";
    pickUp.text = placeAddress;
    String finalPos =
        Provider.of<AppData>(context).dropOffLocation!.placeName ?? "";
    dropOff.text = finalPos;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: whiteColor,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [backButton(context), topIconRight()],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Dimensions().getWidth(context),
                    decoration: BoxDecoration(
                        color: const Color(0xff1E1D34),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 100,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 8,
                                    child: Icon(
                                      Icons.trip_origin,
                                      color: primaryColor,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: DottedLine(
                                    dashColor: Colors.amber,
                                    direction: Axis.vertical,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
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
                                    style: Config.style(FontWeight.w100,
                                        const Color(0xffc4c4c4), 10),
                                  ),
                                  TextField(
                                    controller: pickUp,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(),
                                width: Dimensions().getWidth(context) / 1.2,
                                child: const Divider(
                                  thickness: 0.8,
                                  color: textFaintColorGrey,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DROP OFF',
                                    style: Config.style(FontWeight.w100,
                                        const Color(0xffc4c4c4), 10),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Dimensions().getWidth(context) /
                                            1.7,
                                        child: TextField(
                                          controller: dropOff,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ""),
                                        ),
                                      ),
                                      Text(
                                        'change',
                                        style: Config.style(
                                            FontWeight.w100, Colors.white, 14),
                                      ),
                                    ],
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
                    height: 25,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        DefaultTabController(
                            length: 3, // length of tabs
                            initialIndex: 0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  TabBar(
                                    // indicatorSize: TabBarIndicatorSize.tab,
                                    labelColor: Colors.white,
                                    // indicatorPadding: EdgeInsets.only(
                                    //     left: 30, right: 30),
                                    unselectedLabelColor: Colors.grey,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.black),
                                    tabs: const [
                                      Tab(text: 'Economy'),
                                      Tab(text: 'Classic'),
                                      Tab(text: 'Business'),
                                    ],
                                  ),
                                  Container(
                                      height: 400, //height of TabBarView
                                      decoration: const BoxDecoration(),
                                      child: TabBarView(children: <Widget>[
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 20.0),
                                                    const Text(
                                                      'Recommended Ride For You',
                                                      style: kMiniTitle,
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    SizedBox(
                                                      height: 300,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            FutureBuilder<
                                                                List<
                                                                    AvailableModel>>(
                                                              future: ActivityApi
                                                                  .getAvailable2(
                                                                      'Economy',
                                                                      context,
                                                                      widget
                                                                          .rideType),
                                                              builder: (context,
                                                                  AsyncSnapshot
                                                                      snapshot) {
                                                                final result =
                                                                    snapshot
                                                                        .data;
                                                                if (snapshot
                                                                    .hasError) {
                                                                  return const Center(
                                                                    child:
                                                                        EmptyTab(),
                                                                  );
                                                                }

                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < 3;
                                                                            i++)
                                                                          const Shimmer2(),
                                                                      ]);
                                                                } else {
                                                                  if (snapshot
                                                                          .data
                                                                          .length <
                                                                      1) {
                                                                    return const EmptyTab();
                                                                  } else {
                                                                    return ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemCount: snapshot
                                                                          .data!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        final model =
                                                                            result[index];

                                                                        return RecommendedRide(
                                                                          imageUrl:
                                                                              model.carImage,
                                                                          carName:
                                                                              model.carName,
                                                                          description:
                                                                              model.carType,
                                                                          time:
                                                                              model.durationText,
                                                                          amount:
                                                                              model.amount,
                                                                          onTap:
                                                                              () {
                                                                            goTo(
                                                                                BookRide(
                                                                                  availableModel: model,
                                                                                  userModel2: widget.userModel2,
                                                                                  userModel: widget.userModel,
                                                                                ),
                                                                                context);
                                                                          },
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            // for (int i = 0; i < 5; i++) Notification(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 20.0),
                                                    const Text(
                                                      'Recomended Ride For You',
                                                      style: kMiniTitle,
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    SizedBox(
                                                      height: 300,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            FutureBuilder<
                                                                List<
                                                                    AvailableModel>>(
                                                              future: ActivityApi
                                                                  .getAvailable2(
                                                                      'Classic',
                                                                      context,
                                                                      widget
                                                                          .rideType),
                                                              builder: (context,
                                                                  AsyncSnapshot
                                                                      snapshot) {
                                                                final result =
                                                                    snapshot
                                                                        .data;
                                                                if (snapshot
                                                                    .hasError) {
                                                                  return const Center(
                                                                    child:
                                                                        EmptyTab(),
                                                                  );
                                                                }

                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < 3;
                                                                            i++)
                                                                          const Shimmer2(),
                                                                      ]);
                                                                } else {
                                                                  if (snapshot
                                                                          .data
                                                                          .length <
                                                                      1) {
                                                                    return const EmptyTab();
                                                                  } else {
                                                                    return ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemCount: snapshot
                                                                          .data!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        final model =
                                                                            result[index];

                                                                        return RecommendedRide(
                                                                          imageUrl:
                                                                              model.carImage,
                                                                          carName:
                                                                              model.carName,
                                                                          description:
                                                                              model.carType,
                                                                          time:
                                                                              model.durationText,
                                                                          amount:
                                                                              model.amount,
                                                                          onTap:
                                                                              () {
                                                                            goTo(
                                                                                BookRide(
                                                                                  availableModel: model,
                                                                                  userModel2: widget.userModel2,
                                                                                  userModel: widget.userModel,
                                                                                ),
                                                                                context);
                                                                          },
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            // for (int i = 0; i < 5; i++) Notification(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 20.0),
                                                    const Text(
                                                      'Recomended Ride For You',
                                                      style: kMiniTitle,
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    SizedBox(
                                                      height: 300,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            FutureBuilder<
                                                                List<
                                                                    AvailableModel>>(
                                                              future: ActivityApi
                                                                  .getAvailable2(
                                                                      'Business',
                                                                      context,
                                                                      widget
                                                                          .rideType),
                                                              builder: (context,
                                                                  AsyncSnapshot
                                                                      snapshot) {
                                                                final result =
                                                                    snapshot
                                                                        .data;
                                                                if (snapshot
                                                                    .hasError) {
                                                                  return const Center(
                                                                    child:
                                                                        EmptyTab(),
                                                                  );
                                                                }

                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < 3;
                                                                            i++)
                                                                          const Shimmer2(),
                                                                      ]);
                                                                } else {
                                                                  if (snapshot
                                                                          .data
                                                                          .length <
                                                                      1) {
                                                                    return const EmptyTab();
                                                                  } else {
                                                                    return ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemCount: snapshot
                                                                          .data!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        final model =
                                                                            result[index];

                                                                        return RecommendedRide(
                                                                          imageUrl:
                                                                              model.carImage,
                                                                          carName:
                                                                              model.carName,
                                                                          description:
                                                                              model.carType,
                                                                          time:
                                                                              model.durationText,
                                                                          amount:
                                                                              model.amount,
                                                                          onTap:
                                                                              () {
                                                                            goTo(
                                                                                BookRide(
                                                                                  availableModel: model,
                                                                                  userModel2: widget.userModel2,
                                                                                  userModel: widget.userModel,
                                                                                ),
                                                                                context);
                                                                          },
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            // for (int i = 0; i < 5; i++) Notification(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ]))
                                ])),
                      ]),
                ],
              )),
        ),
      ),
    ));
  }
}
