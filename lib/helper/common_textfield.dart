import 'package:diary/helper/constants.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final double fontSize;
  final double textSize;
  final FontWeight? textWeight;
  final FontWeight fontWeight;
  final int? maxLines;
  final bool? showCursor;
  const CommonTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.fontSize,
    required this.fontWeight,
    this.maxLines,
    required this.textSize,
    this.textWeight,
    this.showCursor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      showCursor: showCursor,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      style:
          TextStyle(color: black, fontSize: textSize, fontWeight: textWeight),
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
