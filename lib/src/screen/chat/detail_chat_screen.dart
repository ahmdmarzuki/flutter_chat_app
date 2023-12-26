import 'package:chat_app/src/core/services/chat/chat_service.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widget/bubble_chat.dart';

class DetailChatScreen extends StatefulWidget {
  final String receiverName;
  final String receiverUid;
  const DetailChatScreen(
      {super.key, required this.receiverName, required this.receiverUid});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  final ChatService chatService = ChatService();

  TextEditingController messageController = TextEditingController();

  ScrollController scrollController = ScrollController();

  void sendMessage() {
    chatService.sendMessage(widget.receiverUid, messageController.text);
  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: white,
                    ),
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
                      CostumText(
                        text: widget.receiverName,
                        color: white,
                        fontSize: FSize().medium,
                      ),
                      CostumText(
                        text: 'Sedang aktif',
                        color: white,
                        fontSize: FSize().small,
                      )
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
                controller: messageController,
                style: poppinsWhite,
                decoration: InputDecoration.collapsed(
                    hintText: "Type your message here", hintStyle: poppinsGrey),
              ),
            ),
            GestureDetector(
              onTap: () {
                sendMessage();

                messageController.clear();

                scrollDown();
              },
              child: Image.asset(
                'assets/icon_submit.png',
                width: 18,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          constraints: const BoxConstraints.expand(height: 800),
          child: SingleChildScrollView(
            controller: scrollController,
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StreamBuilder(
                    stream:
                        chatService.getMessage(user.uid, widget.receiverUid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return CostumText(text: 'Error', color: white);
                      }

                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((doc) => BubbleChat(
                                  doc: doc,
                                ))
                            .toList(),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
