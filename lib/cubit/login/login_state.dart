abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSucssusState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailedState extends LoginState {
  String errMsg;

  LoginFailedState({required this.errMsg});
}
