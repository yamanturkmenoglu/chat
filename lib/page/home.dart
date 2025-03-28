import 'package:chat/callservices.dart';
import 'package:chat/cubit/chat/chat_cubit.dart';
import 'package:chat/main.dart';
import 'package:chat/model/messagemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.email});

  final String email;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  final ScrollController _controller = ScrollController();

  List<MessageModel> messageList = [];
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
      resizeToAvoidBottomInset: true, // Klavye açılınca içeriği yukarı kaydır
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF095C61),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ahmet",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Çevrimiçi',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              ZegoUIKitPrebuiltCallInvitationService().send(
                resourceID: "yaman",
                invitees: [ZegoCallUser("333", "yaman")],
                isVideoCall: false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              ZegoUIKitPrebuiltCallInvitationService().send(
                resourceID: "yaman",
                invitees: [ZegoCallUser("333", "yaman")],
                isVideoCall: false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat_bg.jpg"), // Arka plan resmi
            fit: BoxFit.cover, // Ekrana tam oturtur
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSendSuccess) {
                    messageList = state.message;
                    Future.delayed(const Duration(milliseconds: 100), () {
                      _controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == widget.email
                          ? ChatBubble(message: messageList[index])
                          : ChatBubbleFromFriends(message: messageList[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF095C61),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.mic, color: Color(0xFFF8F8F8)),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: TextField(
                          controller: controller,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              BlocProvider.of<ChatCubit>(context).sendMessage(
                                message: value.trim(),
                                email: widget.email,
                              );
                              controller.clear();
                            }
                          },
                          decoration: InputDecoration(
                            filled: true, // Arka planı doldur
                            fillColor: const Color.fromARGB(
                              255,
                              224,
                              223,
                              219,
                            ), // Arka plan rengini beyaz yap
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF095C61),
                                width: 1,
                              ),
                            ),
                            hintText: 'Mesajınızı yazın...',
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Color(0xFF095C61),
                              ),
                              onPressed: () {
                                if (controller.text.trim().isNotEmpty) {
                                  BlocProvider.of<ChatCubit>(
                                    context,
                                  ).sendMessage(
                                    message: controller.text.trim(),
                                    email: widget.email,
                                  );
                                  controller.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF095C61),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleFromFriends extends StatelessWidget {
  const ChatBubbleFromFriends({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
