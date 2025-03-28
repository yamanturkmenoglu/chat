import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  Future<void> singUpUser(
      {required String email, required String password}) async {
    emit(SignupLoadingState());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignupSuccessState());
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          emit(
              SignupFailureState(errMsg: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(SignupFailureState(
              errMsg: 'The account already exists for that email.'));
        } else {
          emit(SignupFailureState(errMsg: 'hataha'));
        }
      } else {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
