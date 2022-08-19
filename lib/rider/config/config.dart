// ignore_for_file: unused_element

import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:cabby/rider/customer/shared/constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Config {
  static todayDate(date) {
    var formatter = DateFormat('dd-MM-yyyy');
    // String formattedTime = DateFormat('kk:mm:a').format(date);
    String formattedDate = formatter.format(date);

    return (formattedDate);
  }

  Color? pColor = const Color(0xffC9C900);

  static const String paystackKey =
      "pk_test_0b4931121ee630abc05b850f06924f9fb7e234c2";

  static SharedPreferences? sharedPreferences;
  static User? user;
  static FirebaseAuth? auth;
  static FirebaseFirestore? firestore;

  //static String globalUrl = 'http://192.168.1.241/laravel/zeus/apicall/';

  static svg(assets, height, color) {
    return SvgPicture.asset(
      assets,
      height: height.toDouble(),
      color: (color == '') ? null : color,
    );
  }

  String title = "";
  double starCounter = 0.0;

  String rideType = "";

  static style(fontWeight, Color color, size) {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontWeight: fontWeight, fontSize: size.toDouble(), color: color));
  }
}

CollectionReference customers =
    FirebaseFirestore.instance.collection('customers');

CollectionReference drivers = FirebaseFirestore.instance.collection('drivers');

CollectionReference rideRequestRef = FirebaseFirestore.instance
    .collection("drivers")
    .doc(currentfirebaseUser!.uid)
    .collection("newRide");

Position? currentPosition;
String mapKey = "AIzaSyDXua-cpwWEOGI5sekYuVRS2qEPEwT_pCo";
// String mapKey ="AIzaSyAAT1PDwTC5yAVBpr2TypomsSw76gC2bQo";

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
User? firebaseUser;

// DriverModel? driverCurrentInfo;
// //CustomerModel? userCurrentInfo;
// UsersModel? userCurrentInfo;

User? currentfirebaseUser;

StreamSubscription<Position>? homeTabPageStreamSubscription;

StreamSubscription<Position>? rideStreamSubscription;

// DriverModel? driversInformation;
// displayToastMessage(String message, context) {
//   Fluttertoast.showToast(msg: message);
// }

random(min, max) {
  var rn = Random();
  return min + rn.nextInt(max - min);
}

numformat(number) {
  return NumberFormat.currency(name: 'NGN ').format(number).toString();
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

// String globalUrl = 'http://10.0.2.2:8000/api/';
String globalUrl = 'https://tx.teamenvio.com/api/';
// String globalUrl = 'http://127.0.0.1:8000/api/';
// String globalUrl = "https://api-cabby.raadaa.com/api/";
String? defaultImg =
    'https://firebasestorage.googleapis.com/v0/b/sdeli-3567a.appspot.com/o/profiledefault.jpg?alt=media&token=97ce85e9-3b27-44f3-9012-1f6a9e72d154';

class MapKitAssistant {
  static double getMarkerRotation(sLat, sLng, dLat, dLng) {
    var rot =
        SphericalUtil.computeHeading(LatLng(sLat, sLng), LatLng(dLat, dLng));

    return rot.toDouble();
  }
}

time(date) {
  String formattedTime = DateFormat.Hms().format(date);
  return formattedTime;
}

todayDate(date) {
  var formatter = DateFormat('dd-MM-yyyy');
  // String formattedTime = DateFormat('kk:mm:a').format(date);
  String formattedDate = formatter.format(date);

  return (formattedDate);
}

Route _createRoute(nav) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nav,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}

void show(context, Widget widget) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget;
      });
}

final assetsAudioPlayer = AssetsAudioPlayer();

goTo(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}

Color? sColor = const Color(0xff1E1D34);

double mediaHeight = 0.00;
double mediaWidth = 0.00;
bool carUpdate = false;
bool internetConnection = true;
Color c4 = const Color(0xffC4C4C4);
Color e5 = const Color(0xffE5E5E5);
Color fa = const Color(0xffFAFAFA);
Color f5 = const Color(0xffF5F5F5);
Color b = Colors.black;
Color w = Colors.white;
Color pColor = const Color(0xffbcbc13);
Color pColor1 = const Color(0xffff6600);
Color blue = const Color(0xff1089CD);
Color textColor = const Color(0xff08102E);
Color? textColor2 = const Color(0xff1E1D34);

