// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paystack/flutter_paystack.dart';

class MakePayment {
  MakePayment(
      {required this.ctx,
      required this.userModel,
      required this.price,
      required this.email});

  BuildContext ctx;
  final RiderUserModel userModel;
  int price;

  String email;
  int newBalance = 0;
  PaystackPlugin paystack = PaystackPlugin();
  // TransactionModel? model;

  //Reference

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    // return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
    return '${DateTime.now().millisecondsSinceEpoch}';
  }

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await paystack.initialize(publicKey: Config.paystackKey);
  }

  //Method Charging card
  chargeCardAndMakePayment() async {
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = (price + 50) * 100
        ..email = email
        ..reference = _getReference()
        ..card = _getCardUI();

      CheckoutResponse response = await paystack.checkout(
        ctx,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo: Image.asset(
          'assets/tlogo.png',
          width: 40,
        ),
      );

      // print("Response $response");

      if (response.status == true) {
        var data = {
          'agentId': userModel.id,
          'amount': price,
          'reference': _getReference(),
          'status': 'Success'
        };
        var url = "${globalUrl}pay-driver";
        var headers = {'Content-Type': 'application/json'};
        var response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(data));

        // print(data);
        var rsp = jsonDecode(response.body);
        var user = UserModel.fromJson(rsp['users']);
        Navigator.pop(ctx);

        // showDialog(
        //   context: ctx,
        //   builder: (BuildContext context) {
        //     return SuccessWithCancel(
        //       route: BillingDashboard(
        //         userModel: user,
        //       ),
        //       userModel: userModel,
        //       status: 'Success',
        //       text1: 'Transaction Successful',
        //       text2: 'Your deposit was successful',
        //       svg: 'assets/check.svg',
        //       color: Colors.green,
        //     );
        //   },
        // );
      } else {
        displayToastMessage("Transaction Failed", ctx);
      }
    });
  }
}
