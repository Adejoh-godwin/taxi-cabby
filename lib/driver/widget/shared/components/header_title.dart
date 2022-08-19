import 'package:flutter/material.dart';

import '../constants.dart';

class HeaderTitle extends StatelessWidget {
  final String? mainTitle, subTitle;

  const HeaderTitle({Key? key, this.mainTitle, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          mainTitle!,
          style: kMiniTitleBold,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subTitle!,
          style: kHeaderSupport,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
