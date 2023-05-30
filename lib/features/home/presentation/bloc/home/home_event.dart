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

class GetChatsEvent extends HomeEvent {
  final String groupId;
  const GetChatsEvent({required this.groupId});
}

class SendMessageEvent extends HomeEvent {
  final String message;
  final String groupId;
  final String userName;
  const SendMessageEvent(
      {required this.groupId, required this.userName, required this.message});
}

class SearchGroupByName extends HomeEvent {
  final String name;
  const SearchGroupByName({required this.name});
}

class ToggleGroupEvent extends HomeEvent {
  final GroupModel groupModel;
  const ToggleGroupEvent({required this.groupModel});
}
