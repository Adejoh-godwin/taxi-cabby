// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:cabby/driver/Models/ridehistory.dart';
import 'package:cabby/driver/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/home/earning-tabs/today.dart';
import 'package:cabby/driver/widget/constant.dart' as constant;
import 'package:cabby/driver/widget/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThisWeek extends StatefulWidget {
  static String routeName = 'completeTab';

  const ThisWeek({Key? key}) : super(key: key);

  @override
  State<ThisWeek> createState() => _ThisWeekState();
}

class _ThisWeekState extends State<ThisWeek> {
  double? tm = 0.00;
  var tp = '00';
  var th = '00';
  var acctBal = '00';

  void total() async {
    var id = Config.sharedPreferences!.getString('id');

    final url = globalUrl + 'ride-total/' + id! + "/driverId/week";
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
      tm = body['tm'].toDouble();
      acctBal = body['acctBal'].toString();
    });
  }

  @override
  void initState() {
    total();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: 'NGN ',
                    style: Config.style(FontWeight.bold, textColor, 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: acctBal,
                        style: Config.style(FontWeight.bold, sColor!, 22),
                      ),
                    ]),
              ),
            )),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [Text(tp), const Text('trips')],
                  )),
                  const VerticalDivider(),
                  Expanded(
                      child: Column(
                    children: [Text(th), const Text('Time online')],
                  )),
                  const VerticalDivider(),
                  Expanded(
                      child: Column(
                    children: [Text('$tm'), const Text('Amount')],
                  )),
                ],
              ),
            ),
            
            const SizedBox(
              height: 10,
            ),
            const constant.ContainerWidget(
              color: Color(0xffF7F2F2),
              radius: 0,
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('TRIPS',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<RideModel>>(
                      future: ActivityApi.getToday(
                          Config.sharedPreferences!.getString('id'),
                          context,
                          'week'),
                      builder: (context, AsyncSnapshot snapshot) {
                        final result = snapshot.data;
                        if (snapshot.hasError) {
                         return const EmptyTab();
                        }

                        if (!snapshot.hasData) {
                          return Column(children: [
                            for (int i = 0; i < 5; i++) const Shimmer2(),
                          ]);
                        } else {
                          if (snapshot.data.length < 1) {
                            return const EmptyTab();
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final model = result[index];

                                return Summary(
                                  rideModel: model,
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    // for (int i = 0; i < 5; i++) Notification(),
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

/// Holds all example app films
// class Schedule extends StatefulWidget {
//   const Schedule({Key? key}) : super(key: key);

//   @override
//   _ScheduleState createState() => _ScheduleState();
// }

// class _ScheduleState extends State<Schedule> {
//   String? inspectionId = Config.sharedPreferences!.getString('userId');
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white30,
//         body: FutureBuilder<List<InstallationModel>>(
//           future: InstallationApi.getCompleted(inspectionId),
//           builder: (context, AsyncSnapshot snapshot) {
//             final result = snapshot.data;

//             if (snapshot.hasError) {
//              return const EmptyTab();
//             }

//             if (!snapshot.hasData) {
//               return OrderShimmer();
//             } else {
//               if (snapshot.data!.length < 1) {
//                 snapshot.data[0];
//                 return NoSchedule();
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final model = result[index];
//                     if (model.status == 'No Record') {
//                       return NoSchedule();
//                     } else {
//                       return Schedules(model);
//                     }
//                   },
//                 );
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class Schedules extends StatelessWidget {
//   Schedules(this.model);

//   final InstallationModel model;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => Navigator.push(context,
//           MaterialPageRoute(builder: (_) => InstallationSummary(model: model))),
//       child: Column(children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       model.ownerName.toString(),
//                       style: ConfigApp.style(
//                           FontWeight.w600, Color(0xff4D4D4D), 14.0),
//                     ),
//                     Text('${model.location}',
//                         style: ConfigApp.style(
//                             FontWeight.w200, Color(0xff4D4D4D), 11.0)),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   '${model.status}',
//                   style: GoogleFonts.openSans(
//                     textStyle: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 11,
//                       color: (model.status == 'Pending')
//                           ? Color(0XFFff6600)
//                           : Colors.green,
//                     ),
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(3),
//                   minimumSize: Size(60, 5),
//                   primary: Colors.white,
//                   shape: new RoundedRectangleBorder(
//                     side: BorderSide(
//                         color: (model.status == 'Pending')
//                             ? Color(0XFFff6600)
//                             : Colors.green),
//                     borderRadius: new BorderRadius.circular(30.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ]),
//     );
//   }
// }
