import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/features/auth/presentattion/bloc/auth_bloc.dart';
import 'package:message_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:message_app/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:message_app/features/settings/presentation/bloc/settings/settings_bloc.dart';
import 'package:message_app/logic/auth_service.dart';
import 'package:message_app/logic/database_service.dart';
import 'package:message_app/logic/storage_service.dart';

import 'core/netwok/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features Sign In BLoc

  //!Bloc
  sl.registerFactory(() => AuthBloc(authService: sl(), imagePicker: sl()));

  sl.registerFactory(() => HomeBloc(dataBaseService: sl()));

  sl.registerFactory(() => ChatBloc(dataBaseService: sl()));

  sl.registerFactory(() => SettingsBloc(dataBaseService: sl(), imagePicker: sl() ,storageService: sl()));

  //----Auth Events
  sl.registerLazySingleton(
      () => RegisterUserEvent(context: sl(), userRegisterModel: sl()));
  sl.registerLazySingleton(
      () => LoginUserEvent(userRegisterModel: sl(), context: sl()));
  sl.registerLazySingleton(() => LogOutEvent(context: sl()));
  sl.registerLazySingleton(() => UploadImageEvent());

  //----Home Events
  sl.registerLazySingleton(() => GetGroupListEvent());
  sl.registerLazySingleton(
      () => CreateGroupEvent(groupName: sl(), userName: sl()));
  sl.registerLazySingleton(() => SearchGroupByName(name: sl()));
  sl.registerLazySingleton(() => ToggleGroupEvent(searchGroupModel: sl()));

  //----Settings Events
  sl.registerLazySingleton(() => GetUserInfoEvent());
  sl.registerLazySingleton(() => UpdateImageEvent());
  sl.registerLazySingleton(() => SaveChanges(userModel: sl()));


  //! 

  sl.registerLazySingleton<DataBaseService>(() => DataBaseService(uid: sl()));
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<StorageService>(() => StorageService());

  

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(interConnection: sl()));

  //!Extarnal
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance.currentUser!.uid);
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());

}
