import 'package:flutter/material.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';

import '../constants.dart';

class RecommendedRide extends StatelessWidget {
  final String? imageUrl, carName, description, time;
  final int? amount;
  // final Icon? myIcon;
  final GestureTapCallback? onTap;

  const RecommendedRide(
      {Key? key, this.imageUrl,
      this.onTap,
      this.carName,
      this.description,
      this.amount,
      this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          child: Row(
            children: [
              Expanded(
                child: Image.network('$imageUrl'),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      carName!,
                      style: k14500,
                    ),
                    Text(
                      description!,
                      style: k14400Faint,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'NGN $amount',
                      style: k14500,
                    ),
                    Text(
                      'in $time',
                      style: k14400Faint,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
