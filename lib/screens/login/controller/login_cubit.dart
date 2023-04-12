import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/components/constants.dart';
import 'package:my_gallery/core/local/app_cached.dart';
import 'package:my_gallery/network/end_points.dart';
import 'package:my_gallery/network/local/cache_helper.dart';
import 'package:my_gallery/network/remote/dio_helper.dart';
import 'package:my_gallery/screens/login/model/login_model.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool isSecure = true;

  void changeSecurePass() {
    isSecure = !isSecure;
    emit(SecurePassState());
  }

  LoginModel? loginModel;
  Future<void> login(BuildContext? context) async {
    emit(LoginLoadingState());
    try {
      DioHelper.postData(url: EndPoints.login, data: {
        "email": userNameCtrl.text,
        "password": passwordCtrl.text,
      }).then((value) {
        if (value.data['user'] != null) {
          loginModel = LoginModel.fromJson(value.data);
          print("${value.data.toString()}");
          emit(LoginSuccessState());
          saveData();
        } else {
          print(value.data);
          emit(LoginErrorState(errorMsg: value.data['error_message']));
        }
      });
    } catch (error) {
      print(error.toString());
      emit(LoginErrorState(errorMsg: error.toString()));
    }
  }

  void clearFields() {
    userNameCtrl.clear();
    passwordCtrl.clear();
  }

  void saveData() {
    debugPrint("-----------saving Data-----------");
    CacheHelper.saveData(AppCached.token, loginModel!.token);
    CacheHelper.saveData(AppCached.name, loginModel!.user.name);
  }
}
