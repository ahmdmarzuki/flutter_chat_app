import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderUid;
  final String senderEmail;
  final String receiverUid;
  final String message;
  final Timestamp timestamp;
  final String sendAt;

  MessageModel({
    required this.senderUid,
    required this.senderEmail,
    required this.receiverUid,
    required this.message,
    required this.timestamp,
    required this.sendAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'senderEmail': senderEmail,
      'receiverUid': receiverUid,
      'message': message,
      'timestamp': timestamp,
      'sendAt': sendAt,
    };
  }
}
