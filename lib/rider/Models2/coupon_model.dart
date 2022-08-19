class CouponModel {
  final dynamic id;
  final dynamic code;
  final dynamic expirity;
  final dynamic discount;

  const CouponModel({
    this.id,
    this.code,
    this.expirity,
    this.discount,
  });

  static CouponModel fromJson(json) => CouponModel(
        id: json['id'] as dynamic,
        code: json['code'] as dynamic,
        expirity: json['expirity'] as dynamic,
        discount: json['discount'] as dynamic,
      );
}
