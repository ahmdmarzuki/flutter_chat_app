import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final String text;
  final bool isSender;
  const BubbleChat({
    super.key,
    this.isSender = true,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: isSender ?primaryColor:accentBlack,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                bottomRight: Radius.circular(isSender?0:12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(!isSender?0:12),
              )),
          child: CostumText(text: text, color: white, fontSize: FSize().medium),
        ),
      ],
    );
  }
}
