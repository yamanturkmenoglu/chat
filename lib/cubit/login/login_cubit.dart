// ignore_for_file: non_constant_identifier_names

import 'package:chat/cubit/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> LoginUser(
      {required String emailAddress, required String password}) async {
    emit(LoginLoadingState());

    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      emit(LoginSucssusState());
    } catch (e) {
      if (e is FirebaseAuthException) {
        
        if (e.code == 'user-not-found') {
          emit(LoginFailedState(errMsg: 'User not found!'));
        } else if (e.code == 'wrong-password') {
          emit(LoginFailedState(errMsg: 'Wrong password!'));
        } else {
          emit(LoginFailedState(errMsg: 'hataha'));
        }
      } else {
        // Other non-Firebase authentication related errors
        if (kDebugMode) {
          print(e);
        }
      }
      
    }
  }
}
