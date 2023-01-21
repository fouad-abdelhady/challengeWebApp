import 'package:dashboard/bussniessLogic/quiz/quiz_cubit.dart';
import 'package:dashboard/data/repos/announcement_repo.dart';
import 'package:dashboard/data/repos/quiz_repo.dart';
import 'package:dashboard/presentation/screens/auth_screen.dart';
import 'package:dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussniessLogic/announcement/announcement_cubit.dart';

class ScreensRouter {
  static final ScreensRouter _router = ScreensRouter._internal();
  factory ScreensRouter() => _router;
  ScreensRouter._internal() {
    _quizRepo = QuizRepo();
    _announcementRepo = AnnouncementRepo();
  }
  late QuizRepo _quizRepo;
  late AnnouncementRepo _announcementRepo;
  MaterialPageRoute onGenerateRoute({required RouteSettings settings}) {
    switch (settings.name) {
      case Dashboard.PAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => QuizCubit(_quizRepo)),
                  BlocProvider(
                    create: (context) => AnnouncmentCubit(_announcementRepo),
                  )
                ], child: const Dashboard()),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => const AuthenticationPage(), settings: settings);
    }
  }
}