FontWeight w100 = FontWeight.w100;
FontWeight w200 = FontWeight.w200;
FontWeight w300 = FontWeight.w300;
FontWeight w400 = FontWeight.w400;
FontWeight w500 = FontWeight.w500;
FontWeight w600 = FontWeight.w600;
FontWeight w700 = FontWeight.w700;
FontWeight w800 = FontWeight.w800;
FontWeight w900 = FontWeight.w900;
FontWeight bold = FontWeight.bold;
FontWeight normal = FontWeight.normal;

buildUser(text1, text2) {
  return Column(
    children: [
      Row(
        children: [
          Text(text1,
              style:
                  Config.style(FontWeight.w300, const Color(0xff888888), 13.0)),
          sb('h', dw),
          Expanded(
            child: Text(text2.toString(),
                textAlign: TextAlign.end,
                style: Config.style(FontWeight.w400, Colors.black, 13.0)),
          )
        ],
      ),
      SizedBox(
        height: mediaHeight * 0.02,
      ),
    ],
  );
}

Widget backButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: const Icon(
      Icons.arrow_back_sharp,
      size: 25,
      color: Colors.black,
    ),
  );
}

colField(text1, TextEditingController controller, maxLine) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text1,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color(0XFF4D4D4D),
            ),
          )),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: controller,
        maxLines: maxLine,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              //borderSide: const BorderSide(),
            ),
            hintStyle: const TextStyle(
                color: Color(0Xff969799), fontFamily: "WorkSansLight"),
            filled: true,
            fillColor: const Color(0XFFf5f5f5),
            hintText: text1),
      ),
    ],
  );
}

Container _buildTitledContainer(height, {Widget? child}) {
  return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffff602e), Color(0xffFFC225)]),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child);
}

showBottom(context, Widget widget) {
  // adding some properties
  showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return widget;
      });
}

sb(h, dp) {
  if (h == 'h') {
    return SizedBox(
      height: dp.toDouble(),
    );
  }
  return SizedBox(
    width: dp.toDouble(),
  );
}

esb(h, dp) {
  if (h == 'h') {
    return Expanded(
      child: SizedBox(
        height: dp.toDouble(),
      ),
    );
  }
  return Expanded(
    child: SizedBox(
      width: dp.toDouble(),
    ),
  );
}

// backButton(context, color) {
//   return IconButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       icon: Icon(
//         Icons.arrow_back,
//         color: color,
//       ));
// }

appBar(color, context, text, widget) {
  return AppBar(
    backgroundColor: color,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        )),
    title: Text(
      text,
      style: Config.style(FontWeight.bold, b, 22),
    ),
    actions: [widget],
  );
}

percentToAmt(percent, amount) {
  if (percent == 0) {
    return 0;
  }
  return (percent / 100) * amount;
}

format(number) {
  return NumberFormat.currency(name: '').format(number).toString();
}

goToReplacement(Widget page, BuildContext context) {
  Navigator.of(context).pushReplacement(_createRoute(page));
}

internetCheck(context) async {
  final bool isConnected = await InternetConnectionChecker().hasConnection;

  if (!isConnected) {
    // print('ooooo');
    internetConnection = false;

    // goTo(
    //     const NoInternet(
    //       status: 'Error',
    //       text1: 'No Internet Connection',
    //       text2:
    //           'We are having troube connecting to the internet, \nplease check if you have an  active internet connection',
    //       svg: 'assets/wifi.svg',
    //       color: Colors.red,
    //     ),
    //     context);
  }
}

TextFormField buildTextFormField(controller, hint, icon, radius) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius.toDouble()),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(
            color: Color(0Xff969799), fontFamily: "WorkSansLight"),
        filled: true,
        fillColor: const Color(0XFFf5f5f5),
        hintText: hint),
  );
}

container(height, width, widget, color, radius) {
  return Container(
    width: width,
    child: widget,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(radius.toDouble())),
  );
}

boxshaow() {
  return [
    BoxShadow(
      color: c4.withOpacity(0.5),
      spreadRadius: 0.5,
      blurRadius: 20,
      offset: const Offset(0, 3), // changes position of shadow
    )
  ];
}

