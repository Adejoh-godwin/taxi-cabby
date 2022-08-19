import 'dart:async';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/welcome/intro.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
    loc();
  }

  displaySplash() {
    Timer(const Duration(seconds: 2), () async {
      Navigator.pushReplacement(context, CustomPageRoute(const App()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Expanded(
              child: Center(
                  child: Hero(
                      tag: "HeroOne",
                      child: Config.svg(
                          'assets/svg/logo.svg', 50.0, const Color(0xffC9C900)))),
            ),
            Image(
              image: const AssetImage('assets/svg/empty_street.png'),
              fit: BoxFit.contain,
              width: mediaWidth,
            ),
          ],
        ),
      ),
    );
  }

  String loc() {
    return 'hhnhhh';
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  final Widget child;

  CustomPageRoute(this.child);

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(seconds: 4);
  BuildContext? context;
  @override
  Widget buildPage(context, Animation<double>? animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation!,
      child: child,
    );
  }
}
