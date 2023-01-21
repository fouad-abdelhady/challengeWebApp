import 'package:dashboard/data/models/announcement_model.dart';
import 'package:dashboard/presentation/screens/dashboard_screen.dart';

class Strings {
  static Strings _strings = Strings._internal();

  factory Strings() => _strings;
  Strings._internal();

  final unAuthorized = "UnAuthorized";

  final requestError = "Request Error";

  final noConnection = "No Internet Connection";

  final unKnownError = "UnKnown Error Occured";

  final connectTimeOut = "Connection Timeout";

  final receiveTimeout = "Response Timeout";

  final loginError = "Wrong user name or password";

  final gettingUserDataError = "Something went wrong while getting you data";

  final emptyTextField = "Required Field";

  final appName = "Coligo";

  final userName = "User Name";

  final password = "Password";

  final login = "LOGIN";
  final dashboard = "Dashboard";
  final schedual = "Schedual";
  final courses = "Courses";
  final gradebook = "Gradebook";
  final performance = "Performance";
  final announcement = "Announcements";
  final search = "Search";
  final dashboardTopBarTitle = "EXAMS TIME";
  final dashboardSubText =
      "Here we are, Are you ready to fight? Don't worry, we prepared some tipsto be ready for your exams";
  final dashboardSubtext1 =
      "\" Nothing happens until something moves\". Albert Einstein";
  final viewExamsTips = "View exams tips";
  final whatsDue = "What's due";
  final logOut = "Logout";
  final all = "All";
  String getWellcome(String name) => "Welcome $name,";
}
