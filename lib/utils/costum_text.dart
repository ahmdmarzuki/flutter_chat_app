import 'package:chat_app/utils/font_weight.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumText extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  const CostumText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize,
    this.fontWeight = FontWeight.w300,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
      overflow: textOverflow,
      textAlign: textAlign,
    );
  }
}
