import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/features/home/data/models/group_model.dart';
import 'package:message_app/features/home/data/models/search_group_model.dart';
import 'package:message_app/logic/database_service.dart';
import 'package:message_app/logic/helper_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Stream<List<GroupModel>>? groups;
  Stream<dynamic>? chats;
  String? userName;
  List<SearchGroupModel> listSearchGroupResult = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetGroupListEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        userName = await HeplerFunctions.getUserName();
        try {
          groups =
              await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .getUserGroups();

          emit(HomeLoadedState());
        } catch (e) {
          emit(HomeErrorState(message: e.toString()));
        }
      },
    );
    on<CreateGroupEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        try {
          await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .createGroup(event.userName, event.groupName);

          add(GetGroupListEvent());
          emit(HomeLoadedState());
        } catch (e) {
          emit(HomeErrorState(message: e.toString()));
        }
      },
    );
    on<GetChatsEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        chats = DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getChats(event.groupId);
        emit(HomeLoadedState());
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

            DataBaseService().sendMessage(event.groupId, chatMessageMap);
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
    on<SearchGroupByName>(
      (event, emit) async {
        emit(HomeLoadingState());
        final searchGroupSnapshoot =
            await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .searchGroupByName(event.name);
        for (var element in searchGroupSnapshoot.docs) {
          listSearchGroupResult.add(
            SearchGroupModel(
              admin: element["admin"],
              groupId: element["groupId"],
              groupName: element["groupName"],
            ),
          );
        }

        emit(HomeLoadedState());
      },
    );
    on<ToggleGroupEvent>(
      (event, emit) async {
        await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .toggleGroup(event.searchGroupModel);
        add(GetGroupListEvent());
      },
    );
  }
}
