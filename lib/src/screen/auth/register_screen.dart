import 'package:chat_app/src/screen/auth/widget/expanded_button.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/costum_text.dart';
import 'package:chat_app/utils/font_weight.dart';
import 'package:chat_app/utils/margin.dart';
import 'package:chat_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;
  RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  bool passIsHide = true;
  bool passConfirmIsHide = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void togglePass() {
      setState(() {
        passIsHide = !passIsHide;
      });
    }

    void toggleConfirmPass() {
      setState(() {
        passConfirmIsHide = !passConfirmIsHide;
      });
    }

    Widget usernameInput() {
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
                //     'assets/icon_username.png',
                //     height: 20,
                //   ),
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      controller: emailController,
                      style: poppinsWhite,
                      decoration: InputDecoration.collapsed(
                          hintText: "Username", hintStyle: poppinsGrey)),
                ),
              ],
            ),
          ));
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
                // Container(
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

    Widget passwordConfirmationInput() {
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
                //     'assets/icon_password.png',
                //     height: 25,
                //   ),
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      obscureText: passConfirmIsHide ? true : false,
                      controller: passwordController,
                      style: poppinsWhite,
                      decoration: InputDecoration.collapsed(
                          hintText: "Re-Password", hintStyle: poppinsGrey)),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      toggleConfirmPass();
                    },
                    child: Image.asset(
                      passConfirmIsHide
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
                      text: "Getting Started",
                      color: white,
                      fontSize: 32,
                      fontWeight: FWeight().medium,
                    ),
                    CostumText(
                        text: "Hello, enjoy your experience here !",
                        color: grey,
                        fontWeight: FWeight().light)
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/image_register.png',
                    //   height: 200,
                    // ),
                    // usernameInput(),
                    const SizedBox(height: 20),
                    emailInput(),
                    const SizedBox(height: 20),
                    passwordInput(),
                    const SizedBox(height: 20),
                    passwordConfirmationInput(),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CostumText(
                            text: "Already have an account?", color: grey),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onTap: widget.onTap,
                            child:
                                CostumText(text: "Login", color: primaryColor))
                      ],
                    ),
                    const SizedBox(height: 12),
                    ExpandedButton(
                        text: "Register",
                        isLoading: isLoading,
                        textColor: white,
                        buttonColor: primaryColor,
                        loadingButtonColor: primaryColor.withOpacity(.7),
                        textStyle: GoogleFonts.poppins(),
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: accentBlack,
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultMargin),
                                  height: 338,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          height: 4,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: grey,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                        ),
                                      ),
                                      const Spacer(),
                                      CostumText(
                                        text: "Enter Your Name",
                                        color: white,
                                        fontSize: 20,
                                      ),
                                      CostumText(
                                        text: "What should I call you?",
                                        color: grey,
                                        fontSize: 14,
                                      ),
                                      const SizedBox(height: 40),
                                      usernameInput(),
                                      const SizedBox(height: 20),
                                      ExpandedButton(
                                        text: "Let's Started",
                                        isLoading: false,
                                        textColor: white,
                                        buttonColor: primaryColor,
                                        loadingButtonColor:
                                            primaryColor.withOpacity(.8),
                                        textStyle: poppinsWhite,
                                        onTap: () {
                                          // SignUp();
                                        },
                                      ),
                                      SizedBox(height: defaultMargin * 2),
                                    ],
                                  ),
                                );
                              });
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
