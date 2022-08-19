import 'package:cabby/driver/auth/firstScreen.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: pColor),
      home: const OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AuthFirstScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/svg/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration =  PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          titleWidget: Center(
              child: Text("Request Ride",
                  style: Config.style(FontWeight.w600, const Color(0xff1E1D34), 20))),
          bodyWidget: Center(
            child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                    "Enter ldestination location, to request a ride from avilable drivers close by",
                    style:
                        Config.style(FontWeight.w600, const Color(0xff7B7896), 14)),
              ),
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: mediaHeight* 0.08,
              ),
              _buildImage('logo.png', 100),
              _buildImage('intro1.png', mediaWidth* 0.705),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
          ),
        ),
        PageViewModel(
          titleWidget: Center(
              child: Text("Confirm Your Driver",
                  style: Config.style(FontWeight.w600, const Color(0xff1E1D34), 20))),
          bodyWidget: Center(
              child: Center(
            child: Text(
                "Track your order as a customer or track order as a dispatch rider",
                style: Config.style(FontWeight.w600, const Color(0xff7B7896), 14)),
          )),
          image: Column(
            children: [
              SizedBox(
                height: mediaHeight* 0.08,
              ),
              _buildImage('logo.png', 100),
              _buildImage('intro2.png', mediaWidth* 0.705),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
          ),
        ),
        PageViewModel(
          titleWidget: Center(
            child: Text("Track Your Ride",
                style: Config.style(FontWeight.w600, const Color(0xff1E1D34), 20)),
          ),
          bodyWidget: Center(
              child: Center(
            child: Text(
                "Register, List and Reach new customers, get more sales",
                style: Config.style(FontWeight.w600, const Color(0xff7B7896), 14)),
          )),
          image: Column(
            children: [
              SizedBox(
                height: mediaHeight* 0.08,
              ),
              _buildImage('logo.png', 100),
              _buildImage('intro3.png', mediaWidth* 0.705),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip', style: TextStyle(color: Color(0xffC9C900))),
      next: const Icon(
        Icons.arrow_forward,
        color: Color(0xffC9C900),
      ),
      done: const Text('Done',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Color(0xffC9C900))),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Color(0xffC9C900),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
