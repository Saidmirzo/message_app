part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends SettingsEvent {}

class UpdateImageEvent extends SettingsEvent {}

class SaveChanges extends SettingsEvent {
  final UserModel userModel;
  const SaveChanges({required this.userModel});
}
