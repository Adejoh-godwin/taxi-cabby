import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/rate_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DialogWithdraw extends StatefulWidget {
  final String? status;
  final AvailableModel availableModel;
  final RiderUserModel? userModel;

  final RiderUserModel? userModel2;

  final Color? color;
  const DialogWithdraw({
    Key? key,
    this.color,
    this.status,
    required this.availableModel,
    this.userModel,
    this.userModel2,
  }) : super(key: key);
  @override
  State<DialogWithdraw> createState() => _DialogWithdrawState();
}

class _DialogWithdrawState extends State<DialogWithdraw> {
  TextEditingController amount = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.115,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                      child: SizedBox(
                    width: 5,
                  )),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: w,
              ),
              child: Column(
                children: [
                  Container(
                    height: height * 0.12,
                    color: const Color(0xffF5F3FF),
                    child: Center(
                      child: Text(
                        'Wallet Bank Details',
                        style: Config.style(FontWeight.bold, b, 18),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(18),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Amount",
                          style: TextStyle(
                            color: Color(0xff434255),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          numformat(widget.availableModel.amount),
                          style: const TextStyle(
                            color: Color(0xffbcbc13),
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        sb('h', dp),
                        const Text(
                          "Wallet Bank Details",
                          style: TextStyle(
                            color: Color(0xff1e1d34),
                            fontSize: 20,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        sb('h', dp * 2),
                        const Text(
                          "Account Name",
                          style: TextStyle(
                            color: Color(0xff434255),
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.availableModel.acctName,
                          style: const TextStyle(
                            color: Color(0xff1e1d34),
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        sb('h', dp),
                        const Text(
                          "Account Number",
                          style: TextStyle(
                            color: Color(0xff434255),
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.availableModel.acctNumber,
                          style: const TextStyle(
                            color: Color(0xff1e1d34),
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        sb('h', dp),
                        const Text(
                          "Bank Name",
                          style: TextStyle(
                            color: Color(0xff434255),
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.availableModel.bankName,
                          style: const TextStyle(
                            color: Color(0xff1e1d34),
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        const Text(
                          "Kindly make transfer to the above account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1e1d34),
                            fontSize: 16,
                          ),
                        ),
                        sb('h', dp),
                        TextButton(
                          onPressed: () {
                            makePayment();
                              goTo( RateDriver(availableModel: widget.availableModel, userModel2: widget.userModel2,userModel: widget.userModel,), context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Color(0xff43ABF0)),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              primary: blue,
                              padding: const EdgeInsets.all(16.0),
                              fixedSize: const Size(500, 53)),
                          child: (loading)
                              ? const SpinKitWave(
                                  color: Colors.white,
                                  size: 30.0,
                                )
                              : Text(
                                  'Rate Driver',
                                  style: Config.style(FontWeight.bold, w, 18),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void makePayment() async {
    var data = {
      "amount": widget.availableModel.amount,
      "driverId": widget.availableModel.driverId,
      "distance": widget.availableModel.distanceValue,
      "driverName": widget.availableModel.driverName,
      "rideId": widget.availableModel.id,
      "riderId": widget.userModel!.id,
      "riderName": widget.userModel!.name,
    };

    final url = '${globalUrl}make-payment';
    // print(url);
    var headers = {
      'Authorization': 'Bearer  ${widget.userModel2!.token}',
      'Content-Type': 'application/json'
    };

    // print(jsonEncode(data));
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    // print(body);


    // var resp = await AssistantMethods.getRequest(url, data)
  }
}

class Success extends StatefulWidget {
  final AvailableModel availableModel;
  final RiderUserModel? userModel;

  final RiderUserModel? userModel2;
  const Success(
      {Key? key, required this.availableModel, this.userModel, this.userModel2})
      : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.115,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                      child: SizedBox(
                    width: 5,
                  )),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: w,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Config.svg('assets/svg/check.svg', 24, null),
                        sb('h', dp),
                        const Text(
                          "Payment Successful",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1e1d34),
                            fontSize: 18,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        sb('h', dp),
                        const SizedBox(
                          width: 277,
                          height: 42,
                          child: Text(
                            "You have successfully made payment of NGN 450 for your ride  booked",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff434255),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        sb('h', dp),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        sb('h', dp),
                        TextButton(
                          onPressed: () {
                            goTo(
                                RateDriver(
                                  availableModel: widget.availableModel,
                                  userModel2: widget.userModel2,
                                  userModel: widget.userModel,
                                ),
                                context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Color(0xff43ABF0)),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              primary: blue,
                              padding: const EdgeInsets.all(16.0),
                              fixedSize: const Size(500, 53)),
                          child: Text(
                            'Rate Driver',
                            style: Config.style(FontWeight.bold, w, 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
