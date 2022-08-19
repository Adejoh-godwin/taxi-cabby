// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var rate = 5;
  var raters = '0';

  void total() async {
    var id = Config.sharedPreferences!.getString('id');

    final url = globalUrl + 'rateTotal/' + id! + "/driverId";
    // print(url);

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final body = json.decode(response.body);
    // print(body);

    if (!mounted) return;
    setState(() {
      rate = body['rate'];
      raters = body['raters'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text('Rating',
              style: Config.style(FontWeight.w500, Colors.black, 20)),
          actions: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                    // changes position of shadow
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                    )),
              ),
            )
          ],
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(rate.toString(),
                                  style: Config.style(
                                      FontWeight.w700, textColor2!, 18)),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(children: [
                                (rate <= 1)
                                    ? star(pColor)
                                    : (rate <= 2)
                                        ? Row(children: [
                                            star(pColor),
                                            star(pColor)
                                          ])
                                        : (rate <= 3)
                                            ? Row(children: [
                                                star(
                                                  pColor,
                                                ),
                                                star(
                                                  pColor,
                                                ),
                                                star(
                                                  pColor,
                                                )
                                              ])
                                            : (rate <= 4)
                                                ? Row(children: [
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    )
                                                  ])
                                                : Row(children: [
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    ),
                                                    star(
                                                      pColor,
                                                    )
                                                  ]),
                              ]),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(children: [
                                Icon(
                                  Icons.person,
                                  color: textColor,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text('$raters Users',
                                    style: Config.style(
                                        FontWeight.w300, textColor, 14))
                              ]),
                            ],
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    )),
                Container(
                    color: const Color(0xffF7F2F2),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Recent Rating',
                                style: Config.style(
                                    FontWeight.bold, textColor2!, 16)),
                          ),
                        ],
                      ),
                    )),
                ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: textColor2,
                        radius: 18,
                        backgroundImage: NetworkImage(
                            "${Config.sharedPreferences!.getString('image')}"),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            "Very Punctual",
                            style:
                                Config.style(FontWeight.bold, textColor2!, 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(children: [
                            Icon(
                              Icons.star,
                              color: pColor,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: pColor,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: pColor,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: pColor,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: pColor,
                              size: 15,
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
