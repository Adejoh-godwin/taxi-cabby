import 'package:cabby/driver/config/size_dimension.dart';
import 'package:cabby/driver/widget/shared/widgets/recent_places.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/ridehistory.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:flutter/material.dart';
class SavedPlaces extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const SavedPlaces({Key? key, this.userModel, this.userModel2})
      : super(key: key);
  @override
  SavedPlacesState createState() => SavedPlacesState();
}

class SavedPlacesState extends State<SavedPlaces> {
  double systemHeight = 0;

  double systemWidth = 0;

  @override
  Widget build(BuildContext context) {
    //final size = Dimensions().getSize(context);

    systemHeight = Dimensions().getHeight(context);
    systemWidth = Dimensions().getWidth(context);
    return Scaffold(
        backgroundColor: Colors.white,
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
                        backButton(context),
                        topIconRight(
                          
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'Save Places',
                      style: kOnboardTitle,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // Container(
                    //   width: systemWidth,
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 30,
                    //         height: 100,
                    //         child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: <Widget>[
                    //               SizedBox(
                    //                 height: 15,
                    //               ),
                    //               Padding(
                    //                 padding:
                    //                     const EdgeInsets.only(bottom: 4.0),
                    //                 child: Icon(
                    //                   Icons.trip_origin,
                    //                   color: primaryColor,
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 child: DottedLine(
                    //                   direction: Axis.vertical,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.only(top: 4.0),
                    //                 child: Icon(
                    //                   Icons.location_on,
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 1,
                    //               ),
                    //             ]),
                    //       ),
                    //       Expanded(
                    //         child: Column(
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'PICK UP',
                    //                   style: kFaintText,
                    //                 ),
                    //                 Container(
                    //                   // width: systemWidth / 1.2,
                    //                   child: TextField(
                    //                     decoration: InputDecoration.collapsed(
                    //                         hintText: ""),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Container(
                    //               decoration: BoxDecoration(),
                    //               width: systemWidth / 1.2,
                    //               child: Divider(
                    //                 thickness: 0.8,
                    //                 color: textFaintColorGrey,
                    //               ),
                    //             ),
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'DROP OFF',
                    //                   style: kFaintText,
                    //                 ),
                    //                 Row(
                    //                   children: [
                    //                     Container(
                    //                       width: systemWidth / 1.7,
                    //                       child: TextField(
                    //                         decoration:
                    //                             InputDecoration.collapsed(
                    //                                 hintText: ""),
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       'change',
                    //                       style: kForgetPassword,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 50,
                    ),
                    //TODO saved places

                    // Container(
                    //   // color: Colors.yellow,
                    //   width: systemWidth,
                    //   height: systemHeight / 4,
                    //   child: Column(
                    //     children: [
                    //       SavedPlaceWidget(
                    //         title: "Home",
                    //         body: 'No 35 Ajose Adeogun Street Utako, Abuja',
                    //         myIcon: Icon(
                    //           Icons.doorbell,
                    //           size: 20,
                    //           color: Colors.black54,
                    //         ),
                    //         onTap: null,
                    //       ),
                    //       SavedPlaceWidget(
                    //         title: "Home",
                    //         body: 'No 35 Ajose Adeogun Street Utako, Abuja',
                    //         myIcon: Icon(
                    //           Icons.doorbell,
                    //           size: 20,
                    //           color: Colors.black54,
                    //         ),
                    //         onTap: null,
                    //       ),
                    //       SavedPlaceWidget(
                    //         title: "Home",
                    //         body: 'No 35 Ajose Adeogun Street Utako, Abuja',
                    //         myIcon: Icon(
                    //           Icons.doorbell,
                    //           size: 20,
                    //           color: Colors.black54,
                    //         ),
                    //         onTap: null,
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Recent Places',
                      style: kMiniTitleBold,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      // color: Colors.yellow,
                      width: systemWidth,
                      height: 300,
                      child: ListView(
                        padding: const EdgeInsets.all(1),
                        children: <Widget>[
                          FutureBuilder<List<RideModel>>(
                            future: ActivityApi.getRide(widget.userModel!.id,
                                context, widget.userModel2!.token),
                            builder: (context, AsyncSnapshot snapshot) {
                              final result = snapshot.data;
                              if (snapshot.hasError) {
                               return const EmptyTab();
                              }

                              if (!snapshot.hasData) {
                                return Column(children: [
                                  for (int i = 0; i < 5; i++) const Shimmer2(),
                                ]);
                              } else {
                                if (snapshot.data.length < 1) {
                                  return const EmptyTab();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      final model = result[index];

                                      return RecentPlaceWidget(
                                        title: "Home",
                                        body: model.dropOfflocation,
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
        ));
  }
}
