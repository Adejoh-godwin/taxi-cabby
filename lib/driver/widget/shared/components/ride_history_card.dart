import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:cabby/driver/widget/shared/widgets/socialMediaLogin.dart';

import '../size_dimension.dart';

class RideHistoryCard extends StatelessWidget {
  final String pickUp, dropOff, status;
  final int price;

  const RideHistoryCard(this.pickUp, this.dropOff, this.status, this.price, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: Dimensions().getWidth(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
                          child: Icon(
                            Icons.trip_origin,
                            color: primaryColor,
                          ),
                        ),
                        Expanded(
                          child: DottedLine(
                            direction: Axis.vertical,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PICK UP',
                            style: kFaintText,
                          ),
                          TextFormField(
                            initialValue: pickUp,
                            style: k14400Normal,
                            decoration: const InputDecoration.collapsed(
                                hintText: "", hintStyle: k14400Normal),
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
                          const Text(
                            'DROP OFF',
                            style: kFaintText,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Dimensions().getWidth(context) / 1.7,
                                child: TextFormField(
                                  initialValue: dropOff,
                                  style: k14400Normal,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: '', hintStyle: k14400Normal),
                                ),
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: systemWidth / 1.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price.toString(),
                    style: k14500,
                  ),
                  Text(
                    status,
                    style: kForgetPassword,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
