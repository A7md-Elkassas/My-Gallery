abstract class LoginState {}

class LoginInitial extends LoginState {}

class SecurePassState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String? errorMsg;
  LoginErrorState({this.errorMsg});
}
