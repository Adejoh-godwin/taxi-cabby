import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:flutter/material.dart';

class UserTypeButtons extends StatelessWidget {
  final String? title;
  final Color? buttonColor;
  final String? textColour;
  // final String? className;
  final GestureTapCallback? onPress;
  // final Size? size;

  UserTypeButtons(
      {Key? key, this.title, this.buttonColor, this.onPress, this.textColour}) : super(key: key);
  double systemHeight = 0;
  double systemWidth = 0;
  @override
  Widget build(BuildContext context) {
    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: systemWidth / 1.2,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
              child: Text(
            title!,
            style: textColour == "white" ? kButtonTextWhite : kButtonText,
          )),
        ),
      ),
    );
  }
}
