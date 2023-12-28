import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<UserCredential> signUp(
      String email, String password, String username) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final uid = credential.user!.uid;

      db.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'username': username,
      });

      await auth.currentUser!.updateDisplayName(username);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateDisplayName(String username) async {
    try {
      await auth.currentUser!.updateDisplayName(username);

      db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'username': username});
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> profileImagePicker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return;
    }
  }
}
