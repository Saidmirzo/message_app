import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/config/routes/routes.dart';
import 'package:message_app/features/auth/data/models/user_register_model.dart';
import 'package:message_app/logic/auth_service.dart';
import 'package:message_app/logic/helper_functions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  String userImage = '';
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<RegisterUserEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          await authService
              .registerUserWithEmailAndPassword(event.userRegisterModel);
          Navigator.pushReplacementNamed(event.context, Routes.homePage);
          emit(AuthLoadedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      },
    );
    on<LoginUserEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          final String result = await authService.loginWithUserNameAndPassword(
            event.userRegisterModel.email,
            event.userRegisterModel.password,
          );
          Navigator.pushReplacementNamed(event.context, Routes.homePage);

          emit(AuthLoadedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      },
    );
    on<LogOutEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          final bool? resultYes = await alertDialog(event.context);
          log(resultYes.toString());
          if (resultYes != null && resultYes) {
            await authService.logOut();
            Navigator.pushReplacementNamed(event.context, Routes.splashPage);
          }
          emit(AuthLoadedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      },
    );
    on<UploadImageEvent>(
      (event, emit) async {
        emit(ImageUploadingState());
        try {
          final imagePicker = ImagePicker();
          final XFile? xFile =
              await imagePicker.pickImage(source: ImageSource.gallery);
          userImage = xFile!.path;
          emit(ImageUploadedState());
        } catch (e) {
          emit(AuthErrorState(message: e.toString()));
        }
      },
    );
  }
}
