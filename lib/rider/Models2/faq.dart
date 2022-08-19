class FaqModel {
  final dynamic id;
  final dynamic question;
  final dynamic answer;


  const FaqModel({
    this.id,
    this.question,
    this.answer,

  });

  static FaqModel fromJson(json) => FaqModel(
        id: json['id'] as dynamic,
        question: json['questions'] as dynamic,
        answer: json['answer'] as dynamic,

      );
}
