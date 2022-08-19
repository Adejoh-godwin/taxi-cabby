import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:cabby/driver/widget/shared/widgets/socialMediaLogin.dart';

class PayWithCash extends StatelessWidget {
  final GestureTapCallback? onTap;

  const PayWithCash({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          width: Dimensions().getWidth(context),
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
                  child: Image.asset('assets/inapp/car.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  // flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cash ',
                        style: k14500,
                      ),
                      Text(
                        'Pay with cash ',
                        style: k14400Faint,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
