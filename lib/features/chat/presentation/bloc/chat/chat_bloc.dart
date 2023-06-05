import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/features/auth/data/models/user_model.dart';
import 'package:message_app/features/home/data/models/message_model.dart';

import '../../../../../logic/database_service.dart';
import '../../../../../logic/helper_functions.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  Stream<List<MessageModel>>? chats;
  UserModel userModel = UserModel();

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<GetChatsEvent>(
      (event, emit) async {
        final dataBaseService = getDataBaseService();
        emit(ChatLoadingState());
        chats = dataBaseService.getChats(event.groupId);
        userModel = await dataBaseService.getUserInfoWithUserId();
        emit(ChatLoadedState());
      },
    );

    on<SendMessageEvent>(
      (event, emit) {
        try {
          if (event.message.isNotEmpty) {
            final messageModel = MessageModel(
              message: event.message,
              senderId: userModel.uid,
              senderImage: userModel.userImage,
              senderName: userModel.fullName,
              time: DateTime.now().millisecondsSinceEpoch.toString(),
            );

            getDataBaseService().sendMessage(event.groupId, messageModel);
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }
}
