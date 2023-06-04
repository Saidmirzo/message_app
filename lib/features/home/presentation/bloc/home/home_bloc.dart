
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:message_app/features/home/data/models/group_model.dart';
import 'package:message_app/features/home/data/models/search_group_model.dart';
import 'package:message_app/logic/database_service.dart';
import 'package:message_app/logic/helper_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Stream<List<GroupModel>>? groups;
  String? userName;
  final DataBaseService dataBaseService;
  List<SearchGroupModel> listSearchGroupResult = [];
  HomeBloc({required this.dataBaseService}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetGroupListEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        userName = await HeplerFunctions.getUserName();
        try {
          groups =
              await dataBaseService
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
          await dataBaseService
              .createGroup(event.userName, event.groupName);

          add(GetGroupListEvent());
          emit(HomeLoadedState());
        } catch (e) {
          emit(HomeErrorState(message: e.toString()));
        }
      },
    );

    on<SearchGroupByName>(
      (event, emit) async {
        emit(HomeLoadingState());
        final searchGroupSnapshoot =
            await dataBaseService
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
        await dataBaseService
            .toggleGroup(event.searchGroupModel);
        add(GetGroupListEvent());
      },
    );
  }
}
