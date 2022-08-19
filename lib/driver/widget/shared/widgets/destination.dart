// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import '../constants.dart';

class DashMenu extends StatelessWidget {
  final Color? background;
  final TextStyle? textStyle;
  final IconData? icon;
  final String? text;
  final GestureTapCallback? onTap;

  const DashMenu({Key? key, this.background, this.icon, this.text, this.onTap, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
        child: Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: const Color(0xFFF5F1EB),
                  child: IconButton(
                      color: primaryColor,
                      // padding: EdgeInsets.all(10),
                      iconSize: 15,
                      icon: Icon(icon),
                      onPressed: () {
                        // do something
                      }),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  text!,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String body,
      String yesResponse, String noResponse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: new Text("Alert!!"),
          content: Text(
            body,
            // "Turn on your device location for better Experience.",
            style: kMiniTitleSmall,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    noResponse,
                    style: kMiniTitleSmall,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    yesResponse,
                    style: kTextPrimary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
