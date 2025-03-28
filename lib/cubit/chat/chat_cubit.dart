import 'package:chat/model/messagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  sendMessage({required String message, required String email}) {
    try {
      messages
          .add({'message': message, 'createdAt': DateTime.now(), 'id': email});
    // ignore: empty_catches
    } on Exception {}
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];
      for (var doc in event.docs) {
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSendSuccess(message: messageList));
    });
  }
}
