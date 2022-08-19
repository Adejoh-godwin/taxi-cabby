import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_dimension.dart';

class RideViewDetails extends StatelessWidget {
  final String vehicleName, description, plateNumber,time;
  final int amount;

  const RideViewDetails(this.vehicleName, this.description, this.plateNumber,
      this.amount, this.time, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Column(
        children: [
          Container(
            width: Dimensions().getWidth(context),
            height: 80,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                 Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        vehicleName,
                        style: k16500,
                      ),
                      Text(
                        description,
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
                        plateNumber,
                        style: k16500,
                      ),
                      const Text(
                        'Plate No: ',
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
                        'N $amount',
                        style: k16500,
                      ),
                      Text(
                        'In $time',
                        style: k14400Faint,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