RoundedRectangleBorder borderRadius(radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius.toDouble()),
  );
}

br(radius) {
  return BorderRadius.circular(radius.toDouble());
}

double dp = mediaHeight * 0.02;
double dw = mediaWidth * 0.02;
dateDiff(date) {
  var from = DateTime.now();
  DateTime to = DateTime.parse(date);
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

dateDiff2(date) {
  var from = DateTime.now();
  DateTime to = DateTime.parse(date);
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

dateFormat(date) {
  // Formatted Date
  return DateFormat.yMMMEd().format(DateTime.parse(date));
}

   String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }


text(text, fontWeight, Color color, size) {
  return Text(text,
      style: GoogleFonts.inter(
          textStyle: TextStyle(
              fontWeight: fontWeight,
              fontSize: size.toDouble(),
              color: color)));
}

tlogo() {
  return Image.asset('assets/tlogo.png');
}

eAll(value) {
  return EdgeInsets.all(value.toDouble());
}

Widget topIconRight( {GestureTapCallback? onTap}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Config.svg("assets/svg/notificationbell.svg", 24, null)),
    ),
  );
}

Widget createDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          icon,
          color: textFaintColor,
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text!,
            style: k14400Normal,
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget changeProfile(
    {IconData? icon,
    String? text,
    String? value,
    GestureTapCallback? onTap,
    BuildContext? context}) {
  // double systemHeight = 0;
  double systemWidth = 0;
  // systemHeight = MediaQuery.of(context!).size.height;
  systemWidth = MediaQuery.of(context!).size.width;
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                // hintText: title,
                // filled: true,
                border: InputBorder.none,
                labelText: text,
                labelStyle: k12400Faint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                icon: Icon(
                  icon,
                  color: primaryColor,
                ),
                hintText: value,
                hintStyle: k14400NormalBold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(50, 20)),
            onPressed: onTap,
            child: const Text(
              'change',
              style: k11400Faint,
            ),
          )
        ],
      ),
      SizedBox(
        height: 1,
        // color: primaryColor,
        width: systemWidth / 1.2,
        child: const Divider(
          thickness: 0.8,
          color: textFaintColorGrey,
        ),
      ),
    ],
  );
}

Widget changePassword(
    {IconData? icon,
    String? text,
    String? value,
    GestureTapCallback? onTap,
    BuildContext? context}) {
  double systemWidth = 0;
//  double systemHeight = MediaQuery.of(context!).size.height;
  systemWidth = MediaQuery.of(context!).size.width;
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                // hintText: title,
                // filled: true,

                border: InputBorder.none,
                labelText: text,
                labelStyle: k12400Faint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                icon: Icon(
                  icon,
                  color: primaryColor,
                ),
                hintText: value,
                hintStyle: k14400NormalBold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(50, 20)),
            onPressed: onTap,
            child: const Text(
              'change',
              style: k11400Faint,
            ),
          )
        ],
      ),
      SizedBox(
        height: 1,
        // color: primaryColor,
        width: systemWidth / 1.2,
        child: const Divider(
          thickness: 0.8,
          color: textFaintColorGrey,
        ),
      ),
    ],
  );
}

Icon star(color, {Color? colors}) {
  return Icon(
    Icons.star,
    color: colors,
    size: 20,
  );
}
// ignore_for_file: unused_local_variable

// import 'package:flutter/material.dart';

const Color textColorPrimary = Color(0xFF1E1D34);
const Color textFaintColorGrey = Color(0xFFC4C4C4);
const Color textFaintColorGreyTwo = Color(0xFFF4F4F4);
const Color textColorPrimaryTwo = Color(0xff3e4095);
const Color primaryColor = Color(0xFFBDBD13);

const Color secondaryColor = Color(0xFF1E1D34);
const Color whiteColor = Color(0xFFFFFFFF);
const Color pinkColor = Color(0xFFEB996E);
const Color textFieldColour = Color(0xFFE0E0E0);
const Color textFaintColor = Color(0xFF7B7896);
const Color greyFaintColor = Color(0xFFF3F3F3);
const Color ratingColor = Color(0xFFFF9B03);
const Color textSupportColor = Color(0xFFE79E30);

