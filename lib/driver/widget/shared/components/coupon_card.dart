import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:cabby/driver/widget/shared/widgets/socialMediaLogin.dart';
import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final String title, description, code;
  final GestureTapCallback onTap;

  const CouponCard(this.title, this.description, this.onTap, this.code, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: k14500,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        'Apply ',
                        style: kForgetPassword,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: k12400Normal,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      code,
                      style: k12400NormalBold,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
