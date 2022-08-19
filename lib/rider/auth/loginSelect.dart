import 'package:cabby/driver/auth/login.dart';
import 'package:cabby/rider/auth/SelectUserType.dart';
import 'package:cabby/rider/auth/login.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class LoginUserType extends StatelessWidget {
  double systemHeight = 0;
  double systemWidth = 0;

  LoginUserType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: systemHeight / 10,
              //freespace
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                'assets/onboarding/logo.png',
                // height: systemHeight / 3,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Select User Type',
              style: kMiniTitle,
            ),
            const SizedBox(height: 25),
            Container(
              width: systemWidth,
              child: Image.asset(
                'assets/onboarding/login.png',
                height: systemHeight / 3,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => goTo(SelectUserType(), context),
                    child: const Text(
                      'Sign Up or ',
                      style: kMiniTitleBold,
                    ),
                  ),
                 
                  InkWell(
                    onTap: () => goTo(LoginUserType(), context),
                    child: const Text(
                      'Login ',
                      style: kMiniTitleBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            DelayedDisplay(
              delay: const Duration(milliseconds: 800),
              child: UserTypeButtons(
                title: 'Login As User',
                buttonColor: primaryColor,
                textColour: 'dark',
                onPress: () {
                  goTo(const Login(), context);
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 1000),
              child: UserTypeButtons(
                title: 'Login As Driver',
                buttonColor: secondaryColor,
                textColour: 'white',
                onPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DriverLogin(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
