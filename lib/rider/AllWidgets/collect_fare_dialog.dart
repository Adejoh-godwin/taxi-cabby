import 'package:flutter/material.dart';

class CollectFareDialog extends StatelessWidget
{
  final String? paymentMethod;
  final int? fareAmount;

  const CollectFareDialog({Key? key, this.paymentMethod, this.fareAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.transparent,
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
            const SizedBox(height: 22.0,),

            const Text("Trip Fare", style: TextStyle(fontSize: 16.0, fontFamily: "Brand Bold"),),

            const SizedBox(height: 22.0,),

            const Divider(height: 2.0, thickness: 2.0,),

            const SizedBox(height: 16.0,),

            Text("\$$fareAmount", style: const TextStyle(fontSize: 55.0, fontFamily: "Brand Bold"),),

            const SizedBox(height: 16.0,),const SizedBox(height: 16.0,),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("This is the total trip amount, it has been charged to the rider.", textAlign: TextAlign.center,),
            ),

            const SizedBox(height: 30.0,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RaisedButton(
                onPressed: () async
                {
                  Navigator.pop(context, "close");
                },
                color: Colors.deepPurpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Pay Cash", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(Icons.attach_money, color: Colors.white, size: 26.0,),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}
