import 'package:flutter/material.dart';

import '../constants.dart';

class SavedPlaceWidget extends StatelessWidget {
  final String? title, body;
  final Icon? myIcon;
  final GestureTapCallback? onTap;

  const SavedPlaceWidget({Key? key, this.title, this.body, this.myIcon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: myIcon),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title!,
                      style: kMiniTitleSmallBold,
                    ),
                    Text(
                      body!,
                      style: kFaintText,
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: const Text(
                'change',
                style: kForgetPassword,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
