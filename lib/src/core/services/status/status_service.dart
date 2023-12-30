import 'package:chat_app/src/core/models/status_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addStatus(String text, int colorCode) async {
    final User user = auth.currentUser!;
    final String uid = user.uid;
    final String? username = user.displayName;
    final DateTime postAt = DateTime.now();

    final String statusId =
        db.collection('users').doc(uid).collection('status').doc().id;

    final StatusModel newStatus = StatusModel(
      text: text,
      uid: uid,
      username: username,
      colorCode: colorCode,
      postAt: postAt,
      statusId: statusId,
    );

    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('status')
          .doc(statusId)
          .set(newStatus.toMap());

      await db.collection('users').doc(uid).update({'hasStatus': true});
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteStatus(
      String statusId, List<Map<String, dynamic>> statusData) async {
    final User user = auth.currentUser!;
    final String uid = user.uid;

    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('status')
          .doc(statusId)
          .delete();

      if (statusData.length == 1) {
        await db.collection('users').doc(uid).update({'hasStatus': false});
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStatus(String userUid) {
    return db
        .collection('users')
        .doc(userUid)
        .collection('status')
        .orderBy('postAt')
        .snapshots();
  }
}
