import 'package:cabby/driver/widget/shared/widgets/socialMediaLogin.dart';
import 'package:flutter/material.dart';
import 'package:cabby/driver/widget/shared/components/header_title.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/faq.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';

class Faq extends StatefulWidget {
  final String? userId, token;
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const Faq(
      {Key? key, this.userId, this.token, this.userModel, this.userModel2})
      : super(key: key);

  @override
  FaqState createState() => FaqState();
}

class FaqState extends State<Faq> {
  bool loading = false;
  bool valuefirst = false;
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: fa,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                leading: backButton(context),
                backgroundColor: const Color(0XFFf5f5f5),
                title: const Text(
                  "Faq",
                  style: TextStyle(
                    color: Color(0xff08102e),
                    fontSize: 19.80,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeaderTitle(
                            mainTitle: 'FAQ',
                            subTitle:
                                'Find answers by entering your questions below',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: mediaWidth / 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: systemWidth,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 17,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        // hintText: title,
                                        fillColor: whiteColor,
                                        filled: true,
                                        hintText: 'search',

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<FaqModel>>(
                    future: ActivityApi.getFaq(),
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

                          return Container(
                            color: const Color(0xFFFFF4F4),
                            child: ExpansionTile(
                              backgroundColor: const Color(0xFFFFF4F4),
                              collapsedBackgroundColor: const Color(0xFFFFF4F4),
                              leading: const Icon(
                                Icons.question_answer,
                                color: primaryColor,
                              ),
                              title: Text(
                                model.question,
                                style: k14400NormalBold,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      18.0, 5.0, 18.0, 18.0),
                                  child: Text(
                                    model.answer,
                                    style: k12400Normal,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
