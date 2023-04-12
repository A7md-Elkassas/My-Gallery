import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/components/custom_button.dart';
import 'package:my_gallery/components/custom_textField.dart';
import 'package:my_gallery/components/custom_toast.dart';
import 'package:my_gallery/components/images.dart';
import 'package:my_gallery/screens/home/view/home_view.dart';
import 'package:my_gallery/screens/login/controller/login_cubit.dart';

import '../../../components/size.dart';
import '../controller/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode currentFocuse = FocusScope.of(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is LoginSuccessState) {
          showSnackBar(
              context: context, text: "Succefully Logged in", success: true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
          );
        } else if (state is LoginErrorState) {
          showSnackBar(context: context, text: state.errorMsg!, success: false);
        }
      }, builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return GestureDetector(
          onTap: () {
            currentFocuse.unfocus();
          },
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.loginBg), fit: BoxFit.cover)),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: width(context) * 0.2),
                          child: Image.asset(
                            AppImages.cameraLogin,
                            scale: 4.2,
                          ),
                        ),
                      ),
                      SizedBox(height: height(context) * 0.0125),
                      Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: width(context) * 0.46,
                              child: Text(
                                "My Gallery",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.h1,
                                ),
                              ),
                            ),
                            SizedBox(height: height(context) * 0.0125),
                            Container(
                              width: width(context) * 0.85,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width(context) * 0.05,
                                    vertical: height(context) * 0.05),
                                child: Column(children: [
                                  Text(
                                    "LOG IN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppFonts.t2,
                                    ),
                                  ),
                                  SizedBox(height: height(context) * 0.04),
                                  CustomTextField(
                                      hintText: "User Name",
                                      controller: cubit.userNameCtrl,
                                      onValidate: (value) {
                                        if (value!.isEmpty) {
                                          return "email is required";
                                        } else if (!value.contains("@")) {
                                          return "email is invalid";
                                        }
                                      }),
                                  SizedBox(height: height(context) * 0.04),
                                  CustomTextField(
                                      hintText: "Password",
                                      controller: cubit.passwordCtrl,
                                      isSecure: cubit.isSecure,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(context) * 0.03),
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.changeSecurePass();
                                          },
                                          icon: cubit.isSecure
                                              ? const Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.grey,
                                                )
                                              : const Icon(Icons.visibility,
                                                  color: Colors.grey),
                                        ),
                                      ),
                                      onValidate: (value) {
                                        if (value!.isEmpty) {
                                          return "password is required ";
                                        } else if (value.length < 6) {
                                          return "password too short";
                                        }
                                      }),
                                  SizedBox(height: height(context) * 0.04),
                                  state is LoginLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : CustomButton(
                                          colored: false,
                                          onPressed: () {
                                            if (cubit.formKey.currentState!
                                                .validate()) {
                                              currentFocuse.unfocus();
                                              cubit.login(context);
                                            }
                                          },
                                          text: "SUBMIT",
                                          color: Colors.lightBlue,
                                          heightt: height(context) * 0.055,
                                        ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
