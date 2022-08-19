import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:flutter/material.dart';

import '../size_dimension.dart';

class FaqCard extends StatelessWidget {
  final String faqText, faqResponse;

  const FaqCard(this.faqText, this.faqResponse, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          initiallyExpanded: true,
          backgroundColor: const Color(0xFFFFF4F4),
          collapsedBackgroundColor: const Color(0xFFFFF4F4),
          leading: const Icon(
            Icons.question_answer,
            color: primaryColor,
          ),
          title: Text(
            faqText,
            style: k14400NormalBold,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 5.0, 1.0, 18.0),
              child: SizedBox(
                width: Dimensions().getWidth(context) / 1.8,
                child: Text(
                  faqResponse,
                  style: k12400Normal,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
