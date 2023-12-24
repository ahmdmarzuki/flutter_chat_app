import 'package:chat_app/src/core/services/auth/auth_service.dart';
import 'package:chat_app/src/screen/home/widget/my_status.dart';
import 'package:chat_app/src/screen/home/widget/status_page.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/contact_card.dart';
import 'widget/contact_page.dart';
import 'widget/status_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIndex = 0;

  List navOption = [
    const ContactPage(),
    const StatusPage(),
  ];

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

  void signOut() async {
    final provider = Provider.of<AuthService>(context, listen: false);
    try {
      await provider.signOut();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 120,
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
                  CostumText(
                    text: "Fullname",
                    color: white,
                    fontSize: FSize().big,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  signOut();
                },
                child: const CircleAvatar(
                  radius: 25,
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
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              const MyStatus(),
              const SizedBox(width: 12),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return const StatusAvatar();
                },
              ),
            ],
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
            CostumText(text: "Connect to others", color: grey),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
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
