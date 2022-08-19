import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_dimension.dart';

class DriverInfoIcons extends StatelessWidget {
  final String? imageUrl;
  final String? driverName, designation;
  final double? rating;
  final GestureTapCallback? chatDriver;
  final GestureTapCallback? callDriver;

  const DriverInfoIcons(
      {Key? key, this.imageUrl,
      this.driverName,
      this.designation,
      this.rating,
      this.chatDriver,
      this.callDriver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions().getWidth(context),
      height: 82,
      decoration: const BoxDecoration(
        color: Color(0xFF7B7896),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(imageUrl!), fit: BoxFit.fill)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      designation!,
                      style: k12400White,
                    ),
                    Text(
                      driverName!,
                      style: k18600White,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          rating.toString(),
                          style: k16500White,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: callDriver,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: pinkColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone_callback_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: chatDriver,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.comment,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
