import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/local/app_cached.dart';
import 'package:my_gallery/network/end_points.dart';
import 'package:my_gallery/network/remote/dio_helper.dart';
import 'package:my_gallery/screens/home/model/home_model.dart';

import '../../../network/local/cache_helper.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  File? file;
  void pickFromGallery({required BuildContext context}) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile == null) return;
    file = File(pickedFile.path);
    debugPrint(file!.path);
    emit(PickImageState());
    await uploadImage(context);
    Navigator.pop(context);
  }

  void pickFromCamera({required BuildContext context}) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile == null) return;
    file = File(pickedFile.path);
    debugPrint(file!.path);
    emit(PickImageState());
    await uploadImage(context);
    Navigator.pop(context);
  }

  Future<void> uploadImage(BuildContext context) async {
    emit(HomeUploadImageLoadingState());
    try {
      if (file == null) return;
      String imageName = file!.path.split("/").last;
      var formData = FormData.fromMap({
        'img': await MultipartFile.fromFile(file!.path, filename: imageName)
      });
      DioHelper.postData(
              url: EndPoints.uploadImage,
              token: CacheHelper.getData(key: AppCached.token),
              data: formData)
          .then((value) {
        print(value.data);
        emit(HomeUploadImageSuccessState());
      });
    } catch (error) {
      debugPrint(error.toString());
      emit(HomeUploadImageErrorState());
    }
  }

  HomeModel? homeModel;
  Future<void> getGallery(BuildContext context) async {
    emit(HomeGetGalleryLoadingState());
    try {
      DioHelper.getData(
              url: EndPoints.getGallery,
              query: {},
              token: CacheHelper.getData(key: AppCached.token))
          .then((value) {
        homeModel = HomeModel.fromJson(value.data);
        emit(HomeGetGallerySuccessState());
      });
    } catch (error) {
      debugPrint(error.toString());
      emit(HomeGetGalleryErrorState());
    }
  }
}
