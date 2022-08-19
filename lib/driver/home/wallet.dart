
import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Wallet extends StatefulWidget {
  final UserModel? userModel;
  final UserModel? userModel2;

  const Wallet({Key? key, this.userModel, this.userModel2}) : super(key: key);
  @override
  WalletState createState() => WalletState();
}

class WalletState extends State<Wallet> {
  final accountNumber = TextEditingController();
  final accountNamr = TextEditingController();

  bool loading = false;
  bool? isEnabled = false;

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
        title: Text('Ride Summary',
            style: Config.style(FontWeight.w500, Colors.black, 20)),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 0.5),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              width: 100.w,
              height: 25.5.h,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: br(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 50,
                    offset: Offset(0, 2),
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff1e1d34), Color(0xff1e1d34)],
                ),
              ),
              child: Column(children: [
                Row(
                  children: [
                    const Text(
                      "₦",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffbcbc13),
                        fontSize: 25,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    esb('W', dp),
                    Column(
                      children: const [
                        Text(
                          "Balance",
                          style: TextStyle(
                            color: Color(0xff7b7896),
                            fontSize: 14,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "4,050",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                    esb('W', dp),
                    tlogo()
                  ],
                ),
                sb('h', 50),
                Row(
                  children: [
                    Column(
                      children: const [
                        Text(
                          "Wallet id",
                          style: TextStyle(
                            color: Color(0xff7b7896),
                            fontSize: 14,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "1222222",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                    esb('W', dp),
                    Container(
                      width: 116,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Center(
                        child: Text(
                          "Fund Wallet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
            sb('h', 3.h),
            Container(
              width: 360,
              height: 80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 45,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Colors.white,
              ),
              child: Center(
                child: ListTile(
                  leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: tlogo()),
                  title: const Text(
                    "Wallet Payment",
                    style: TextStyle(
                      color: Color(0xff1e1d34),
                      fontSize: 14,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Row(
                    children: const [
                      Text(
                        "03/24",
                        style: TextStyle(
                          color: Color(0xff434255),
                          fontSize: 14,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "127",
                        style: TextStyle(
                          color: Color(0xff434255),
                          fontSize: 14,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.check_circle_outline,
                    color: pColor,
                  ),
                ),
              ),
            ),
            sb('h', 3.h),
            InkWell(
              
              child: Container(
                width: 360,
                height: 75,
                padding: eAll(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfff3f3f3),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Text(
                        "Add Payment Method",
                        style: TextStyle(
                          color: Color(0xff434255),
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildTextFormField(text1, controller, hint, type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
        ),
        SizedBox(
          height: mediaHeight * 0.02,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,

                // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  //borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hint),
          ),
        ),
      ],
    );
  }

  BuildContext? buildContext;
  Future webCall() async {
    // Showing CircularProgressIndicator using State.
  }
}
