import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandedButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Color textColor;
  final Color buttonColor;
  final Color loadingButtonColor;
  final TextStyle textStyle;
  final void Function() onTap;
  const ExpandedButton(
      {super.key,
      required this.text,
      required this.isLoading,
      required this.textColor,
      required this.buttonColor,
      required this.loadingButtonColor,
      required this.textStyle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isLoading ? loadingButtonColor : buttonColor),
        child: Center(
            child: Stack(
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(color: textColor, fontSize: 18),
            ),
            isLoading ? const CircularProgressIndicator() : const SizedBox()
          ],
        )),
      ),
    );
  }
}
