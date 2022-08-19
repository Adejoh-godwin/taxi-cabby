
class CarModel {
  String? id, plateNumber, model, userId, colour, image;
  String? productType;
  int? acctBal;

  CarModel(
      {this.id,
      this.userId,
      this.plateNumber,
      this.model,
      this.productType,
      this.colour,
     });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      // password: json['password'],
      plateNumber: json['plateNumber'].toString(),
      model: json['model'].toString(),
      productType: json['productType'].toString(),
      colour: json['colour'].toString(),
     
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
     
      'plateNumber': plateNumber,
      'model': model,
      'productType': productType,
      'colour': colour,
      
    };
  }
}
