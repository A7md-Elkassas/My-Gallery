import 'package:flutter/material.dart';
import 'package:my_gallery/components/images.dart';
import 'package:my_gallery/components/size.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final String? image;
  final Function()? onPressed;
  final bool? colored;
  final double? fontSize;
  final double? heightt;
  final double? imageScale;
  final Color? color;
  final Color? colorText;

  final double radius;
  final FontWeight? fontWeight;
  CustomButton(
      {Key? key,
      this.text,
      this.image,
      this.color,
      required this.colored,
      this.colorText,
      this.fontSize,
      required this.onPressed,
      this.fontWeight,
      this.imageScale,
      this.radius = 15,
      this.heightt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width(context) * 0.88,
        height: heightt ?? height(context) * 0.078,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: colored == true
            ? Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.05),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    image!,
                    scale: imageScale ?? 1.2,
                  ),
                  const Spacer(),
                  Text(text!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorText ?? Colors.black,
                        fontSize: fontSize ?? AppFonts.t4,
                        fontWeight: fontWeight ?? FontWeight.bold,
                      )),
                ]),
              )
            : Center(
                child: Text(text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorText ?? Colors.white,
                        fontWeight: fontWeight ?? FontWeight.bold,
                        fontSize: fontSize ?? AppFonts.t4)),
              ),
      ),
    );
  }
}
