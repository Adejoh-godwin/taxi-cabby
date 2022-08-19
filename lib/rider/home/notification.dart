import 'package:cabby/driver/Models/all_users.dart';
import 'package:cabby/rider/Models2/notification.dart';
import 'package:cabby/rider/api/activity_api.dart';
import 'package:cabby/rider/config/config.dart';
import 'package:cabby/rider/widget/shimmer.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  final UserModel userModel;
  final UserModel userModel2;

  const Notifications(
      {Key? key, required this.userModel, required this.userModel2})
      : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
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
        title: Text('Notifications',
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
      body: Container(
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
          children: [
            Expanded(
              child: FutureBuilder<List<NotificationModel>>(
                future: ActivityApi.getNotification(
                    Config.sharedPreferences!.getString('id'),
                    widget.userModel2.token),
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final model = result[index];

                          return Notification(
                            model: model,
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
            // for (int i = 0; i < 5; i++) Notification(),
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

class Notification extends StatelessWidget {
  final NotificationModel? model;
  const Notification({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        //  elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: pColor,
                child: Icon(
                  (model!.status == 'Cancelled')
                      ? Icons.cancel
                      : (model!.status == 'Good')
                          ? Icons.check_circle
                          : (model!.status == 'Promotion')
                              ? Icons.announcement_rounded
                              : Icons.history,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${model!.source}',
                          style: Config.style(FontWeight.bold, textColor, 14)),
                      const SizedBox(
                        height: 3,
                      ),
                      Text('${model!.message}',
                          style: Config.style(FontWeight.w400, sColor!, 12)),
                      const SizedBox(
                        height: 3,
                      ),
                      Text('${model!.createdAt}',
                          style: Config.style(FontWeight.w400, sColor!, 12))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
