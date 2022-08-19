import 'package:cabby/rider/config/config.dart';
// import 'package:cabby/rider/home/ride_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgressDialog extends StatelessWidget {
  final String? message;
  const ProgressDialog({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6.0,
              ),
              const CircularProgressIndicator(
                valueColor:  AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              const SizedBox(
                width: 26.0,
              ),
              Text(
                '$message',
                style: const TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopUp extends StatefulWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final Route route;
  const PopUp(
      {Key? key, this.text1, this.text2, this.text3, required this.route})
      : super(key: key);

  @override
  PopUpState createState() => PopUpState();
}

class PopUpState extends State<PopUp> {
  bool loading = false;

  TextEditingController otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: mediaHeight* 0.24),
        Center(
          child: Stack(
            children: [
              Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            // margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(32.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(widget.text1!,
                                    style: Config.style(FontWeight.w600,
                                        const Color(0xff888888), 15)),
                                SizedBox(
                                  height: mediaHeight* 0.04,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(3),
                                          minimumSize: const Size(80, 40),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ),
                                        ),
                                        child: Text(
                                          widget.text2!,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.lightGreen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context, widget.route);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(3),
                                          minimumSize: const Size(80, 40),
                                          primary: Colors.white,
                                          side: const BorderSide(
                                            width: 2.0,
                                            color: Colors.lightGreenAccent,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ),
                                        ),
                                        child: (loading)
                                            ? const SpinKitPulse(
                                                color: Colors.amber,
                                                size: 30.0,
                                              )
                                            : Center(
                                                child: Text(
                                                  widget.text3!,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors
                                                          .lightGreenAccent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: mediaHeight* 0.14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: pColor,
                    child: const Expanded(
                        child: Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WalletPop extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  const WalletPop({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(
                // margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0),
                          border: Border.all(color: textColor)),
                      child: RichText(
                        text: TextSpan(
                            text: 'NGN ',
                            style: Config.style(FontWeight.bold, sColor!, 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$text1',
                                style:
                                    Config.style(FontWeight.bold, pColor, 14),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(text2!,
                        style: Config.style(
                            FontWeight.w600, const Color(0xff888888), 15)),
                    SizedBox(
                      height: mediaHeight* 0.04,
                    ),
                    Text(text3!,
                        style: Config.style(
                            FontWeight.w600, const Color(0xff888888), 13)),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => RideSummary()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(3),
                        minimumSize: const Size(80, 40),
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: pColor,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'View Summary',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: pColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CanCelRide extends StatelessWidget {
  final int? text1;
  final String? text2;
  final String? text3;
  const CanCelRide({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xff1E1D34).withOpacity(0.7),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Ajose Adeogun Street Utako',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '3km',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              'Shoprite, Jabi  Mall Lake Jabi',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Cancel Ride with Chindinma'))),
                        TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => RideSummary()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel Ride',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => RideSummary()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: pColor),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: sColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StartRide extends StatelessWidget {
  final int? text1;
  final String? text2;
  final String? text3;
  const StartRide({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: sColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: pColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Ajose Adeogun Street Utako',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '3km',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '10 Mins',
                                      style: Config.style(
                                          FontWeight.w400, Colors.white, 14),
                                    ),
                                    const Expanded(
                                        child: SizedBox(
                                      width: 5,
                                    )),
                                    Expanded(
                                      child: Text(
                                        '09:55 Waiting',
                                        style: Config.style(
                                            FontWeight.w400, Colors.white, 14),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: pColor,
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 5,
                          )),
                          Expanded(
                            child: Text(
                              'Shoprite, Jabi  Mall Lake Jabi',
                              style: Config.style(
                                  FontWeight.w400, Colors.white, 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Container(
                    // margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Head to destination'))),
                        SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: pColor,
                                    child: const Icon(Icons.chat),
                                  ),
                                  const Text('Chat')
                                ],
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/svg/intro1.png'),
                              ),
                              const Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: pColor,
                                    child: const Icon(Icons.chat),
                                  ),
                                  const Text('Canel Trip')
                                ],
                              ),
                            ],
                          ),
                        )),
                        TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => RideSummary()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(80, 40),
                            primary: pColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Start Ride',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Call extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? driverPhone;
  const Call({
    Key? key,
    this.text1,
    this.text2,
    this.driverPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          const Expanded(
              child: SizedBox(
            height: 10,
          )),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Text('Make A call'),
                                  Expanded(
                                      child: SizedBox(
                                    width: 15,
                                  )),
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                  )
                                ],
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                            _launchCaller(driverPhone);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(3),
                          minimumSize: const Size(80, 40),
                          primary: Colors.grey,
                        ),
                        child: Row(
                          children: [
                            Text('Call',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )),
                            const Expanded(
                                child: SizedBox(
                              width: 5,
                            )),
                            Expanded(
                              child: Text(
                                '$driverPhone',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'You can call your driver to get response on his whereabout.'),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    void _launchCaller(number) async{
    var url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
