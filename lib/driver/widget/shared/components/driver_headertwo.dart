import 'package:flutter/material.dart';

import '../constants.dart';

class DriverHeaderTwo extends StatelessWidget {
  final String imageUrl;
  final String driverName, designation;

  const DriverHeaderTwo(this.imageUrl, this.driverName, this.designation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.fill)),
          ),
          Text(
            driverName,
            style: k16500,
          ),
          Text(
            designation,
            style: k14400Normal,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
