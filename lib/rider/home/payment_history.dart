import 'package:cabby/driver/widget/shared/components/payment_history_card.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';
import 'package:cabby/rider/Models2/allusers.dart';
import 'package:cabby/rider/Models2/moneymodel.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget {
  final RiderUserModel? userModel;
  final RiderUserModel? userModel2;

  const PaymentHistory({Key? key, this.userModel, this.userModel2})
      : super(key: key);
  @override
  PaymentHistoryState createState() => PaymentHistoryState();
}

class PaymentHistoryState extends State<PaymentHistory> {

  final List<String> typeOfRide = ["Debit Card", "Credit Card"];

  double systemHeight = 0;

  double systemWidth = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    systemHeight = Dimensions().getHeight(context);
    systemWidth = Dimensions().getWidth(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            color: const Color(0x0fffffff),
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
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Payment History',
                          style: kOnboardTitle,
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
                              children: const [
                                SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    // hintText: title,

                                    hintText: 'search',
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: systemWidth,
                        // color: Colors.orange,
                        // height: systemHeight,
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            FutureBuilder<List<MoneyModel>>(
                              future: ActivityApi.getPayHisory(
                                  widget.userModel!.id,
                                  context,
                                  widget.userModel2!.token),
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

                                    return PaymentHistoryCard(
                                        model.drivername,
                                        '${todayDate(DateTime.parse(model.created_at))}',
                                        model.amount,
                                        '${time(DateTime.parse(model.created_at))}',
                                        model.distance);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
