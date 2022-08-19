// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'constants.dart';

Widget backButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: const Icon(
      Icons.arrow_back_sharp,
      size: 25,
      color: Colors.black,
    ),
  );
}

Widget topIconRight(Widget iconData, {GestureTapCallback? onTap}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
          backgroundColor: Colors.white, radius: 20, child: iconData),
    ),
  );
}

Widget createDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          icon,
          color: textFaintColor,
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text!,
            style: k14400Normal,
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget changeProfile(
    {IconData? icon,
    String? text,
    String? value,
    GestureTapCallback? onTap,
    BuildContext? context}) {
  double systemHeight = 0;
  double systemWidth = 0;
  systemHeight = MediaQuery.of(context!).size.height;
  systemWidth = MediaQuery.of(context).size.width;
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                // hintText: title,
                // filled: true,
                border: InputBorder.none,
                labelText: text,
                labelStyle: k12400Faint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                icon: Icon(
                  icon,
                  color: primaryColor,
                ),
                hintText: value,
                hintStyle: k14400NormalBold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(50, 20)),
            onPressed: onTap,
            child:  const Text(
              'change',
              style: k11400Faint,
            ),
          )
        ],
      ),
      SizedBox(
        height: 1,
        // color: primaryColor,
        width: systemWidth / 1.2,
        child: const Divider(
          thickness: 0.8,
          color: textFaintColorGrey,
        ),
      ),
    ],
  );
}

Widget changePassword(
    {IconData? icon,
    String? text,
    String? value,
    GestureTapCallback? onTap,
    BuildContext? context}) {
  double systemHeight = 0;
  double systemWidth = 0;
  systemHeight = MediaQuery.of(context!).size.height;
  systemWidth = MediaQuery.of(context).size.width;
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                // hintText: title,
                // filled: true,

                border: InputBorder.none,
                labelText: text,
                labelStyle: k12400Faint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                icon: Icon(
                  icon,
                  color: primaryColor,
                ),
                hintText: value,
                hintStyle: k14400NormalBold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(50, 20)),
            onPressed: onTap,
            child: const Text(
              'change',
              style: k11400Faint,
            ),
          )
        ],
      ),
      SizedBox(
        height: 1,
        // color: primaryColor,
        width: systemWidth / 1.2,
        child: const Divider(
          thickness: 0.8,
          color: textFaintColorGrey,
        ),
      ),
    ],
  );
}
