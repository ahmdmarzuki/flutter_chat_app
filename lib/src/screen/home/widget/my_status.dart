import 'package:chat_app/src/core/services/status/status_service.dart';
import 'package:chat_app/src/screen/home/add_status_screen.dart';
import 'package:chat_app/src/screen/home/my_status_view.dart';
import 'package:chat_app/src/screen/home/status_view.dart';
import 'package:chat_app/src/screen/home/widget/status_avatar.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyStatus extends StatelessWidget {
  const MyStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;

    final StatusService statusService = StatusService();

    return Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('status')
                .snapshots(),
            builder: ((context, snapshot) {
              final List<Map<String, dynamic>> statusData =
                  snapshot.data!.docs.map((doc) => doc.data()).toList();

// ------jika current user punya status--------------------------
              if (statusData.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyStatusView(text: statusData[0]['text']),
                      ),
                    );
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
                );
              }

// ------jika current user tidak punya status--------------------------
              else {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddStatusScreen()));
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 27,
                        child: Image.asset('assets/image_profile.png'),
                      ),
                      Positioned(
                          bottom: -5,
                          right: -5,
                          child: Image.asset(
                            'assets/button_add.png',
                            width: 28,
                          )),
                    ],
                  ),
                );
              }
            })),
        const SizedBox(height: 8),
        CostumText(text: "My Status", color: white)
      ],
    );
  }
}
