import 'package:cabby/driver/widget/shared/components/driver_header.dart';
import 'package:cabby/driver/widget/shared/widgets/messageReceive.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';


class ChatDriver extends StatefulWidget {
  const ChatDriver({Key? key}) : super(key: key);

  @override
  ChatDriverState createState() => ChatDriverState();
}

class ChatDriverState extends State<ChatDriver> {
  final TextEditingController _emailOrPhone = TextEditingController();
  final TextEditingController _passwordSecond = TextEditingController();

  double systemHeight = 0;

  double systemWidth = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: systemWidth,
              color: const Color(0xFFBAB9B9),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: whiteColor,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                backButton(context),
                                topIconRight(
                                  
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            const SizedBox(
                              height: 50,
                              child:
                                  DriverHeader('', "Micheal Ugwu K", 'Driver'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: systemWidth,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      height: systemHeight / 1.8,
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: const <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Today at 05:03 PM',
                              style: k14400Faint,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MessageReceive(
                              'Hello..., I have been waiting, What is taking your time?',
                              '09:20 AM',
                              true),
                          MessageReceive(
                              'Hello..., I have been waiting, What is taking your time?',
                              '09:21 AM',
                              false),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.9),
                      width: systemWidth,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Divider(
                            thickness: 0.9,
                            color: textFaintColorGrey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: systemWidth,
                      color: Colors.white.withOpacity(0.9),

                      // color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 20),
                            child: SizedBox(
                              // flex: 4,
                              width: systemWidth / 1.4,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "write a message",
                                  fillColor: whiteColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.send,
                            size: 34,
                            color: const Color(0xFFC9C900),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
