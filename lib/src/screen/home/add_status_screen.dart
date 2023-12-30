import 'package:chat_app/src/core/models/status_model.dart';
import 'package:chat_app/src/core/services/status/status_service.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/status_color_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddStatusScreen extends StatefulWidget {
  const AddStatusScreen({super.key});

  @override
  State<AddStatusScreen> createState() => _AddStatusScreenState();
}

class _AddStatusScreenState extends State<AddStatusScreen> {
  TextEditingController statusTextController = TextEditingController();
  int colorCode = 0;

  final List bgColor = StatusColor().bgColor;

  void addStatus() async {
    final service = Provider.of<StatusService>(context, listen: false);

    try {
      await service.addStatus(statusTextController.text, colorCode);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor[colorCode],
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(87),
          child: SafeArea(
            child: Container(
              height: 87,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (colorCode != bgColor.length - 1) {
                        setState(() {
                          colorCode++;
                        });
                      } else if (colorCode == bgColor.length - 1) {
                        setState(() {
                          colorCode = 0;
                        });
                      }
                    },
                    child: CircleAvatar(
                        radius: 21,
                        backgroundColor: white,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: bgColor[colorCode],
                        )),
                  )
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addStatus();

          Navigator.pop(context);
        },
        elevation: 0,
        backgroundColor: white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TextFormField(
                  controller: statusTextController,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: white,
                      fontSize: FSize().big,
                      fontWeight: FWeight().light),
                  decoration: InputDecoration.collapsed(
                      hintText: "Tulis status",
                      hintStyle: GoogleFonts.poppins(
                          color: white.withOpacity(.6),
                          fontSize: FSize().big,
                          fontWeight: FWeight().light)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
