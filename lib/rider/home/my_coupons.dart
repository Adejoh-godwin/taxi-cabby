// ignore_for_file: avoid_print

import 'package:cabby/driver/widget/shared/components/coupon_card.dart';
import 'package:cabby/driver/widget/shared/components/header_title.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:cabby/rider/Models2/coupon_model.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:flutter/material.dart';
class MyCoupons extends StatefulWidget {
  final String? userId, token;

  const MyCoupons({Key? key, this.userId, this.token}) : super(key: key);
  @override
  @override
  MyCouponsState createState() => MyCouponsState();
}

class MyCouponsState extends State<MyCoupons> {
  double systemHeight = 0;

  double systemWidth = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // systemHeight = MediaQuery.of(context).size.height;
    systemWidth = Dimensions().getWidth(context);
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backButton(context),
                      topIconRight(
                      
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 18,
                  // ),
                  const HeaderTitle(
                    mainTitle: 'My Coupons',
                    subTitle: '',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add new Coupon',
                            style: k12400Normal,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: systemWidth / 1.3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            // hintText: title,
                                            fillColor: textFieldColour,
                                            filled: true,
                                            hintText: 'Add new Coupon',

                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 3,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // width: systemWidth / 1.2,
                                        decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:  BorderRadius.all(
                                            Radius.circular(05),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Center(
                                              child:  Text(
                                            'Save',
                                            style: kButtonText,
                                          )),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: systemWidth,
                  // color: Colors.orange,
                  // height: systemHeight,

                  child: FutureBuilder<List<CouponModel>>(
                    future: ActivityApi.getCoupon(),
                    builder: (context, AsyncSnapshot snapshot) {
                      final result = snapshot.data;
                      if (snapshot.hasError) {
                       return const EmptyTab();
                      }

                      if (!snapshot.hasData) {
                        return Column(children: [
                          for (int i = 0; i < 5; i++) const Shimmer2(),
                        ]);
                      }
                      if (snapshot.data.length < 1) {
                        return const EmptyTab();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final model = result[index];

                          return CouponCard(
                            'Flat ${model.discount}% off on all rides ',
                            'Use code to get ${model.discount}%  discount on all Economy rides till ${model.expirity}',
                            () {
                              print('tapped');
                            },
                            '#${snapshot.data[index].code}',
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    ));
  }
}
