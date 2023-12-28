import 'dart:async';

import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusView extends StatefulWidget {
  final DocumentSnapshot doc;
  const StatusView({super.key, required this.doc});

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () => Navigator.pop(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(87),
          child: Container(
            height: 87,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: white,
                    radius: 22,
                    child: CircleAvatar(
                      radius: 20,
                      child: Image.asset('assets/image_profile.png'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  CostumText(
                    text: widget.doc['username'],
                    color: white,
                    fontSize: FSize().medium,
                  )
                ],
              ),
            ),
          )),
      backgroundColor: Colors.green,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Expanded(
              child: Center(
                  child: CostumText(
                      text: widget.doc['text'],
                      color: white,
                      fontSize: FSize().big,
                      fontWeight: FWeight().light)),
            )
          ],
        ),
      ),
    );
  }
}
