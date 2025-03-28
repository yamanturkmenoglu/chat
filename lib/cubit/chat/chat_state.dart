part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

// ignore: must_be_immutable
final class ChatSendSuccess extends ChatState {
  
  List<MessageModel> message;

  ChatSendSuccess({required this.message});
}

final class ChatSendFailure extends ChatState {
  final String message;

  ChatSendFailure({required this.message});
}