// const Color textColorPrimaryTwoa = Color(0xff3e4095);
// Color textColorPrimaryThree = Colors.blue.shade200;

const kOnboardSKip = TextStyle(
  color: textColorPrimary,
  fontSize: 15.0,
  letterSpacing: 1.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w500,
);
const kMiniTitle600 = TextStyle(
    color: textColorPrimary,
    fontSize: 18.0,
    fontFamily: 'LatoRegular',
    fontWeight: FontWeight.w600);

const kOnboardTitle = TextStyle(
    color: textColorPrimary,
    fontSize: 20.0,
    fontFamily: 'LatoRegular',
    fontWeight: FontWeight.w600);
const kOnboardDetail = TextStyle(
    color: textFaintColor,
    fontSize: 16.0,
    height: 1.71,
    fontFamily: 'LatoRegular',
    fontWeight: FontWeight.w100);
const kFaintText = TextStyle(
    color: textFaintColor,
    fontSize: 12.0,
    // height: 1.71,
    fontFamily: 'LatoRegular',
    fontWeight: FontWeight.w100);
const kTextPrimary = TextStyle(
    color: primaryColor,
    fontSize: 16.0,
    height: 1.71,
    fontFamily: 'LatoRegular',
    fontWeight: FontWeight.w100);

const kMiniTitle = TextStyle(
  color: textColorPrimary,
  fontSize: 18.0,
  fontFamily: 'LatoRegular',
);
const kMiniTitleSmall = TextStyle(
    color: textSupportColor,
    fontSize: 16.0,
    fontFamily: 'LatoRegular',
    letterSpacing: -0.3);
const kMiniTitleSmallBold = TextStyle(
  color: textColorPrimary,
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  fontFamily: 'LatoRegular',
);
const kTextFieldTitle = TextStyle(
  color: textColorPrimary,
  fontSize: 14.0,
  fontFamily: 'LatoRegular',
);

const kForgotPassword = TextStyle(
  color: textSupportColor,
  fontSize: 14.0,
  fontFamily: 'LatoRegular',
);
const kHeaderSupport = TextStyle(
  color: textColorPrimary,
  fontSize: 14.0,
  fontFamily: 'LatoRegular',
);
const kHeaderSupportWhite = TextStyle(
  color: whiteColor,
  fontSize: 14.0,
  fontFamily: 'LatoRegular',
);

const kMiniTitleBold = TextStyle(
  color: textColorPrimary,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'LatoRegular',
);

const kButtonText = TextStyle(
  color: textColorPrimary,
  fontSize: 18.0,
  fontFamily: 'LatoRegular',
);

const kButtonTextWhite = TextStyle(
  color: whiteColor,
  fontSize: 18.0,
  fontFamily: 'LatoRegular',
);

const kForgetPassword = TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'LatoRegular',
);

const kUserHomePage = TextStyle(
  color: textColorPrimary,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);
const k14500 = TextStyle(
  color: textColorPrimary,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'LatoRegular',
);
const k14500White = TextStyle(
  color: whiteColor,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'LatoRegular',
);
const k18600 = TextStyle(
  color: textColorPrimary,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'LatoRegular',
);
const k18600White = TextStyle(
  color: whiteColor,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'LatoRegular',
);
const k16500 = TextStyle(
  color: textColorPrimary,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'LatoRegular',
);
const k16400Faint = TextStyle(
  color: textFaintColor,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: 'LatoRegular',
);
const k16400Normal = TextStyle(
  color: textColorPrimary,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: 'LatoRegular',
);
const k16400White = TextStyle(
  color: whiteColor,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: 'LatoRegular',
);

