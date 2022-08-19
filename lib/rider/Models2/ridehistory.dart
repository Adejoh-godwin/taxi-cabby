class RideModel {
  final dynamic id;
  final dynamic driverId;
  final dynamic riderId;
  final dynamic pickupTime;
  final dynamic pickupLocation;
  final dynamic dropOfflocation;
  final dynamic dropoffTime;
  final dynamic riderName;
  final dynamic amount;
  final dynamic paymentMethod;

  const RideModel({
    this.id,
    this.driverId,
    this.riderId,
    this.pickupTime,
    this.pickupLocation,
    this.dropOfflocation,
    this.dropoffTime,
    this.paymentMethod,
    this.riderName,
    this.amount,
  });

  static RideModel fromJson(json) => RideModel(
        id: json['id'] as dynamic,
        driverId: json['driverId'] as dynamic,
        riderId: json['riderId'] as dynamic,
        pickupLocation: json['pickup_location'] as dynamic,
        dropOfflocation: json['dropoff_location'] as dynamic,
        pickupTime: json['pickup_time'] as dynamic,
        dropoffTime: json['dropoff_time'] as dynamic,
        amount: json['amount'] as dynamic,
        paymentMethod: json['payment_method'] as dynamic,
        riderName: json['riderName'] as dynamic,
      );
}
