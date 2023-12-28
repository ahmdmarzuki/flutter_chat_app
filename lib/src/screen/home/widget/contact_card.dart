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

class ContactCard extends StatelessWidget {
  final DocumentSnapshot userDoc;
  final String searchText;

  // final Stream chatDoc;
  const ContactCard({
    super.key,
    required this.userDoc,
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = userDoc.data()! as Map<String, dynamic>;
    final User user = FirebaseAuth.instance.currentUser!;

    final FirebaseFirestore db = FirebaseFirestore.instance;

// ----- mengambil room Id dan menjadikannya stream untuk ditampilkan ------------
    List<String?> ids = [user.uid, userData['uid']];
    ids.sort();
    String chatRoomId = ids.join("-");

    final Stream<DocumentSnapshot<Map<String, dynamic>>> chatStream =
        FirebaseFirestore.instance
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('last_message')
            .doc(chatRoomId)
            .snapshots();

    // var chatData = chatStream as Map<String, dynamic>;
// --------------------------------------------------------------------------------

    // final FirebaseAuth auth = FirebaseAuth.instance;

    if (user.email != userData['email']) {
      return StreamBuilder(
        stream: chatStream,
        builder: (context, snapshot) {
// jika terdapat data dalam database ------------------------------------------
          if (snapshot.hasData) {
            // ignore: unnecessary_cast
            var chatData = snapshot.data!.data() as Map<String, dynamic>? ?? {};

// ---------Jika user punya riwayat chat---------------------------------------
//----------maka tampilkan di home screen--------------------------------------
            if (chatData['last_message'] != null || searchText != '') {
              return Card(
                  userData: userData,
                  chatData: chatData,
                  user: user,
                  db: db,
                  chatRoomId: chatRoomId);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return const SizedBox();
            }
          }

          return const SizedBox();
        },
      );
    }

    return const SizedBox();
  }
}

// Card widget  ---------------------------------------------------------------
class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.userData,
    required this.chatData,
    required this.user,
    required this.db,
    required this.chatRoomId,
  });

  final Map<String, dynamic> userData;
  final Map<String, dynamic> chatData;
  final User user;
  final FirebaseFirestore db;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChatScreen(
              receiverName: userData['username'],
              receiverUid: userData['uid'],
            ),
          ),
        );

        if (chatData['senderUid'] != user.uid) {
          db
              .collection('chat_rooms')
              .doc(chatRoomId)
              .collection('last_message')
              .doc(db.collection('chat_rooms').doc(chatRoomId).id)
              .update({'read': true});
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        color: bg1,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.asset('assets/image_profile.png'),
                ),
                Visibility(
                  visible: chatData['read'] == false &&
                      chatData['senderUid'] != user.uid,
                  child: Positioned(
                    bottom: -2,
                    right: -2,
                    child: CircleAvatar(
                        radius: 9,
                        backgroundColor: bg1,
                        child: const CircleAvatar(radius: 6)),
                  ),
                ),
              ],
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
                CostumText(
                  text: chatData['last_message'] ?? '',
                  color: white,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CostumText(
                  text: chatData['sendAt'] ?? '',
                  color: white,
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: chatData['senderUid'] == user.uid,
                  child: Image.asset(
                    'assets/icon_check.png',
                    width: 22,
                    color: chatData['read'] == true ? primaryColor : grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
