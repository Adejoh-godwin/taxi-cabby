import 'package:cabby/driver/auth/signup.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/auth/SelectUserType.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/faq.dart';
import 'package:cabby/rider/home/invite_friends.dart';
import 'package:cabby/rider/home/payment_history.dart';
import 'package:cabby/rider/home/my_coupons.dart';
import 'package:cabby/rider/home/profile.dart';
import 'package:cabby/rider/home/rider_home.dart';
import 'package:cabby/rider/home/ride_summary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const MyDrawer({Key? key, this.userModel, this.userModel2}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentSelectedValueThree = "Intra-city";
  final List<String> typeOfRide = [
    "Intra-city",
    "Inter-city",
  ];

  List<String> dropDown = <String>[
    "Intra-city",
    "Inter-state",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 210.0,
      child: Drawer(
        child: ListView(
          children: [
            //Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(color: pColor),
              child: InkWell(
                onTap: () => goTo(
                    Profile(
                      userModel: widget.userModel,
                    ),
                    context),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: mediaHeight * .05,
                      backgroundImage: NetworkImage(
                        widget.userModel!.image == 'null'
                            ? defaultImg!
                            : widget.userModel!.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 6.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              goTo(
                                  Profile(
                                    userModel: widget.userModel,
                                  ),
                                  context);
                            },
                            child: Text(widget.userModel!.name.toString())),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Drawer Body Contrllers
            GestureDetector(
              onTap: () {
                goTo(
                    RiderHome(
                      userModel2: widget.userModel2,
                      userModel: widget.userModel,
                    ),
                    context);
              },
              child: ListTile(
                leading: const Icon(Icons.home_filled),
                title: Text(
                  "Home",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Not available", context);
              },
              child: ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  "Logistics",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: DropdownButton<String>(
                  underline: Container(),
                  hint: Text('Sort By',
                      style: Config.style(FontWeight.w400, textColor, 14)),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: dropDown.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      currentSelectedValueThree = value.toString();
                    });
                  }),
            ),
            GestureDetector(
              onTap: () {
                goTo(
                    RideSummary(
                      userModel: widget.userModel,
                      userModel2: widget.userModel2,
                    ),
                    context);
              },
              child: ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  "History",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     goTo(
            //         Wallet(
            //           userModel: widget.userModel,
            //           userModel2: widget.userModel2,
            //         ),
            //         context);
            //   },
            //   child: ListTile(
            //     leading: const Icon(Icons.account_balance_wallet_outlined),
            //     title: Text(
            //       "Wallet",
            //       style: Config.style(FontWeight.bold, textColor, 13),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                goTo(
                    PaymentHistory(
                      userModel: widget.userModel,
                      userModel2: widget.userModel2,
                    ),
                    context);
              },
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: Text(
                  "Payment History",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                goTo(const InviteFriends(), context);
              },
              child: ListTile(
                leading: const Icon(Icons.account_box_outlined),
                title: Text(
                  "Invite Friends",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                goTo(const MyCoupons(), context);
              },
              child: ListTile(
                leading: const Icon(Icons.star_outline),
                title: Text(
                  "Promo Code",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                goTo(
                    Faq(
                      userModel: widget.userModel,
                      userModel2: widget.userModel2,
                    ),
                    context);
              },
              child: ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(
                  "Help and FAQ",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                goTo(
                    Profile(
                      userModel: widget.userModel,
                    ),
                    context);
              },
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: Text(
                  "Setting",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                FirebaseAuth.instance.signOut();
                final pref = await SharedPreferences.getInstance();
                await pref.clear();
                if (!mounted) {
                  return;
                }
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) =>  SelectUserType()),
                    (route) => false);
              },
              child: const ListTile(
                leading:  Icon(Icons.logout_outlined),
                title: Text(
                  "Sign Out",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),

            InkWell(
              onTap: () => goTo(const DriverSignup(), context),
              child: userTypeButtonSecond(
                  "Become a Driver", primaryColor, "dark", context),
            ),
          ],
        ),
      ),
    );
  }
}
