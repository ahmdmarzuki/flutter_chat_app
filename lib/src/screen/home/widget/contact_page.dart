import 'package:chat_app/src/screen/home/widget/contact_card.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ContactCard();
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: defaultMargin);
      },
    );
  }
}
