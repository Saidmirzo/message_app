import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/group_model.dart';
import '../../../data/models/search_group_model.dart';
import '../../../../../logic/helper_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Stream<List<GroupModel>>? groups;
  String? userName;
  List<SearchGroupModel> listSearchGroupResult = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetGroupListEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        userName = await HeplerFunctions.getUserName();
        try {
          groups = await getDataBaseService().getUserGroups();

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
          await getDataBaseService()
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
         listSearchGroupResult =
            await getDataBaseService().searchGroupByName(event.name);

        // listSearchGroupResult.clear();
        // for (var element in searchGroupSnapshoot.docs) {
        //   listSearchGroupResult.add(
        //     SearchGroupModel(
        //       admin: element["admin"],
        //       groupId: element["groupId"],
        //       groupName: element["groupName"],
        //     ),
        //   );
        // }

        emit(HomeLoadedState());
      },
    );
    on<ToggleGroupEvent>(
      (event, emit) async {
        await getDataBaseService().toggleGroup(event.searchGroupModel);
        add(GetGroupListEvent());
      },
    );
  }
}
