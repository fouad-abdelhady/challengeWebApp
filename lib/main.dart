import 'package:dashboard/bussniessLogic/auth/authentication_cubit.dart';
import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/data/local.dart';
import 'package:dashboard/data/repos/authentication_repo.dart';
import 'package:dashboard/data/services/services.dart';
import 'package:dashboard/presentation/screens/auth_screen.dart';
import 'package:dashboard/utils/config/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await LocalData().init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationRepo _authenticationRepo = AuthenticationRepo();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (context) => AuthenticationCubit(_authenticationRepo),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.onPrimary,
              secondary: AppColors.secondary,
              onSecondary: AppColors.onSecondary,
            ),
            fontFamily: 'Lato'),
        //   home: const AuthenticationPage(),
        onGenerateRoute: (settings) =>
            ScreensRouter().onGenerateRoute(settings: settings),
      ),
    );
  }
}
