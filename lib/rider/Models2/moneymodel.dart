// ignore_for_file: non_constant_identifier_names

class MoneyModel {
  final dynamic id;
  final dynamic driverId;
  final dynamic riderId;
  final dynamic riderName;
  final dynamic drivername;
  final dynamic requestId;
  final dynamic created_at;
  final dynamic distance;
  final dynamic amount;
  final dynamic updated_at;

  const MoneyModel({
    this.id,
    this.driverId,
    this.riderId,
    this.distance,
    this.drivername,
    this.requestId,
    this.created_at,
    this.updated_at,
    this.riderName,
    this.amount,
  });

  static MoneyModel fromJson(json) => MoneyModel(
        id: json['id'] as dynamic,
        driverId: json['driverId'] as dynamic,
        riderId: json['riderId'] as dynamic,
        drivername: json['driver_name'] as dynamic,
        requestId: json['ride_request'] as dynamic,
        distance: json['distance'] as dynamic,
        created_at: json['created_at'] as dynamic,
        amount: json['amount'] as dynamic,
        updated_at: json['updated_at'] as dynamic,
        riderName: json['rider_name'] as dynamic,
      );
}
