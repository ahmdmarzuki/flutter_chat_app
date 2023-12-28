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

    StatusModel newStatus =
        StatusModel(text: text, username: user.displayName, uid: user.uid);
    await db.collection('status').doc(user.uid).set(
          newStatus.toMap(),
        );
  }

  Stream<QuerySnapshot> getStatus() {
    return db.collection('status').snapshots();
  }
}