const k16500White = TextStyle(
  color: whiteColor,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: 'LatoRegular',
);
const k14400Faint = TextStyle(
  color: textFaintColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k14400Normal = TextStyle(
  color: textColorPrimary,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k14400NormalBold = TextStyle(
  color: textColorPrimary,
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'LatoRegular',
);
const k14400NormalWhite = TextStyle(
  color: whiteColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k12400Faint = TextStyle(
  color: textFaintColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k11400Faint = TextStyle(
  color: textFaintColor,
  fontSize: 11.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k12400Normal = TextStyle(
  color: textColorPrimary,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k12400NormalBold = TextStyle(
  color: textColorPrimary,
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'LatoRegular',
);
const k12400Faintb = TextStyle(
  color: textFaintColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k12400White = TextStyle(
  color: whiteColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k22400White = TextStyle(
  color: whiteColor,
  fontSize: 22.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'LatoRegular',
);
const k25600 = TextStyle(
  color: textColorPrimary,
  fontSize: 25.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'LatoRegular',
);

Widget userTypeButton(String? asWhat, Color? buttonColour, String? textColour,
    BuildContext context) {
  double systemHeight = 0;
  double systemWidth = 0;
  systemHeight = MediaQuery.of(context).size.height;
  systemWidth = MediaQuery.of(context).size.width;
  return Container(
    width: systemWidth / 1.2,
    decoration: BoxDecoration(
      color: buttonColour,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Text(
        asWhat!,
        style: textColour == "white" ? kButtonTextWhite : kButtonText,
      )),
    ),
  );
}

Widget userTypeText(Size size, String title, TextEditingController cont) {
  return SizedBox(
    width: size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    $title',
            style: kTextFieldTitle,
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            // style: TextStyle(height: 1),
            controller: cont,
            decoration: InputDecoration(
              // hintText: title,
              fillColor: textFieldColour,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget textFormField({
//   String? hint,
//   String? error,
//   TextInputType? keyboardType,
//   Function(dynamic)? onSave,
//   String Function(String?)? validator,
// }) =>
//     Container(
//         // margin: EdgeInsets.only(bottom: Dimensions().getHeight(context, 2)),
//         child: TextFormField(
//       keyboardType: keyboardType ?? TextInputType.text,
//       decoration: InputDecoration(
//         // hintText: title,
//         fillColor: textFieldColour,
//         filled: true,
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(width: 1, color: Colors.white),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(width: 3, color: Colors.white),
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       onSaved: onSave,
//       // onSaved: onSave,
//       validator: (validator != null)
//           ? validator
//           : (error != null)
//               ? (val) => (val!.isEmpty) ? error : null
//               : null,
//     ));

Widget userTypeTextForm(Size size, String title, Widget formField) {
  return SizedBox(
    width: size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    $title',
            style: kTextFieldTitle,
          ),
          const SizedBox(
            height: 5,
          ),
          formField
        ],
      ),
    ),
  );
}

Widget userTypeTextWithIcon(String title, TextEditingController cont) {
  return SizedBox(
    width: mediaWidth,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    $title',
            style: kTextFieldTitle,
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            // style: TextStyle(height: 1),
            controller: cont,
            decoration: InputDecoration(
              // hintText: title,
              fillColor: textFieldColour,
              filled: true,
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.dynamic_form_rounded,
                color: primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget userTypeTextHint(
    Size size, String title, String hint, TextEditingController cont) {
  return SizedBox(
    width: size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    $title',
            style: kTextFieldTitle,
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            // style: TextStyle(height: 1),
            controller: cont,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'LatoRegular',
                  fontWeight: FontWeight.w300),
              fillColor: textFieldColour,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget userTypeButtonSecond(String? asWhat, Color? buttonColour,
    String? textColour, BuildContext context) {
  double systemHeight = 0;
  double systemWidth = 0;
  systemHeight = MediaQuery.of(context).size.height;
  systemWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
    child: Container(
      width: systemWidth / 1.5,
      decoration: BoxDecoration(
        color: buttonColour,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          asWhat!,
          style: k14500,
        )),
      ),
    ),
  );
}

class UserTypeButtons extends StatelessWidget {
  final String? title;
  final Color? buttonColor;
  final String? textColour;
  // final String? className;
  final GestureTapCallback? onPress;
  // final Size? size;

  UserTypeButtons(
      {Key? key, this.title, this.buttonColor, this.onPress, this.textColour})
      : super(key: key);
  double systemHeight = 0;
  double systemWidth = 0;
  @override
  Widget build(BuildContext context) {
    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: systemWidth / 1.2,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
              child: Text(
            title!,
            style: textColour == "white" ? kButtonTextWhite : kButtonText,
          )),
        ),
      ),
    );
  }
}
