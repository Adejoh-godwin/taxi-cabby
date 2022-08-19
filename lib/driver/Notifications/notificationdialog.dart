
import 'package:cabby/driver/Models/ride_details.dart';
import 'package:cabby/rider/config/config.dart';

import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final RideDetails? rideDetails;

  const NotificationDialog({Key? key, this.rideDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10.0),
            Image.asset(
              "images/uberx.png",
              width: 150.0,
            ),
            const SizedBox(
              height: 0.0,
            ),
            const Text(
              "New Ride Request",
              style: TextStyle(
                fontFamily: "Brand Bold",
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/pickicon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          rideDetails!.pickup_address!,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/desticon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          child: Text(
                        rideDetails!.dropoff_address!,
                        style: const TextStyle(fontSize: 18.0),
                      )),
                    ],
                  ),
                  const SizedBox(height: 0.0),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            const Divider(
              height: 2.0,
              thickness: 4.0,
            ),
            const SizedBox(height: 0.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
              style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.red)),
                    primary: Colors.white,
                    
                    padding: const EdgeInsets.all(8.0),
              ),
                    onPressed: () {
                      // assetsAudioPlayer.stop();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                 ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.green)),
                     primary: Colors.green,
                    padding: const EdgeInsets.all(8.0),
              ),
                  
                    onPressed: () {
                      // assetsAudioPlayer.stop();
                      checkAvailabilityOfRide(context);
                    },
                   
                    child: Text("Accept".toUpperCase(),
                        style:  TextStyle(fontSize: 14,color: w)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0.0),
          ],
        ),
      ),
    );
  }

  void checkAvailabilityOfRide(BuildContext context) {}

}
