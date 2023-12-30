import 'package:chat_app/src/screen/home/status_view.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusAvatar extends StatelessWidget {
  final String uid;
  final String username;
  final String text;
  final int initialIndex;
  final List<Map<String, dynamic>> statusList;
  final List<DocumentSnapshot<Map<String, dynamic>>> userDocs;

  final DocumentSnapshot<Map<String, dynamic>> userDoc;
  const StatusAvatar(
      {super.key,
      required this.username,
      required this.uid,
      required this.text,
      required this.userDoc,
      required this.initialIndex,
      required this.statusList,
      required this.userDocs});

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    // final statusData = snapshot as Map<String, dynamic>;
    // final List<Map<String, dynamic>> statusData =
    //     snapshot as List<Map<String, dynamic>>;

    if (uid == user.uid) {
      return const SizedBox();
    } else {
      return Container(
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contetx) => StatusView(
                              userDoc: userDoc,
                              initialIndex: initialIndex,
                              statusList: statusList,
                              userDocs: userDocs,
                            )));
              },
              child: CircleAvatar(
                radius: 29,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: accentBlack,
                  child: CircleAvatar(
                    radius: 25,
                    child: Image.asset('assets/image_profile.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            CostumText(text: username, color: white)
          ],
        ),
      );
    }
  }
}
