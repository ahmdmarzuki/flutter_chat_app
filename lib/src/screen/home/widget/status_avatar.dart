import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:flutter/material.dart';

class StatusAvatar extends StatelessWidget {
  const StatusAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 29,
          backgroundColor: primaryColor,
          child: CircleAvatar(
            radius: 27,
            backgroundColor: accentBlack,
            child: CircleAvatar(
              radius: 25,
              child: Image.asset('assets/image_profile.png'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        CostumText(text: "Name", color: white)
      ],
    );
  }
}
