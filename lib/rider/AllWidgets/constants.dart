// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

double? mediaHeight;
double? mediaWidth;
Color? pColor = const Color(0xffC9C900);
Color? textColor = const Color(0xff7B7896);
Color? textColor2 = const Color(0xff1E1D34);
Color? sColor = const Color(0xff1E1D34);

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1.0,
      color: Colors.black,
      thickness: 1.0,
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final color;
  final radius;
  final child;

  const ContainerWidget({Key? key, this.color, this.radius, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius.toDouble()),
      ),
      child: child,
    );
  }
}
