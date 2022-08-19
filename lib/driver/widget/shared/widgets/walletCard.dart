import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:flutter/material.dart';

import '../size_dimension.dart';

class WalletCard extends StatelessWidget {
  final int balance;
  final String expiryDate;

  const WalletCard(this.balance, this.expiryDate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions().getWidth(context),
      height: 170,
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: Dimensions().getWidth(context),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF777490),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.monetization_on,
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Your Default card payment',
                  style: k14500White,
                )
              ],
            ),
          ),
          SizedBox(
            width: Dimensions().getWidth(context),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Balance',
                      style: k14400NormalWhite,
                    ),
                    Text(
                      balance.toString(),
                      style: k22400White,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    const Text(
                      'Expiry Date',
                      style: k14400NormalWhite,
                    ),
                    Text(
                      expiryDate,
                      style: k22400White,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
