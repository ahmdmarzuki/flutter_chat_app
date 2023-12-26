import 'package:chat_app/src/core/services/chat/chat_service.dart';
import 'package:chat_app/src/screen/home/widget/contact_card.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  final String searchText;
  const ContactPage({
    super.key,
    required this.searchText,
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
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            CostumText(text: "No Data", color: white);
          }

          if (searchText.isEmpty) {
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map<Widget>((doc) {
                return ContactCard(
                  userDoc: doc,
                );
              }).toList(),
            );
          } else {
            var filteredDocs = snapshot.data!.docs.where((doc) {
              var username = doc['username'];

              return username
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
            });
            return ListView(
                shrinkWrap: true,
                children: filteredDocs.map<Widget>((doc) {
                  return ContactCard(
                    userDoc: doc,
                  );
                }).toList());
          }
        }));
  }
}
