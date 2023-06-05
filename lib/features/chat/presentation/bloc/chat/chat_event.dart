part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatsEvent extends ChatEvent {
  final String groupId;
  const GetChatsEvent({required this.groupId});
}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String groupId;
  const SendMessageEvent({required this.groupId, required this.message});
}
