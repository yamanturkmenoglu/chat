
import 'package:chat/callservices.dart';
import 'package:chat/homepage.dart';
import 'package:chat/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController username = TextEditingController();
  final TextEditingController id = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "الرجاء ملء الحقل";
                    }
                    return null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "الرجاء ملء الحقل";
                    }
                    return null;
                  },
                  controller: id,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.perm_identity),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        sharedPreferences.setString("id", id.text);
                        sharedPreferences.setString("username", username.text);

                        Callservices callservices = Callservices();

                        callservices.onUserLogin(id.text, username.text);

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("Login", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}