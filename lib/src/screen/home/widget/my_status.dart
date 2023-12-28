import 'package:chat_app/src/screen/home/add_status_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:flutter/material.dart';

class MyStatus extends StatelessWidget {
  const MyStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddStatusScreen()));
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 27,
                child: Image.asset('assets/image_profile.png'),
              ),
              Positioned(
                  bottom: -5,
                  right: -5,
                  child: Image.asset(
                    'assets/button_add.png',
                    width: 28,
                  )),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CostumText(text: "My Status", color: white)
      ],
    );
  }
}
