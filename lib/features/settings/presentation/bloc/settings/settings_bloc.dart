import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/features/auth/data/models/user_model.dart';
import 'package:message_app/logic/database_service.dart';

import '../../../../../logic/storage_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late UserModel userModel;
  String userImage = '';
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {});
    on<GetUserInfoEvent>(
      (event, emit) async {
        emit(SettingsLoadingState());
        try {
          userModel =
              await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .getUserInfoWithUserId();
          emit(SettingsLoadedState());
        } catch (e) {
          emit(SettingsErrorState(message: e.toString()));
        }
      },
    );
    on<UploadimageEvent>(
      (event, emit) async {
        emit(SettingsLoadingState());
        final imagePicker = ImagePicker();
        final XFile? xFile =
            await imagePicker.pickImage(source: ImageSource.gallery);
        userImage = xFile!.path;
        emit(SettingsLoadedState());
      },
    );
    on<SaveChanges>(
      (event, emit) async {
        emit(SettingsLoadingState());
        try {
          if (userImage.isNotEmpty) {
            final String imageUrl = await StorageService().uploadFile(
                image: File(userImage), userId: event.userModel.uid!);
            userModel = event.userModel.copyWith(userImage: imageUrl);
          }else {
            userModel = event.userModel;
          }
          await DataBaseService().updateUserinfo(userModel);
          emit(SettingsLoadedState());
        } catch (e) {
          emit(SettingsErrorState(message: e.toString()));
        }
      },
    );
  }
}
