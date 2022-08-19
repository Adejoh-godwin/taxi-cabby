// ignore_for_file: use_build_context_synchronously

import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/rider/auth/SelectUserType.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/home/earming.dart';
import 'package:cabby/driver/home/notification.dart';
import 'package:cabby/driver/home/rating.dart';
import 'package:cabby/driver/home/profile.dart';
import 'package:cabby/driver/home/ride_summary.dart';
import 'package:cabby/rider/home/faq.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final UserModel? userModel;
  final UserModel? userModel2;

  const MyDrawer({Key? key, this.userModel, required this.userModel2}) : super(key: key);

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
                      userModel: userModel!,
                    ),
                    context),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: mediaHeight * .07,
                      backgroundImage: NetworkImage(
                        userModel!.image == 'null'
                            ? defaultImg!
                            : userModel!.image!,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile(
                                            userModel: userModel!,
                                          )));
                            },
                            child: Text(
                              userModel!.name!,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Drawer Body Contrllers
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()));
              },
              child: ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: Text(
                  "Notification",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  RideSummary(
                          userModel:userModel,
                          userModel2: userModel,
                        )));
              },
              child: ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  "Ride Summary",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Earning()));
              },
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet_outlined),
                title: Text(
                  "Earnings",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(userModel: userModel!)));
              },
              child: ListTile(
                leading: const Icon(Icons.account_box_outlined),
                title: Text(
                  "My Account",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Rating()));
              },
              child: ListTile(
                leading: const Icon(Icons.star_outline),
                title: Text(
                  "Rating",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AboutScreen()));
              },
              child: ListTile(
                leading: const Icon(Icons.payment_outlined),
                title: Text(
                  "Wallet",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Profile(userModel: userModel!,)));
              },
              child: ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(
                  "Settings",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Faq()));
              },
              child: ListTile(
                leading: const Icon(Icons.contact_support_outlined),
                title: Text(
                  "Help & FAQ",
                  style: Config.style(FontWeight.bold, textColor, 13),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                FirebaseAuth.instance.signOut();
                final pref = await SharedPreferences.getInstance();
                await pref.clear();
                // if (!mounted) {
                //   return;
                // }
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) =>  SelectUserType()),
                    (route) => false);
              },
              child: const ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text(
                  "Sign Out",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
