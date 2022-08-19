import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:cabby/driver/widget/shared/widgets/socialMediaLogin.dart';
import 'package:flutter/material.dart';

class PayWithCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? cardImage;
  final String? cvv;
  final String? expiryDate;
  final String? cardNumber;

  const PayWithCard(
      {Key? key, this.onTap, this.cardImage, this.cvv, this.expiryDate, this.cardNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          width: systemWidth,
          height: 80,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                SizedBox(
                  width: systemWidth / 4,
                  child: Image.asset(cardImage!),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardNumber!,
                        style: k14500,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expiryDate!,
                            style: k14400Faint,
                          ),
                          Text(
                            cvv!.toString(),
                            style: k14400Faint,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //     flex: 1,
                //     child: Icon(
                //       Icons.check_circle_outlined,
                //       size: 30,
                //       color: primaryColor,
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
