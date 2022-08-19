// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/home/earning-tabs/all.dart';
import 'package:cabby/driver/home/earning-tabs/thisweek.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'earning-tabs/today.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Earning extends StatefulWidget {
  static String routeName = 'calendarScreen';

  const Earning({Key? key}) : super(key: key);

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
  double? tm = 0.00;
  var tp = '00';
  var th = '00';
  var acctBal = '00';

  void total() async {
    var id = Config.sharedPreferences!.getString('id');

    final url = globalUrl + 'rideTotal/' + id! + "/driverId/today";
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final body = json.decode(response.body);
    print(body);

    if (!mounted) return;
    setState(() {
      tp = body['tp'].toString();
      th = body['th'].toString();
      tm = body['tm'];
      acctBal = body['acctBal'].toString();
    });
  }

  @override
  void initState() {
    total();
    super.initState();
  }

  var pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.white,
            title: Text(
              'Earning',
              style: Config.style(FontWeight.w700, sColor!, 20),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: pColor,
                    fixedSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: Text("Login",
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                    )))),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    elevation: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  pageIndex = 1;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  primary:
                                      (pageIndex == 1) ? pColor : Colors.white,
                                  fixedSize: const Size(400, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Text("Today",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: (pageIndex == 1)
                                        ? Colors.black
                                        : textColor,
                                    fontSize: 12.0,
                                  )))),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  pageIndex = 2;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  primary:
                                      (pageIndex == 2) ? pColor : Colors.white,
                                  fixedSize: const Size(400, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              child: Text("This Week",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: (pageIndex == 2)
                                        ? Colors.black
                                        : textColor,
                                    fontSize: 13.0,
                                  )))),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  pageIndex = 3;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  primary:
                                      (pageIndex == 3) ? pColor : Colors.white,
                                  fixedSize: const Size(400, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              child: Text("All",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: (pageIndex == 3)
                                        ? Colors.black
                                        : textColor,
                                    fontSize: 12.0,
                                  )))),
                        ),
                      ],
                    ),
                  ),
                ),
                (pageIndex == 1)
                    ? const Today()
                    : (pageIndex == 2)
                        ? const ThisWeek()
                        : const All()
              ],
            ),
          )),
    );
  }
}
