import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/text_style.dart';
import 'package:flutter/material.dart';

import 'widget/bubble_chat.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({super.key});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 120,
            color: accentBlack,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    color: white,
                  ),
                  const SizedBox(width: 12),
                   CircleAvatar(
                    child: Image.asset('assets/image_profile.png'),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CostumText(text: 'Name', color: white, fontSize: FSize().medium,),
                      CostumText(text: 'Sedang aktif', color: white, fontSize: FSize().small,)
                    ],
                  )
                ],
              ),
            ),
          )),
      bottomNavigationBar: Container(
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                style: poppinsWhite,
                decoration: InputDecoration.collapsed(
                    hintText: "Type your message here", hintStyle: poppinsGrey),
              ),
            ),
            Image.asset(
              'assets/icon_submit.png',
              width: 18,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 30);
                },
                itemBuilder: (BuildContext context, int index) {
                  return const BubbleChat(text: "tessss");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
