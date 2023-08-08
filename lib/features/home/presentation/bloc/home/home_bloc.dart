import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/features/auth/data/models/user_model.dart';
import 'package:message_app/logic/database_service.dart';
import '../../../data/models/group_model.dart';
import '../../../data/models/search_group_model.dart';
import '../../../../../logic/helper_functions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Stream<List<GroupModel>>? groups;
  List<UserModel>? listUsers;
  UserModel userModel = UserModel();
  List<SearchGroupModel> listSearchGroupResult = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetGroupListEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        userModel =
            await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .getUserInfoWithUserId();
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
        try {
          listSearchGroupResult =
              await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .searchGroupByName(event.name);
          emit(HomeLoadedState());
        } catch (e) {
          emit(HomeErrorState(message: e.toString()));
        }
      },
    );
    on<ToggleGroupEvent>(
      (event, emit) async {
        await getDataBaseService().toggleGroup(event.searchGroupModel);
        add(GetGroupListEvent());
      },
    );
    on<GetAllUsers>(
      (event, emit) async {
        emit(HomeLoadingState());
        try {
          listUsers = await getDataBaseService().getAllUsers();
          emit(HomeLoadedState());
        } catch (e) {
          emit(HomeErrorState(message: e.toString()));
        }
      },
    );
  }
}
