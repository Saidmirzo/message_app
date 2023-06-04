part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetGroupListEvent extends HomeEvent {}

class CreateGroupEvent extends HomeEvent {
  final String userName;
  final String groupName;
  const CreateGroupEvent({required this.groupName, required this.userName});
}



class SearchGroupByName extends HomeEvent {
  final String name;
  const SearchGroupByName({required this.name});
}

class ToggleGroupEvent extends HomeEvent {
  final SearchGroupModel searchGroupModel;
  const ToggleGroupEvent({required this.searchGroupModel});
}
