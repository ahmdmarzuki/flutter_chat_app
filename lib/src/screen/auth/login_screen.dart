import 'package:chat_app/src/screen/auth/widget/expanded_button.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passIsHide = true;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void togglePass() {
      setState(() {
        passIsHide = !passIsHide;
      });
    }

    Widget emailInput() {
      return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: bg2.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Container(
                //   width: 30,
                //   child: Image.asset(
                //     'assets/icon_email.png',
                //     height: 20,
                //   ),
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      controller: emailController,
                      style: poppinsWhite,
                      decoration: InputDecoration.collapsed(
                          hintText: "Email", hintStyle: poppinsGrey)),
                ),
              ],
            ),
          ));
    }

    Widget passwordInput() {
      return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: bg2.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // SizedBox(
                //   width: 30,
                //   child: Image.asset(
                //     'assets/icon_password.png',
                //     height: 25,
                //   ),
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      obscureText: passIsHide ? true : false,
                      controller: passwordController,
                      style: poppinsWhite,
                      decoration: InputDecoration.collapsed(
                          hintText: "Password", hintStyle: poppinsGrey)),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      togglePass();
                    },
                    child: Image.asset(
                      passIsHide
                          ? 'assets/icon_eye_close.png'
                          : 'assets/icon_eye_open.png',
                      width: 20,
                      color: white,
                    ))
              ],
            ),
          ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: accentBlack,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: defaultMargin * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CostumText(
                      text: "Wellcome Back",
                      color: white,
                      fontSize: 32,
                      fontWeight: FWeight().medium,
                    ),
                    CostumText(
                        text: "It's been a long time since you left",
                        color: grey,
                        fontWeight: FWeight().light)
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    // Image.asset('assets/image_login.png'),
                    emailInput(),
                    const SizedBox(height: 20),
                    passwordInput(),
                    SizedBox(height: defaultMargin * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CostumText(
                            text: "Don't have any account?", color: grey),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onTap: widget.onTap,
                            child: CostumText(
                                text: "Register", color: primaryColor))
                      ],
                    ),
                    const SizedBox(height: 12),
                    ExpandedButton(
                        text: "Login",
                        isLoading: isLoading,
                        textColor: white,
                        buttonColor: primaryColor,
                        loadingButtonColor: primaryColor.withOpacity(.7),
                        textStyle: GoogleFonts.poppins(),
                        onTap: () {
                          // signIn();
                        })
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
