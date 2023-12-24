import 'package:chat_app/src/screen/home/widget/contact_card.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return CostumText(text: "Error", color: white);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            CostumText(text: "No Data", color: white);
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map<Widget>((doc) => ContactCard(
                      doc: doc,
                    ))
                .toList(),
          );
        }));
  }
}
