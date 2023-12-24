import 'package:chat_app/src/screen/chat/detail_chat_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final DocumentSnapshot doc;
  const ContactCard({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser!.email != data['email']) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailChatScreen(
                          receiverName: data['username'],
                          receiverUid: data['uid'],
                        )));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            // color: white,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.asset('assets/image_profile.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CostumText(
                      text: data['username'],
                      color: white,
                      fontSize: FSize().medium,
                      fontWeight: FWeight().reguler,
                    ),
                    CostumText(text: "Last text", color: white)
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CostumText(text: "05.08", color: white),
                    Image.asset(
                      'assets/icon_check.png',
                      width: 22,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox();
  }
}
