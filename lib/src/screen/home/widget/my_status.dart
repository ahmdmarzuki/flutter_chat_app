import 'package:chat_app/src/core/services/status/status_service.dart';
import 'package:chat_app/src/screen/home/add_status_screen.dart';
import 'package:chat_app/src/screen/home/my_status_view.dart';
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

    int currentStatusIndex = 0;

    final StatusService statusService = StatusService();

    return Column(
      children: [
        StreamBuilder(
            stream: statusService.getStatus(user.uid),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
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
              } else {
                final List<Map<String, dynamic>> statusData =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();

                if (statusData.isEmpty) {
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
                } else {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyStatusView(
                                statusData: statusData,
                              ),
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
                      ),
                      Positioned(
                          bottom: -5,
                          right: -5,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddStatusScreen()));
                            },
                            child: Image.asset(
                              'assets/button_add.png',
                              width: 28,
                            ),
                          )),
                    ],
                  );
                }
              }
            })),
        const SizedBox(height: 8),
        CostumText(text: "My Status", color: white)
      ],
    );
  }
}
