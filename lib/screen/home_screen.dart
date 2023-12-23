import 'package:chat_app/screen/widget/my_status.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:flutter/material.dart';

import 'widget/contact_card.dart';
import 'widget/status_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: defaultMargin),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ContactCard();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: defaultMargin);
                },
              )
            ],
          ),
        ));
  }

  Widget header() {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: accentBlack),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            const CircleAvatar(
              radius: 25,
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
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return const StatusAvatar();
                },
              ),
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
          CostumText(text: "Connect to others", color: grey),
          Image.asset(
            'assets/icon_search.png',
            width: 24,
          )
        ],
      ),
    );
  }
}
