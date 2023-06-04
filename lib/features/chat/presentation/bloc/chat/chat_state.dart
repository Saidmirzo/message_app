part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatErrorState extends ChatState {
  final String message;
  const ChatErrorState({required this.message});
}
