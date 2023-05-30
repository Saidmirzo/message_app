part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final UserRegisterModel userRegisterModel;
  final BuildContext context;

  const RegisterUserEvent(
      {required this.context, required this.userRegisterModel});
}

class LoginUserEvent extends AuthEvent {
  final UserRegisterModel userRegisterModel;
  final BuildContext context;
  const LoginUserEvent(
      {required this.userRegisterModel, required this.context});
}

class LogOutEvent extends AuthEvent {
  final BuildContext context;
  const LogOutEvent({required this.context});
}
