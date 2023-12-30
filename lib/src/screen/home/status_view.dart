import 'dart:async';

import 'package:chat_app/src/screen/home/home_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/status_color_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusView extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> userDoc;
  final int initialIndex;
  final List<Map<String, dynamic>> statusList;
  final List<DocumentSnapshot<Map<String, dynamic>>> userDocs;

  const StatusView({
    super.key,
    required this.userDoc,
    required this.initialIndex,
    required this.statusList,
    required this.userDocs,
  });

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  int currentStatusIndex = 0;

  final List bgColor = StatusColor().bgColor;

  // @override
  // void initState() {
  //   Timer(const Duration(seconds: 5), () => Navigator.pop(context));

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // int currentUserIndex = widget.initialIndex;

    return Scaffold(
        backgroundColor:
            bgColor[widget.statusList[currentStatusIndex]['color_code']],
        body:

            // Stream User List ---------------------------------------
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  // final User user = FirebaseAuth.instance.currentUser!;
                  if (!snapshot.hasData) {
                    return CostumText(text: "No Data", color: white);
                  } else {
                    final List<DocumentSnapshot<Map<String, dynamic>>>
                        userDocs = snapshot.data!.docs;
                    // .where((element) => element.data()['uid'] != user.uid)
                    // .toList();

                    return PageView.builder(
                        controller:
                            PageController(initialPage: widget.initialIndex),
                        onPageChanged: (value) {
                          setState(() {
                            // currentUserIndex = value;
                            currentStatusIndex = 0;
                          });
                        },
                        itemCount: widget.userDocs.length,
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
                              if (!snapshot.hasData) {
                                return CostumText(
                                    text: "No Data", color: white);
                              } else {
                                return Stack(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (currentStatusIndex != 0) {
                                              setState(() {
                                                currentStatusIndex--;
                                              });
                                            }
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
                                            color: bgColor[widget.statusList[
                                                    currentStatusIndex]
                                                ['color_code']],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (currentStatusIndex !=
                                                widget.statusList.length - 1) {
                                              setState(() {
                                                currentStatusIndex++;
                                              });
                                            } else if (currentStatusIndex ==
                                                widget.statusList.length - 1) {
                                              setState(() {
                                                // currentUserIndex++;
                                              });
                                            }
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
                                            color: bgColor[widget.statusList[
                                                    currentStatusIndex]
                                                ['color_code']],
                                          ),
                                        )
                                      ],
                                    ),
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
                                                text: widget.statusList[
                                                        currentStatusIndex]
                                                    ['username'],
                                                color: white,
                                                fontSize: FSize().medium,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultMargin),
                                      child: Center(
                                          child: CostumText(
                                              text: widget.statusList[
                                                  currentStatusIndex]['text'],
                                              color: white,
                                              fontSize: FSize().big,
                                              fontWeight: FWeight().light)),
                                    ),
                                  ],
                                );
                              }
                            }),
                          );
                        });
                  }
                }));
  }
}
