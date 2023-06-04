import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../logic/database_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  Stream<dynamic>? chats;
  final DataBaseService dataBaseService;

  ChatBloc({required this.dataBaseService}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<GetChatsEvent>(
      (event, emit) async {
        emit(ChatLoadingState());
        chats = dataBaseService
            .getChats(event.groupId);
        emit(ChatLoadedState());
      },
    );

    on<SendMessageEvent>(
      (event, emit) {
        try {
          if (event.message.isNotEmpty) {
            Map<String, dynamic> chatMessageMap = {
              "message": event.message,
              "sender": event.userName,
              "time": DateTime.now().millisecondsSinceEpoch,
            };

            dataBaseService.sendMessage(event.groupId, chatMessageMap);
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }
}
