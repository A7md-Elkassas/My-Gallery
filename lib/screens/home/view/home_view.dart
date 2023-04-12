import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/components/custom_button.dart';
import 'package:my_gallery/components/custom_icon_button.dart';
import 'package:my_gallery/components/custom_toast.dart';
import 'package:my_gallery/components/images.dart';
import 'package:my_gallery/components/size.dart';
import 'package:my_gallery/screens/home/components/upload_dialog.dart';
import 'package:my_gallery/screens/home/controller/home_cubit.dart';
import 'package:my_gallery/screens/login/view/login_view.dart';

import '../../../core/local/app_cached.dart';
import '../../../network/local/cache_helper.dart';
import '../components/gallery_item.dart';
import '../controller/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getGallery(context),
      child: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
        if (state is PickImageState) {
          showSnackBar(
              text: "Picked Image Succesfully",
              context: context,
              success: true);
        } else if (state is HomeGetGalleryLoadingState) {
          showSnackBar(
              context: context, text: "Uploading Image", success: true);
        } else if (state is HomeUploadImageSuccessState) {
          HomeCubit.get(context).getGallery(context);
        }
      }, builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.homeBg), fit: BoxFit.cover)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height(context) * 0.02,
                    horizontal: width(context) * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: AppFonts.t4,
                              ),
                            ),
                            Text(
                              CacheHelper.getData(key: AppCached.name),
                              style: TextStyle(
                                fontSize: AppFonts.t4,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(AppImages.user),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.04,
                          vertical: height(context) * 0.04),
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                                color: Colors.white,
                                image: AppImages.logout,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
                                    ),
                                  );
                                  showSnackBar(
                                      context: context,
                                      text: "Succefully Logged out",
                                      success: true);
                                },
                                text: "log out"),
                            CustomIconButton(
                                color: Colors.white,
                                image: AppImages.upload,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => UploadDialog(
                                            homeCubit: cubit,
                                          ));
                                },
                                text: "upload"),
                          ],
                        ),
                      ),
                    ),
                    if (state is HomeUploadImageLoadingState)
                      const Center(
                        child: LinearProgressIndicator(),
                      ),
                    state is HomeGetGalleryLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.homeModel!.data.images.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1.84 / 1.84),
                              itemBuilder: (context, index) {
                                return GalleryItem(
                                    image: cubit.homeModel!.data.images[index]);
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
