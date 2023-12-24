import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderUid;
  final String senderEmail;
  final String receiverUid;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.senderUid,
      required this.senderEmail,
      required this.receiverUid,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'senderEmail': senderEmail,
      'receiverUid': receiverUid,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
