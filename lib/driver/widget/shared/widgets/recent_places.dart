import 'package:flutter/material.dart';

import '../constants.dart';

class RecentPlaceWidget extends StatelessWidget {
  final String? title, body;

  const RecentPlaceWidget({Key? key, 
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
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
                    color: textFaintColorGreyTwo,
                    borderRadius: BorderRadius.all(
                       Radius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.history,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
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
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 5),
          child: Divider(
            thickness: 0.8,
            color: textFaintColorGrey,
          ),
        ),
      ],
    );
  }
}
