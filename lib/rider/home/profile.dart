import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/home/edit_profile.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final RiderUserModel? userModel;

  const Profile({Key? key, this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
          title: Text(
            "My Profile",
            style: Config.style(FontWeight.w500, textColor, 18),
          ),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      radius: mediaHeight * .05,
                      backgroundImage: NetworkImage(
                        userModel!.image == 'null'
                            ? defaultImg!
                            : userModel!.image!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${userModel!.name}",
                  style: Config.style(FontWeight.w500, Colors.white, 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                ),
                Container(
                    color: const Color(0xffF7F2F2),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Personal Info',
                                style: Config.style(
                                    FontWeight.bold, textColor2!, 16)),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                color: textColor,
                              ),
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            EditProfile(userModel: userModel)),
                                  ))
                        ],
                      ),
                    )),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: pColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${userModel!.phone}",
                        style: Config.style(FontWeight.bold, textColor2!, 14),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: pColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${userModel!.email}",
                        style: Config.style(FontWeight.bold, textColor2!, 14),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: pColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${userModel!.address}",
                        style: Config.style(FontWeight.bold, textColor2!, 14),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          )
        ]));
  }

  Icon star() {
    return const Icon(
      Icons.star,
      color: Colors.white,
      size: 20,
    );
  }
}
