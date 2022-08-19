import 'package:cloud_firestore/cloud_firestore.dart';


class History
{
  String? paymentMethod;
  String? createdAt;
  String? status;
  String? fares;
  String? dropOff;
  String? pickup;

  History({this.paymentMethod, this.createdAt, this.status, this.fares, this.dropOff, this.pickup});

  History.fromSnapshot(DocumentSnapshot snapshot)
  {
    paymentMethod = snapshot["payment_method"];
    createdAt = snapshot["created_at"];
    status = snapshot["status"];
    fares = snapshot["fares"];
    dropOff = snapshot["dropoff_address"];
    pickup = snapshot["pickup_address"];
  }
}