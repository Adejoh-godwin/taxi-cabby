// ignore_for_file: unused_local_variable

import 'package:cabby/rider/AllWidgets/Divider.dart';
import 'package:cabby/rider/AllWidgets/progressDialog.dart';
import 'package:cabby/rider/Assistants/requestAssistant.dart';
import 'package:cabby/rider/DataHandler/appdata.dart';
import 'package:cabby/rider/Models2/address.dart';
import 'package:cabby/rider/Models2/placepredictions.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/selectride.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;
  final String? rideType;

  const SearchScreen(
      {Key? key,
      required this.userModel,
      required this.userModel2,
      this.rideType})
      : super(key: key);
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];
  List<PlacePredictions> placePredictionList2 = [];

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation!.placeName ?? "";

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 25.0),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const Center(
                        child: Text(
                          "Set Drop Off",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pickicon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      const SizedBox(
                        width: 18.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              initialValue: placeAddress,
                              onChanged: (val) {
                                findPlace2(val);
                              },
                              decoration: InputDecoration(
                                hintText: "PickUp Location",
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/desticon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      const SizedBox(
                        width: 18.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val) {
                                findPlace(val);
                              },
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //tile for predictions
          const SizedBox(
            height: 10.0,
          ),
          (placePredictionList.isNotEmpty)
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0.0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          rideType: widget.rideType,
                          userModel: widget.userModel,
                          userModel2: widget.userModel2,
                          placePredictions: placePredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const DividerWidget(),
                      itemCount: placePredictionList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                )
              : Container(),
          (placePredictionList2.isNotEmpty)
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0.0),
                      itemBuilder: (context, index) {
                        return PredictionTile2(
                          userModel2: widget.userModel2,
                          userModel: widget.userModel,
                          placePredictions: placePredictionList2[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const DividerWidget(),
                      itemCount: placePredictionList2.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void findPlace2(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ng";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }

      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        if (!mounted) {
          return;
        }
        setState(() {
          placePredictionList2 = placesList;
        });
      }
    }
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ng";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }

      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

//drop off prediction
class PredictionTile extends StatelessWidget {
  final PlacePredictions? placePredictions;
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;
  final String? rideType;

  const PredictionTile(
      {Key? key,
      this.placePredictions,
      this.userModel,
      this.userModel2,
      required this.rideType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        getPlaceAddressDetails(placePredictions!.place_id, context, rideType);
      },
      child: Column(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Row(
            children: [
              const Icon(Icons.add_location),
              const SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '${placePredictions!.main_text}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '${placePredictions!.secondary_text}',
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }

  void getPlaceAddressDetails(String? placeId, context, rideType) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Setting Dropoff, Please wait...",
            ));

    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocationAddress(address);
      // print("This is Drop Off Location :: ");
      // print(address.placeName);

      // Navigator.pop(context, "obtainDirection");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SelectRide(
                    rideType: rideType,
                    userModel: userModel,
                    userModel2: userModel2,
                  )));
    }
  }
}

class PredictionTile2 extends StatelessWidget {
  final PlacePredictions? placePredictions;
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;
  const PredictionTile2(
      {Key? key,
      this.placePredictions,
      required this.userModel,
      required this.userModel2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        getPlaceAddressDetails2(placePredictions!.place_id, context);
      },
      child: Column(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Row(
            children: [
              const Icon(Icons.add_location),
              const SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '${placePredictions!.main_text}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '${placePredictions!.secondary_text}',
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }

  void getPlaceAddressDetails2(String? placeId, context) async {
    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(address);
      // print("This is Drop Off Location :: ");
      // print(address.placeName);
      String? placeAddress = Provider.of<AppData>(context, listen: false)
          .pickUpLocation!
          .placeName;
      // print(placeAddress);
      goTo(
          SearchScreen(
            userModel: userModel,
            userModel2: userModel,
          ),
          context);
    }
  }
}
