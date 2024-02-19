import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tr_store/utils/extensions.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.fontWeight,
      this.textAlign});
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: context.textTheme.headlineSmall?.copyWith(
        color: color ?? Colors.black87,
        fontSize: size ?? 20.sp,
        overflow: TextOverflow.ellipsis,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontFamily: GoogleFonts.dekko().fontFamily,
      ),
    );
  }
}
