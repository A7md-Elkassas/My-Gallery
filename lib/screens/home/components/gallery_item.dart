import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({
    super.key,
    required this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 0.1),
              )
            ],
            image:
                DecorationImage(image: NetworkImage(image!), fit: BoxFit.fill)),
      ),
    );
  }
}
