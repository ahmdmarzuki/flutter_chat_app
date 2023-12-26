import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final DocumentSnapshot doc;

  const BubbleChat({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    // Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    // final DateTime sendAt = doc['sendAt'].to;
    // String formattedSendAt = DateFormat('KK:mm').format(sendAt);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: doc['senderUid'] == user.uid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color:
                        doc['senderUid'] == user.uid ? primaryColor : accentBlack,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      bottomRight:
                          Radius.circular(doc['senderUid'] == user.uid ? 0 : 12),
                      topRight: const Radius.circular(12),
                      bottomLeft:
                          Radius.circular(doc['senderUid'] != user.uid ? 0 : 12),
                    )),
                child: CostumText(
                    text: doc['message'], color: white, fontSize: FSize().medium),
              ),
              const SizedBox(height: 8),
              CostumText(text: doc['sendAt'], color: grey, fontSize: FSize().verySmall, fontWeight: FWeight().reguler,)
            ],
          ),
        ],
      ),
    );
  }
}
