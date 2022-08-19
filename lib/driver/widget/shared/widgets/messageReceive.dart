import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:flutter/material.dart';
import '../size_dimension.dart';

class MessageReceive extends StatelessWidget {
  final String? message, date;
  final bool isMe;

  const MessageReceive(this.message, this.date, this.isMe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isMe ? const Color(0xFFC9C900) : Colors.black,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
            width: Dimensions().getWidth(context) / 2,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                message!,
                style: isMe ? k14400Normal : k14400NormalWhite,
              ),
            ),
          ),
          Text(
            date!,
            style: k12400Faint,
          ),
        ],
      ),
    );
  }
}
