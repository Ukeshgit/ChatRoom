class ChatModel {
  final String? fromId;
  final String? msg;
  final String? read;
  final String? sent;
  final String? toId;
  final Type? type;

  ChatModel({
    this.fromId,
    this.msg,
    this.read,
    this.sent,
    this.toId,
    this.type,
  });

  // Factory constructor to create an instance from JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      fromId: json['fromId'] as String?,
      msg: json['msg'] as String?,
      read: json['read'] as String?,
      sent: json['sent'] as String?,
      toId: json['toId'] as String?,
      type: json['type'].toString() == Type.image.name ? Type.image : Type.text,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'msg': msg,
      'read': read,
      'sent': sent,
      'toId': toId,
      'type': type,
    };
  }
}

enum Type { text, image }
