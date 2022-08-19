class MessageModel {
  final String? message;
  final String? senderId;
  final String? receiverId;
  final String? rideId;
  final String? createdAt;

  MessageModel({
    this.message,
    this.senderId,
    this.receiverId,
    this.rideId,
    this.createdAt,
  });

  static MessageModel fromJson(json) => MessageModel(
        rideId: json['rideId'].toString(),
        senderId: json['senderId'].toString(),
        receiverId: json['receiverId'],
        message: json['message'].toString(),
        createdAt: json['created_at'].toString(),
      );
}
