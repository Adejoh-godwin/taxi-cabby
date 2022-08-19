import 'package:flutter/material.dart';

import '../constants.dart';

class UserCard extends StatelessWidget {
  final String imageUrl;
  final String userName;

  const UserCard(this.imageUrl, this.userName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: primaryColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(imageUrl), fit: BoxFit.fill)),
            ),
            Text(
              userName,
              style: kOnboardTitle,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
