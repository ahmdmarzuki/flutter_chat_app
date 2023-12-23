import 'package:chat_app/src/screen/chat/detail_chat_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailChatScreen()));
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CostumText(
                  text: "Name",
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
    );
  }
}
