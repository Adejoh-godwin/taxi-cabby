import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

double systemHeight = 0;
double systemWidth = 0;

Widget socialMedia(BuildContext context) {
  systemHeight = MediaQuery.of(context).size.height;
  systemWidth = MediaQuery.of(context).size.width;
  return Container(
    width: systemWidth / 1.4,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SignInButton.mini(
          buttonType: ButtonType.facebook,
          onPressed: () {},
        ),
        SignInButton.mini(
          buttonType: ButtonType.google,
          onPressed: () {},
        ),
        SignInButton.mini(
          buttonType: ButtonType.twitter,
          onPressed: () {},
        ),
      ],
    ),
  );
}
