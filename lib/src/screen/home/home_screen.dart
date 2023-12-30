import 'package:chat_app/src/core/services/auth/auth_service.dart';
import 'package:chat_app/src/core/services/status/status_service.dart';
import 'package:chat_app/src/screen/home/profile_setting_setting.dart';
import 'package:chat_app/src/screen/home/status_view.dart';
import 'package:chat_app/src/screen/home/widget/my_status.dart';
import 'package:chat_app/src/screen/home/widget/status_page.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/contact_card.dart';
import 'widget/contact_page.dart';
import 'widget/status_avatar.dart';

int currentIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User user = FirebaseAuth.instance.currentUser!;

  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  int navIndex = 0;

  int statusAvatarIndex = 0;

  final StatusService statusService = StatusService();

  void navToStatusPage() {
    setState(() {
      navIndex = 1;
    });
  }

  void navToContactsPage() {
    setState(() {
      navIndex = 0;
    });
  }

  void fetch() {
    final String newSearchText = searchController.text;
    setState(() {
      searchText = newSearchText;
    });
  }

  // void onPageChanged(value) {
  //   setState(() {
  //     statusAvatarIndex = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List navOption = [
      ContactPage(
        searchText: searchText,
      ),
      const StatusPage(),
    ];

    Widget header() {
      return Container(
        height: 130,
        decoration: BoxDecoration(color: accentBlack),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CostumText(
                    text: "Hello",
                    color: white,
                    fontSize: FSize().medium,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
                        var data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return CostumText(
                          text: data['username'],
                          color: white,
                          fontSize: FSize().big,
                        );
                      })
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileSettingScreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 25,
                  child: Image.asset('assets/image_profile.png'),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget statusBar() {
      return Container(
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.only(top: defaultMargin),
        decoration: BoxDecoration(
            color: accentBlack,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Expanded(
            child: Row(
              children: [
                SizedBox(width: defaultMargin),
                const MyStatus(),
                const SizedBox(width: 12),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot<Map<String, dynamic>>>
                            userDocs = snapshot.data!.docs;
                        final List<DocumentSnapshot<Map<String, dynamic>>>
                            otheUserDocs = snapshot.data!.docs
                                .where((element) =>
                                    element.data()['uid'] != user.uid &&
                                    element.data()['hasStatus'] == true)
                                .toList();

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: userDocs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              DocumentSnapshot<Map<String, dynamic>> userDoc =
                                  userDocs[index];

                              int initialUserIndex = index;

                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userDoc.id)
                                      .collection('status')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final List<Map<String, dynamic>>
                                          statusListAvatar = snapshot.data!.docs
                                              .take(1)
                                              .map((doc) => doc.data())
                                              .toList();

                                      final List<Map<String, dynamic>>
                                          statusList = snapshot.data!.docs
                                              .map((doc) => doc.data())
                                              .toList();

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: statusListAvatar.length,
                                        itemBuilder: (context, index) {
                                          return StatusAvatar(
                                            username: statusListAvatar[0]
                                                ['username'],
                                            uid: statusListAvatar[0]['uid'],
                                            text: statusListAvatar[0]['text'],
                                            userDoc: userDoc,
                                            initialIndex: initialUserIndex,
                                            statusList: statusList,
                                            userDocs: otheUserDocs,
                                          );
                                        },
                                      );

                                     
                                    }
                                    return const SizedBox();
                                  });
                            }));
                      }
                      return CostumText(text: "No Data", color: white);
                    })
              ],
            ),
          ),
        ),
      );
    }

    Widget searchBar() {
      return Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: accentBlack,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: searchController,
                style: poppinsWhite,
                onFieldSubmitted: (value) {
                  fetch();
                },
                decoration: InputDecoration.collapsed(
                    hintText: "Connect to others", hintStyle: poppinsGrey),
              ),
            ),
            Image.asset(
              'assets/icon_search.png',
              width: 24,
            )
          ],
        ),
      );
    }

    Widget navigation() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              navToContactsPage();
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                  color: navIndex == 0 ? accentBlack : bg1,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: CostumText(
                text: "Contacts",
                color: white,
                fontSize: FSize().medium,
              )),
            ),
          ),
          GestureDetector(
            onTap: () {
              navToStatusPage();
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                  color: navIndex == 1 ? accentBlack : bg1,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: CostumText(
                  text: "Status",
                  color: white,
                  fontSize: FSize().medium,
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
        backgroundColor: bg1,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(87), child: header()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              statusBar(),
              SizedBox(height: defaultMargin),
              searchBar(),
              const SizedBox(height: 50),
              navigation(),
              SizedBox(height: defaultMargin),
              navOption[navIndex],
              SizedBox(height: defaultMargin)
            ],
          ),
        ));
  }
}
