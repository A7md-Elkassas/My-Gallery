import 'package:flutter/material.dart';
import 'package:my_gallery/components/size.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool isSecure;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onValidate,
    this.isSecure = false,
    this.suffixIcon,
  });

  String? Function(String?)? onValidate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: onValidate,
      obscureText: isSecure,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
            vertical: height(context) * 0.02,
            horizontal: width(context) * 0.05),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(34),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }
}
