import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class DisplayWarning {
  DisplayWarning(this.context);
  final BuildContext context;

  void displayWarningMotionToast(BuildContext context,
      {String? title, String? titleBody}) {
    if (title == "") {
      title = "--";
    }
    if (titleBody == "") {
      titleBody = "--";
    }
    MotionToast.warning(
      title: title!,
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      description: titleBody!,
      animationType: ANIMATION.FROM_RIGHT,
      position: MOTION_TOAST_POSITION.CENTER,
      width: Dimensions().getWidth(context) / 1.2,
    ).show(context);
  }
}
