class NotificationModel {
  final dynamic id;
  final dynamic status;
  final dynamic message;
  final dynamic readstatus;
  final dynamic source;

  final dynamic createdAt;

  const NotificationModel({
    this.id,
    this.status,
    this.message,
    this.readstatus,
    this.source,
    this.createdAt,
  });

  static NotificationModel fromJson(json) => NotificationModel(
        id: json['id'] as dynamic,
        status: json['status'] as dynamic,
        message: json['message'] as dynamic,
        source: json['source'] as dynamic,
        readstatus: json['read_status'] as dynamic,
        createdAt: json['created_at'] as dynamic,
      );
}
