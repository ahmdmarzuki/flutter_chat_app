import 'package:chat_app/src/core/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverUid, String message) async {
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail =
        FirebaseAuth.instance.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // memuat data 'waktu' untuk ditampilkan di contact card
    final DateTime sendAt = DateTime.now();
    String formattedSendAt = DateFormat('KK:mm aa').format(sendAt);

    MessageModel newMessage = MessageModel(
        senderUid: currentUserUid,
        senderEmail: currentUserEmail,
        receiverUid: receiverUid,
        message: message,
        timestamp: timestamp,
        sendAt: formattedSendAt);

    List<String> ids = [currentUserUid, receiverUid];
    ids.sort();

    // menggabungkan dua id user jadi room id
    String chatRoomId = ids.join("-");

    await db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    await db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('last_message')
        .doc(db.collection('chat_rooms').doc(chatRoomId).id)
        .set({
      'last_message': message,
      'sendAt': formattedSendAt,
      'senderUid':currentUserUid,
      'read': false
    });
  }

  Stream<QuerySnapshot> getMessage(String userUid, String otherUserUid) {
    List<String> ids = [userUid, otherUserUid];
    ids.sort();
    String chatRoomId = ids.join("-");

    return db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
