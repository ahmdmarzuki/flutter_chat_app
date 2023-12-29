import 'dart:async';

import 'package:chat_app/src/screen/home/home_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusView extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> userDoc;
  final int initialIndex;

  const StatusView({
    super.key,
    required this.userDoc,
    required this.initialIndex,
  });

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  int currentStatusIndex = 0;

  // @override
  // void initState() {
  //   Timer(const Duration(seconds: 5), () => Navigator.pop(context));

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    int currentUserIndex = widget.initialIndex;

    return Scaffold(
        backgroundColor: Colors.green,
        body:

            // Stream User List ---------------------------------------
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  // final User user = FirebaseAuth.instance.currentUser!;
                  final List<DocumentSnapshot<Map<String, dynamic>>> userDocs =
                      snapshot.data!.docs;
                  // .where((element) => element.data()['uid'] != user.uid)
                  // .toList();

                  return PageView.builder(
                      controller:
                          PageController(initialPage: widget.initialIndex),
                      onPageChanged: (value) {
                        setState(() {
                          currentUserIndex = value;
                          currentStatusIndex = 0;
                        });

                        print(
                            "currentUserIndex: " + currentUserIndex.toString());
                      },
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // stream status list ----------------------------------------
                        DocumentSnapshot<Map<String, dynamic>> statusDoc =
                            userDocs[index];

                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(statusDoc.id)
                              .collection('status')
                              .snapshots(),
                          builder: ((context, snapshot) {
                            final List<Map<String, dynamic>> statusList =
                                snapshot.data!.docs
                                    .map((doc) => doc.data())
                                    .toList();

                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    height: 87,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultMargin),
                                    child: SafeArea(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: white,
                                            radius: 22,
                                            child: CircleAvatar(
                                              radius: 20,
                                              child: Image.asset(
                                                  'assets/image_profile.png'),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          CostumText(
                                            text: statusList[currentStatusIndex]
                                                ['username'],
                                            color: white,
                                            fontSize: FSize().medium,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (currentStatusIndex != 0) {
                                            setState(() {
                                              currentStatusIndex--;
                                            });
                                          }

                                          print(currentStatusIndex.toString());
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          // width: double.infinity,
                                          color:
                                              Colors.redAccent.withOpacity(.3),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (currentStatusIndex !=
                                              statusList.length - 1) {
                                            setState(() {
                                              currentStatusIndex++;
                                            });
                                          } else if (currentStatusIndex ==
                                              statusList.length - 1) {
                                            setState(() {
                                              currentUserIndex++;
                                            });
                                          }

                                          print("currentStatusIndex: " +
                                              currentStatusIndex.toString());
                                          print("index: " + index.toString());
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          // width: double.infinity,
                                          color: Colors.amber.withOpacity(.3),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultMargin),
                                  child: Expanded(
                                    child: Center(
                                        child: CostumText(
                                            text: statusList[currentStatusIndex]
                                                ['text'],
                                            color: white,
                                            fontSize: FSize().big,
                                            fontWeight: FWeight().light)),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      });
                }));
  }
}
