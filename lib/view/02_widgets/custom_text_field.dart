
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  //body
  final TextEditingController? controller;
  final TextDirection? textDirection;
  final bool obscureText;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  //functions
  final GestureTapCallback? onTap;
  //decoration
  final String? label;
  final String? hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool? filled;
  final double? borderRadius;
  final Color? fillColor;
  final Color? hintColor;
  final double? cursorHeight;
  final Color? cursorColor;
  //control
  final FormFieldValidator? validator;

  const CustomTextField({super.key,
    //body
    this.controller,
    this.textDirection,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.cursorHeight = 22,
    this.cursorColor = Colors.black,
    this.keyboardType = TextInputType.text,
    //functions
    this.onTap,
    //decoration
    this.label,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.filled = true,
    this.borderRadius = 5,
    this.fillColor = Colors.white70,
    this.hintColor = Colors.black,
    //control
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textDirection: textDirection,
      onTap: onTap,
      obscureText: obscureText,
      textAlign: textAlign,
      cursorHeight: cursorHeight,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: label != null ? Text(label!) : null,
        hintText: hintText ?? "",
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: filled,
        fillColor: fillColor,
        hintStyle: TextStyle(
          height: 1,
          color: hintColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(
            color: Colors.tealAccent,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
