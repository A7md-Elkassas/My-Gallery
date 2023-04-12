import 'package:flutter/material.dart';

import '../../../components/custom_button.dart';
import '../../../components/size.dart';

class DialogButton extends StatelessWidget {
  const DialogButton(
      {super.key,
      required this.image,
      this.scale,
      required this.onPressed,
      required this.text});
  final GestureTapCallback onPressed;
  final String text;
  final String image;
  final double? scale;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.47,
      child: CustomButton(
        colored: true,
        onPressed: onPressed,
        text: text,
        fontSize: AppFonts.t3,
        fontWeight: FontWeight.bold,
        colorText: Colors.black,
        image: image,
        imageScale: scale,
        radius: 20,
        color: const Color(0xffEBDEF8),
        heightt: height(context) * 0.065,
      ),
    );
  }
}
