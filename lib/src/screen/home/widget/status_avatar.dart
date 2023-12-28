import 'package:chat_app/src/screen/home/status_view.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusAvatar extends StatelessWidget {
  final DocumentSnapshot doc;
  const StatusAvatar({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contetx) => StatusView(
                          doc: doc,
                        )));
          },
          child: CircleAvatar(
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
        ),
        const SizedBox(height: 8),
        CostumText(text: doc['username'], color: white)
      ],
    );
  }
}
