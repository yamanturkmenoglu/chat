import 'package:chat/callservices.dart';
import 'package:chat/main.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Callservices callservices = Callservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callservices.onUserLogin(
      sharedPreferences.getString("id")!,
      sharedPreferences.getString("username")!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Home Page!'),
            SizedBox(height: 20),
            MaterialButton(onPressed: (){
              setState(() {
                
              });
            },
            child: Text("up"),
            ),
            ZegoSendCallInvitationButton(
              isVideoCall: false,

              resourceID: "yaman",
              invitees: [ZegoUIKitUser(id: "123", name: "yaman")],
            ),
          ],
        ),
      ),
    );
  }
}
