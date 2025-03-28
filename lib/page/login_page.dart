
import 'package:chat/callservices.dart';
import 'package:chat/cubit/chat/chat_cubit.dart';
import 'package:chat/cubit/login/login_cubit.dart';
import 'package:chat/cubit/login/login_state.dart';
import 'package:chat/main.dart';
import 'package:chat/page/home.dart';
import 'package:chat/page/sing_up_page.dart';
import 'package:chat/widget/custtom_button.dart';
import 'package:chat/widget/custtom_text_fild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  String? emailAddress;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('loading'),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is LoginSucssusState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(email: emailAddress!)),
          );
          BlocProvider.of<ChatCubit>(context).getMessage();
        } else if (state is LoginFailedState) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Login',
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
                        emailAddress = data;
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
                      title: 'Login',
                      ontap: () async {
                        if (formkey.currentState!.validate()) {
                           sharedPreferences.setString("id","444" );
                        sharedPreferences.setString("username","AHMET" );

                        Callservices callservices = Callservices();

                        callservices.onUserLogin("444", "AHMET");
                          BlocProvider.of<LoginCubit>(context).LoginUser(
                              emailAddress: emailAddress!, password: password!);
                          // try {
                          //   await LoginUser();
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('sucsses')));
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) {
                          //     return HomePage(
                          //       email: emailAddress!,
                          //     );
                          //   }));
                          // } on FirebaseAuthException catch (e) {
                          //   // ignore: avoid_print
                          //   print(e);
                          //   if (e.code == 'user-not-found') {
                          //     ShowDialog(context, 'No user found',
                          //         'No user found for that email.');
                          //   } else if (e.code == 'wrong-password') {
                          //     ShowDialog(context, 'Wrong password ',
                          //         'Wrong password provided for that user.');
                          //   }
                          // } catch (e) {
                          //   // ignore: avoid_print
                          //   print(e);
                          // }
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
                          'dont have an Account ?  ',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SingUpPage();
                            }));
                          },
                          child: const Text('SignUp',
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
