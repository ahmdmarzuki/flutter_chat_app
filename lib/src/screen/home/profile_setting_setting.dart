import 'package:chat_app/src/core/services/auth/auth_service.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_size.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  TextEditingController usernameController = TextEditingController();

  void updateDisplayName() async {
    final service = Provider.of<AuthService>(context, listen: false);

    try {
      await service.updateDisplayName(usernameController.text);
    } catch (e) {
      throw e.toString();
    }
  }

  void signOut() async {
    final provider = Provider.of<AuthService>(context, listen: false);
    try {
      await provider.signOut();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: accentBlack,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: white,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    width: defaultMargin,
                  ),
                  CostumText(
                    text: "Profile",
                    color: white,
                    fontSize: FSize().big,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      signOut();
                    },
                    child: CostumText(
                      text: "Sign Out",
                      color: Colors.red,
                      fontSize: FSize().medium,
                    ),
                  )
                ],
              ),
            ),
          )),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              const SizedBox(height: 100),
              CircleAvatar(
                radius: 50,
                child: Image.asset('assets/image_profile.png'),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    CustomForm(
                      formTitle: 'Username',
                      hintText: user.displayName,
                      controller: usernameController,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CostumText(text: "Email", color: white),
                            const SizedBox(width: 8),
                            CostumText(
                                text: "(you can't change email)", color: grey),
                          ],
                        ),
                        CostumText(
                          text: user.email.toString(),
                          color: grey,
                          fontSize: FSize().big,
                          fontWeight: FWeight().light,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (usernameController.text=='') {
                              print("Tidak ada perubahan");
                            } else {
                              updateDisplayName();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 8),
                            decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: CostumText(
                              text: "Save",
                              color: white,
                              fontSize: FSize().medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  final String formTitle;
  final String? hintText;
  final TextEditingController controller;
  const CustomForm({
    super.key,
    required this.formTitle,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CostumText(text: formTitle, color: white),
        TextFormField(
          controller: controller,
          style: GoogleFonts.poppins(color: white, fontSize: FSize().medium),
          decoration: InputDecoration.collapsed(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
                color: grey,
                fontSize: FSize().big,
                fontWeight: FWeight().light),
          ),
        )
      ],
    );
  }
}
