
// ignore_for_file: non_constant_identifier_names

class CardModelb {
  String user_id, card_number, expirity_date, cvv;

  CardModelb({
    required this.user_id,
    required this.card_number,
    required this.expirity_date,
    required this.cvv,
  });
}

class CardModel {
  String user_id, card_number, expirity_date, cvv;


   CardModel({
    required this.user_id,
    required this.card_number,
    required this.expirity_date,
    required this.cvv,
  });

  static CardModel fromJson(json) => CardModel(
        user_id: json['user_id'],
      card_number: json['card_number'],
      expirity_date: json['expirity_date'],
      cvv: json['cvv'],
      );
}
