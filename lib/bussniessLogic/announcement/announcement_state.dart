part of 'announcement_cubit.dart';

@immutable
abstract class AnnouncmentState {}

class AnnouncmentInitial extends AnnouncmentState {}

class AddingAnnouncementLoading extends AnnouncmentState {
  AddingAnnouncementLoading();
}

class AddingAnnouncementLoaded extends AnnouncmentState {
  final Announcement announcement;
  AddingAnnouncementLoaded(this.announcement);
}

class AddingAnnouncementError extends AnnouncmentState with ServiceErrors {
  late String errorMessage;
  AddingAnnouncementError({RegularServicesErrors? errorCode, String? message}) {
    if (errorCode != null) {
      errorMessage = getRegularServicesError(errorCode);
    } else {
      errorMessage = message ?? Strings().unKnownError;
    }
  }
}

///**************get announcements states************ */

class GettingAnnouncementLoading extends AnnouncmentState {
  GettingAnnouncementLoading();
}

class GettingAnnouncementLoaded extends AnnouncmentState {
  final AnnouncementResponseModel responseModel;
  GettingAnnouncementLoaded(this.responseModel);
}

class GettingAnnouncementError extends AnnouncmentState with ServiceErrors {
  late String errorMessage;
  GettingAnnouncementError(
      {RegularServicesErrors? errorCode, String? message}) {
    if (errorCode != null) {
      errorMessage = getRegularServicesError(errorCode);
    } else {
      errorMessage = message ?? Strings().unKnownError;
    }
  }
}

class LoginAgain extends AnnouncmentState {
  LoginAgain();
}
