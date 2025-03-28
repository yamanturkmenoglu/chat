// ignore_for_file: use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:chat/cubit/signup/signup_cubit.dart';
import 'package:chat/page/login_page.dart';
import 'package:chat/widget/custtom_button.dart';
import 'package:chat/widget/custtom_text_fild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SingUpPage extends StatelessWidget {
  SingUpPage({super.key});
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Loading..."),
          ));
        } else if (state is SignupSuccessState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else if (state is SignupFailureState) {
          ShowDialog(context, state.errMsg, state.errMsg);
        }
      },
      child: Scaffold(
          backgroundColor: const Color(0xFF095C61),
          body: Form(
            key: formkey,
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(child: Image.asset('assets/images/scholar.png')),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CusttomTextFild(
                      onChanged: (data) {
                        email = data;
                      },
                      hinttitle: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CusttomTextFild(
                      onChanged: (data) {
                        password = data;
                      },
                      hinttitle: 'Password',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CusttomButton(
                      title: 'Sign Up',
                      ontap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<SignupCubit>(context)
                              .singUpUser(email: email!, password: password!);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Alredy have  Account ?  ',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop((context));
                          },
                          child: const Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> SingUpUser() {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}

Future<dynamic> ShowDialog(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
