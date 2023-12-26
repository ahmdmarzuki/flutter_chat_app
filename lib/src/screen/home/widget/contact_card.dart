import 'package:chat_app/src/core/services/chat/chat_service.dart';
import 'package:chat_app/src/screen/chat/detail_chat_screen.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactCard extends StatelessWidget {
  final DocumentSnapshot userDoc;

  // final Stream chatDoc;
  const ContactCard({
    super.key,
    required this.userDoc,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
    final User user = FirebaseAuth.instance.currentUser!;

// ----- mengambil room Id dan menjadikannya stream untuk ditampilkan ------------
    List<String> ids = [user.uid, userData['uid']];
    ids.sort();
    String chatRoomId = ids.join("-");

    final Stream<DocumentSnapshot<Map<String, dynamic>>> chatStream =
        FirebaseFirestore.instance
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('last_message')
            .doc(chatRoomId)
            .snapshots();
// --------------------------------------------------------------------------------

    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser!.email != userData['email']) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailChatScreen(
                          receiverName: userData['username'],
                          receiverUid: userData['uid'],
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
                      text: userData['username'],
                      color: white,
                      fontSize: FSize().medium,
                      fontWeight: FWeight().reguler,
                    ),
                    StreamBuilder(
                        stream: chatStream,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            var chatData =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return CostumText(
                                text: chatData['last_message'], color: white);
                          }

                          return const SizedBox();
                        }))
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                        stream: chatStream,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            var chatData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            
                            return CostumText(
                                text: chatData['sendAt'], color: white);
                          }

                          return const SizedBox();
                        })),
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

    return const SizedBox();
  }
}
