import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:cabby/driver/widget/shared/widgets/socialMediaLogin.dart';
import 'package:flutter/material.dart';

class PaymentHistoryCard extends StatelessWidget {
  final String paidTo, datePaid, timePaid;
  final int price;
  final String? distance;

  const PaymentHistoryCard(
      this.paidTo, this.datePaid, this.price, this.timePaid, this.distance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffDA962F),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_balance_wallet,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paid to $paidTo',
                        style: k16400Normal,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price.toString(),
                            style: kUserHomePage,
                          ),
                          Text(
                            '$distance km',
                            style: kForgetPassword,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          datePaid,
                          style: k12400Faint,
                        ),
                        Text(
                          timePaid,
                          style: k12400Faint,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: systemWidth / 1.5,
            child: Divider(
              thickness: 0.8,
              color: textFaintColorGrey.withOpacity(0.4),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
