import 'package:flutter/material.dart';

import '../constants.dart';

class DriverHeader extends StatelessWidget {
  final String imageUrl;
  final String driverName, designation;

  const DriverHeader(this.imageUrl, this.driverName, this.designation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.fill)),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driverName,
                style: kMiniTitle600,
              ),
              Text(designation),
            ],
          ),
        ],
      ),
    );
  }
}
