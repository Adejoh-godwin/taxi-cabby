import 'dart:convert';

import 'package:cabby/driver/widget/shared/components/pay_with_card.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:cabby/driver/widget/shared/widgets/walletCard.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/usercard_model.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/add_card.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  final String? userId, token;
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const Wallet({Key? key, this.userId, this.token, this.userModel, this.userModel2}) : super(key: key);
  @override
  WalletState createState() => WalletState();
}

class WalletState extends State<Wallet> {
  double systemHeight = 0;

  double systemWidth = 0;
  static Future<List<CardModel>> getAllCard(token) async {
    String apiurl = "${globalUrl}user/card";

    final response = await http.get(Uri.parse(apiurl), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });

    final body = json.decode(response.body);

    return body.map<CardModel>(CardModel.fromJson).toList();
  }

  @override
  void initState() {
    getAllCard(widget.userModel2!.token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    systemHeight = Dimensions().getHeight(context);
    systemWidth = Dimensions().getWidth(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    const Text('Wallet', style: kOnboardTitle),
                    const SizedBox(
                      height: 30,
                    ),
                     WalletCard(450, '09/24'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Payment Methods',
                      style: k16500,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: systemHeight / 4,
                      child: FutureBuilder(
                          future: getAllCard(widget.userModel2!.token!),
                          builder:
                              (BuildContext ctx, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (ctx, index) => PayWithCard(
                                    onTap: null,
                                    cardImage: 'assets/inapp/creditcard.png',
                                    cardNumber:
                                        snapshot.data[index].card_number,
                                    expiryDate:
                                        snapshot.data[index].expirity_date,
                                    cvv: snapshot.data[index].cvv),
                              );
                            }
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddCard(
                            userId: widget.userId,
                            token: widget.token,
                          );
                        }));
                      },
                      child: Container(
                          width: systemWidth,
                          height: 80,
                          decoration:  const BoxDecoration(
                            color: greyFaintColor,
                            borderRadius:  BorderRadius.all(
                               Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '+   Add New Card',
                              style: kOnboardDetail,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    ));
  }
}
