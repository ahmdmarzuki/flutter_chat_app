import 'package:chat_app/src/core/services/status/status_service.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
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

  void addStatus() async {
    final service = Provider.of<StatusService>(context, listen: false);
    

    try {
      await service.addStatus(statusTextController.text);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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
