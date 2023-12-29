import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:flutter/material.dart';

class MyStatusView extends StatefulWidget {
  
  final String text;
  const MyStatusView({super.key, required this.text});

  @override
  State<MyStatusView> createState() => _MyStatusViewState();
}

class _MyStatusViewState extends State<MyStatusView> {
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
                    text: 'My Status',
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
                      text: widget.text,
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
