import 'package:flutter/material.dart';
import 'package:cabby/driver/widget/shared/constants.dart';
import 'package:cabby/driver/widget/shared/size_dimension.dart';

class StarRating extends StatefulWidget {
  const StarRating({Key? key}) : super(key: key);

  @override
  StarRatingState createState() => StarRatingState();
}

class StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        width: Dimensions().getWidth(context),
        height: 80,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.all(
             Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.star,
                  size: 35,
                  color: ratingColor,
                ),
                Icon(
                  Icons.star,
                  size: 35,
                  color: ratingColor,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                  color: ratingColor,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                  color: ratingColor,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                  color: ratingColor,
                ),
              ],
            ),
           
            const Text(
              '2.0',
              style: kOnboardTitle,
            ),
          ],
        ),
      ),
    );
  }
}
