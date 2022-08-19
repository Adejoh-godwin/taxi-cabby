import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_dimension.dart';

class RideViewType extends StatelessWidget {
  final String imageUrl;
  final String designation;

  const RideViewType(this.imageUrl, this.designation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions().getWidth(context),
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
          Radius.circular(5),
        ),
      ),
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  designation,
                  style: kForgetPassword,
                )),
          ),
        ],
      ),
    );
  }
}
