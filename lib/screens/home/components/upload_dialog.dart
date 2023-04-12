import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery/screens/home/components/dialog_button.dart';
import 'package:my_gallery/screens/home/controller/home_cubit.dart';

import '../../../components/images.dart';
import '../../../components/size.dart';

class UploadDialog extends StatelessWidget {
  const UploadDialog({Key? key, required this.homeCubit}) : super(key: key);
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlurryContainer(
        blur: 5,
        width: width(context) * 0.8,
        height: height(context) * 0.3,
        elevation: 0,
        color: Colors.white.withOpacity(0.15),
        padding: EdgeInsets.symmetric(
            horizontal: width(context) * 0.04,
            vertical: height(context) * 0.02),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DialogButton(
                image: AppImages.gallery,
                onPressed: () {
                  homeCubit.pickFromGallery(context: context);
                },
                text: "Gallery",
                scale: 3.5,
              ),
              SizedBox(height: height(context) * 0.05),
              DialogButton(
                image: AppImages.camera,
                onPressed: () {
                  homeCubit.pickFromCamera(context: context);
                },
                text: "Camera",
                scale: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
