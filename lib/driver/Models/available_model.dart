// ignore_for_file: non_constant_identifier_names

class AvailableModel {
  final dynamic id;
  final dynamic riderId;
  final dynamic riderName;
  final dynamic riderPhone;
  final dynamic riderImage;

  final dynamic rating;
  final dynamic status;
  final dynamic longitude;
  final dynamic latitude;
  final dynamic class_of_ride;
  final dynamic ride_type;
  final dynamic dropOffLoc;
  final dynamic pickUpLoc;
  final dynamic distanctText;
  final dynamic distanceValue;
  final dynamic durationText;
  final dynamic durationValue;
  final dynamic dropOffLat;
  final dynamic dropOffLong;
  final dynamic pickUpLat;
  final dynamic pickUpLong;
  final dynamic amount;

  const AvailableModel({
    this.id,
    this.riderId,
    this.riderName,
    this.riderPhone,
    this.riderImage,
    this.rating,
    this.status,
    this.longitude,
    this.latitude,
    this.class_of_ride,
    this.ride_type,
    this.dropOffLoc,
    this.pickUpLoc,
    this.distanctText,
    this.distanceValue,
    this.durationText,
    this.durationValue,
    this.dropOffLat,
    this.dropOffLong,
    this.pickUpLat,
    this.pickUpLong,
    this.amount,
  });

  static AvailableModel fromJson(json) => AvailableModel(
        id: json['request_id'] as dynamic,
        riderId: json['userId'] as dynamic,
        riderName: json['name'] as dynamic,
        riderImage: json['image_path'] as dynamic,
        riderPhone: json['riderPhone'] as dynamic,
        rating: json['rating'] as dynamic,
        status: json['status'] as dynamic,
        longitude: json['longitude'] as dynamic,
        latitude: json['latitude'] as dynamic,
        class_of_ride: json['class_of_ride'] as dynamic,
        ride_type: json['ride_type'] as dynamic,
        dropOffLoc: json['dropoff_location'] as dynamic,
        pickUpLoc: json['pickup_location'] as dynamic,
        amount: json['amount'] as dynamic,
        durationValue: json['durationValue'] as dynamic,
        durationText: json['durationText'] as dynamic,
        distanctText: json['distanceText'] as dynamic,
        distanceValue: json['distanceValue'] as dynamic,
        dropOffLat: json['dropOffLat'] as dynamic,
        dropOffLong: json['dropOffLong'] as dynamic,
        pickUpLong: json['pickUpLong'] as dynamic,
        pickUpLat: json['pickUpLat'] as dynamic,
      );
}
