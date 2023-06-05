import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/constants/app_colors.dart';
import 'features/auth/presentattion/bloc/auth_bloc.dart';
import 'features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'features/home/presentation/bloc/home/home_bloc.dart';
import 'features/settings/presentation/bloc/settings/settings_bloc.dart';

import 'config/constants/constants.dart';
import 'config/routes/routes.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constants.apiKey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId),
    );
  } else {
    await Firebase.initializeApp();
  }
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<HomeBloc>()),
          BlocProvider(create: (context) => sl<SettingsBloc>()),
          BlocProvider(create: (context) => sl<ChatBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Message App',
          theme: ThemeData(
            primaryColor: AppColors.primary400,
            // primarySwatch: MaterialColor(400, AppColors.primaryLight),
          ),
          onGenerateRoute: (settings) => Routes.generateRoute(settings),
        ),
      ),
    );
  }
}
