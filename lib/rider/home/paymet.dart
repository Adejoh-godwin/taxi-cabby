import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/available_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/paystack.dart';
import 'package:cabby/rider/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Payment extends StatefulWidget {
  final RiderUserModel? userModel;

  final RiderUserModel? userModel2;
  final AvailableModel? availableModel;
  const Payment(
      {Key? key, this.userModel, this.userModel2, this.availableModel})
      : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: w,
      appBar: AppBar(
        backgroundColor: w,
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Color(0xff1e1d34),
            fontSize: 20,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              "How do you want to pay?",
              style: TextStyle(
                color: Color(0xff1e1d34),
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "Choose your prefeered payment methos",
              style: TextStyle(
                color: Color(0xff434255),
                fontSize: 16,
              ),
            ),
            sb('h', dp * 3),
            Container(
              height: mediaHeight * 0.123,
              decoration: BoxDecoration(
                  boxShadow: boxshaow(), color: w, borderRadius: br(15)),
              child: InkWell(
                onTap: () => show(
                    context,
                    DialogWithdraw(
                      availableModel: widget.availableModel!,
                      userModel2: widget.userModel2,
                      userModel: widget.userModel,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: Config.svg('assets/svg/cash.svg', 24, null),
                    title: const Text(
                      "Transfer",
                      style: TextStyle(
                        color: Color(0xff1e1d34),
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      "Transfer to driver",
                      style: TextStyle(
                        color: Color(0xff434255),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            sb('h', dp),
            Container(
              height: mediaHeight * 0.127,
              decoration: BoxDecoration(
                  boxShadow: boxshaow(), color: w, borderRadius: br(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    makePayment();
                    show(
                        context,
                        Success(
                          availableModel: widget.availableModel!,
                          userModel2: widget.userModel2,
                          userModel: widget.userModel,
                        ));
                  },
                  child: ListTile(
                    leading: Config.svg('assets/svg/cash.svg', 24, null),
                    title: const Text(
                      "Cash",
                      style: TextStyle(
                        color: Color(0xff1e1d34),
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      "Pay with Cash",
                      style: TextStyle(
                        color: Color(0xff434255),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            sb('h', dp),
            Container(
              height: mediaHeight * 0.15,
              decoration: BoxDecoration(
                  boxShadow: boxshaow(), color: w, borderRadius: br(15)),
              child: InkWell(
                onTap: () => pay(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      text("Online Payment", FontWeight.bold, b, 18),
                      esb('w', dp),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pay() {
    MakePayment(
            userModel: widget.userModel!,
            ctx: context,
            email: widget.userModel!.email!,
            price: widget.availableModel!.amount)
        .chargeCardAndMakePayment();
  }

  void makePayment() async {
    var data = {
      "amount": widget.availableModel!.amount,
      "driverId": widget.availableModel!.driverId,
      "distance": widget.availableModel!.distanceValue,
      "driverName": widget.availableModel!.driverName,
      "rideId": widget.availableModel!.id,
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
