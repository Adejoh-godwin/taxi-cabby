import 'dart:io';

import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

///sharing platform
enum Share {
  facebook,
  url,
  messenger,
  twitter,
  whatsapp,
  whatsapppersonal,
  whatsappbusiness,
  sharesystem,
  shareinstagram,
  sharetelegram
}

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  String platformVersion = 'Unknown';
  File? file;
  ImagePicker picker = ImagePicker();
  bool videoEnable = false;
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? platformVersion;

    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion!;
    });
  }

  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: w,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: w,
        leading: backButton(context),
        actions: const [Icon(Icons.notifications)],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Invite Friends",
              style: TextStyle(
                color: Color(0xff1e1d34),
                fontSize: 20,
                fontFamily: "Lato",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          sb('h', mediaHeight * .05),
          Container(
            width: 233,
            height: 168,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Config.svg('assets/svg/invite.svg', 200, null),
          ),
          sb('h', mediaHeight * .1),
          const Text(
            "Invite Your friends",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff1e1d34),
              fontSize: 25,
              fontFamily: "Lato",
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            width: 189,
            child: Text(
              "to get 3 coupons free for each invite",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff1e1d34),
                fontSize: 16,
              ),
            ),
          ),
          sb('h', mediaHeight * .05),
          Center(
            child: SizedBox(
                width: mediaWidth,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        onButtonTap(Share.url);
                        // displayToastMessage('Not available yet', context);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffededed),
                        ),
                        child: Config.svg('assets/svg/facebook.svg', 24, null),
                      ),
                    ),
                    sb('w', dp),
                    InkWell(
                      onTap: () async {
                        displayToastMessage('Not available yet', context);
                        onButtonTap(Share.url);
                        // onButtonTap(Share.whatsapp);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffededed),
                        ),
                        child: Config.svg('assets/svg/instagram.svg', 24, null),
                      ),
                    ),
                    sb('w', dp),
                    InkWell(
                      onTap: () async {
                        onButtonTap(Share.twitter);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffededed),
                        ),
                        child: Config.svg('assets/svg/twitter.svg', 24, null),
                      ),
                    ),
                  ],
                )),
          ),
          sb('h', dp),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: mediaWidth,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffc8c800),
              ),
              child: const Center(child: Text("Invite Friends")),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onButtonTap(Share share) async {
    String msg = 'Ride with taxi cabby';
    String url =
        'https://play.google.com/store/apps/details?id=com.taxi_cabby.cabby';

    String? response;
    bool? res;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case Share.messenger:
        response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
        break;
      case Share.url:
        res = canLaucnh(url);

        break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
      case Share.whatsapp:
        if (file != null) {
          response = await flutterShareMe.shareToWhatsApp(
              imagePath: file!.path,
              fileType: videoEnable ? FileType.video : FileType.image);
        } else {
          response = await flutterShareMe.shareToWhatsApp(msg: msg);
        }
        break;
      case Share.whatsappbusiness:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.sharesystem:
        response = await flutterShareMe.shareToSystem(msg: msg);
        break;
      case Share.whatsapppersonal:
        response = await flutterShareMe.shareWhatsAppPersonalMessage(
            message: msg, phoneNumber: 'phone-number-with-country-code');
        break;
      case Share.shareinstagram:
        response = await flutterShareMe.shareToInstagram(
            filePath: file!.path,
            fileType: videoEnable ? FileType.video : FileType.image);
        break;
      case Share.sharetelegram:
        response = await flutterShareMe.shareToTelegram(msg: msg);
        break;
    }
    debugPrint(response);
  }

  canLaucnh(uri) async {
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(uri);
    } else {
      throw Exception('Unable to share on windows');
    }
  }
}
