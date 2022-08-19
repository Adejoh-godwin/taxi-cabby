
class RiderUserModel {
  String? id, name, phone, email, token, image, address;
  int? acceptance, cancel, rating, trips;
  String? type;
  dynamic acctBal, isOnline;

  RiderUserModel(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.type,
      this.token,
      this.rating,
      this.acctBal,
      this.acceptance,
      this.cancel,
      this.isOnline,
      this.trips,
      this.image});

  factory RiderUserModel.fromJson(Map<String, dynamic> json) {
    return RiderUserModel(
      id: json['id'].toString(),
      email: json['email'].toString(),
      isOnline: json['is_online'],
      // password: json['password'],
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      type: json['type'].toString(),
      rating: json['rating'],
      acceptance: json['acceptance'],
      token: json['access_token'].toString(),
      cancel: json['cancel'],
      trips: json['trips'],
      acctBal: json['wallet'],

      image: json['image_path'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      // 'password': password,
      'name': name,
      'phone': phone,
      'type': type,
      'token': token,
      'acctBal': acctBal,
    };
  }
}
