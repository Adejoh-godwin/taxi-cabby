import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/driver/home/edit_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final UserModel userModel;

  const Profile({Key? key, required this.userModel}) : super(key: key);
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/svg/group_102.png')),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                        userModel.image == 'null'
                            ? defaultImg!
                            : userModel.image!,
                      ),
                        minRadius: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${userModel.name}",
                    style: Config.style(FontWeight.w500, Colors.white, 18),
                  ),
                  SizedBox(
                    width: mediaWidth * 0.43,
                    child: TextButton(
                        //TODO: calculate rating
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(3),
                          minimumSize: const Size(80, 40),
                          primary: pColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (userModel.rating! <= 1)
                                    ? star()
                                    : (userModel.rating! <= 2)
                                        ? Row(children: [star(), star()])
                                        : (userModel.rating! <= 3)
                                            ? Row(children: [
                                                star(),
                                                star(),
                                                star()
                                              ])
                                            : (userModel.rating! <= 4)
                                                ? Row(children: [
                                                    star(),
                                                    star(),
                                                    star(),
                                                    star()
                                                  ])
                                                : Row(children: [
                                                    star(),
                                                    star(),
                                                    star(),
                                                    star(),
                                                    star()
                                                  ]),
                                Text(
                                  " ${userModel.rating}",
                                )
                              ]),
                        )),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            //TODO: hours online
            child: Text('Hours Online',
                style:
                    Config.style(FontWeight.w500, const Color(0xff1E1D34), 14)),
          ),
          const SizedBox(
            height: 18,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                Expanded(
                    child: Column(
                  children: [
                    Text('${userModel.acceptance}%',
                        style: Config.style(FontWeight.bold, textColor2!, 18)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Acceptance',
                        style: Config.style(FontWeight.w500, textColor, 14))
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Text('${userModel.cancel}%',
                        style: Config.style(FontWeight.bold, textColor2!, 18)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Decline',
                        style: Config.style(FontWeight.w500, textColor, 14))
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Text('${userModel.cancel},%',
                        style: Config.style(FontWeight.w500, textColor2!, 18)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Cancellation',
                        style: Config.style(FontWeight.w500, textColor, 14))
                  ],
                )),
              ]),
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
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: RichText(
                      text: TextSpan(
                          text: ' Trips ',
                          style: Config.style(FontWeight.bold, textColor2!, 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'over',
                                style: Config.style(
                                    FontWeight.bold, textColor, 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                  }),
                            TextSpan(
                              text: ' 6 Months ',
                              style:
                                  Config.style(FontWeight.bold, textColor, 14),
                            ),
                          ]),
                    ))),
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
                        "${userModel.phone}",
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
                        "${userModel.email}",
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
                        "${userModel.address}",
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
