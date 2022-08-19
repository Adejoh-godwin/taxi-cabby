import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';


class RideViewDetailsTwo extends StatelessWidget {
  final String image, plateNumber;
  final int amount;
  final String distance, time;

  const RideViewDetailsTwo(
    this.image,
    this.distance,
    this.time,
    this.plateNumber,
    this.amount, {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Distance',
                  style: k11400Faint,
                ),
                Text(
                  distance.toString(),
                  style: Config.style(FontWeight.bold, Colors.black, 11),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Time',
                  style: k11400Faint,
                ),
                Text(
                  time.toString(),
                  style: Config.style(FontWeight.bold, Colors.black, 11),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Plate No:',
                  style: k11400Faint,
                ),
                Text(
                  plateNumber,
                  style: Config.style(FontWeight.bold, Colors.black, 11),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Price',
                  style: k11400Faint,
                ),
                Text(
                  'NGN: $amount',
                  style: Config.style(FontWeight.bold, Colors.black, 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
