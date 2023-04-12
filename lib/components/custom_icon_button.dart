import 'package:flutter/material.dart';

import 'size.dart';
import 'custom_button.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.color,
      required this.image,
      required this.onPressed,
      required this.text});
  final GestureTapCallback onPressed;
  final String? image;
  final String? text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.38,
      height: height(context) * 0.048,
      child: CustomButton(
        colored: true,
        color: color,
        onPressed: onPressed,
        text: text,
        colorText: Colors.black,
        image: image,
      ),
    );
  }
}
