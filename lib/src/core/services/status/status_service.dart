import 'package:chat_app/src/core/models/status_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addStatus(String text) async {
    final User user = auth.currentUser!;
    final String? username = user.displayName;
    final String uid = user.uid;

    try {
      await db.collection('users').doc(uid).collection('status').add({
        'text': text,
        'username': username,
        'uid': uid,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<QuerySnapshot> getStatus() {
    return db.collection('status').doc().collection('status').snapshots();
  }
}
