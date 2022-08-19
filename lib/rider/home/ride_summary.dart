import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/ridehistory.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:flutter/material.dart';

class RideSummary extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const RideSummary({Key? key, this.userModel, this.userModel2})
      : super(key: key);
  @override
  RideSummaryState createState() => RideSummaryState();
}

class RideSummaryState extends State<RideSummary> {
  final accountNumber = TextEditingController();
  final accountNamr = TextEditingController();

  bool loading = false;
  bool? isEnabled = false;

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
        centerTitle: true,
        title: Text('Ride Summary',
            style: Config.style(FontWeight.w500, Colors.black, 20)),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 0.5),
                  // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${widget.userModel!.trips} trips',
                    style: Config.style(FontWeight.w400, sColor!, 17)),
                const Expanded(
                    child: SizedBox(
                  width: 5,
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: sColor,
                      size: 20,
                    ))
              ],
            ),
          ),
          const Divider(),
          SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<List<RideModel>>(
                    future: ActivityApi.getRide(widget.userModel!.id, context,
                        widget.userModel2!.token),
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

                              return Notification(
                                rideModel: model,
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
      ),
    );
  }

  buildTextFormField(text1, controller, hint, type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
        ),
        SizedBox(
          height: mediaHeight * 0.02,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,

                // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
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
                filled: true,
                fillColor: Colors.white,
                hintText: hint),
          ),
        ),
      ],
    );
  }

  BuildContext? buildContext;
  Future webCall() async {
    // Showing CircularProgressIndicator using State.
  }
}

class Notification extends StatelessWidget {
  final RideModel? rideModel;
  const Notification({
    Key? key,
    this.rideModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: pColor,
                child: const Icon(
                  Icons.history,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Pickup',
                              style: Config.style(FontWeight.w400,
                                  const Color(0xff7B7896), 12)),
                          const Expanded(
                            child: SizedBox(
                              width: 8,
                            ),
                          ),
                          Text('${rideModel!.pickupTime}',
                              style:
                                  Config.style(FontWeight.w400, textColor, 12))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('${rideModel!.pickupLocation}',
                          style: Config.style(FontWeight.bold, textColor, 12)),
                      const Divider(),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text('Drop off',
                              style: Config.style(FontWeight.w400,
                                  const Color(0xff7B7896), 12)),
                          const Expanded(
                            child: SizedBox(
                              width: 8,
                            ),
                          ),
                          Text('${rideModel!.dropoffTime}',
                              style:
                                  Config.style(FontWeight.w400, textColor, 12))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('${rideModel!.dropOfflocation}',
                          style: Config.style(FontWeight.w400, sColor!, 12)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text('ID:${rideModel!.id * 123497} ')),
                          Expanded(child: Text('${rideModel!.paymentMethod}')),
                          Expanded(child: Text(' ₦ ${rideModel!.amount}')),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
