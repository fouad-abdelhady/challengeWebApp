part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoginLoading extends AuthenticationState {
  LoginLoading();
}

class LoginLoaded extends AuthenticationState {
  final LoginResponseModel responseModel;
  LoginLoaded(this.responseModel);
}

class LoginError extends AuthenticationState with ServiceErrors {
  late String errorMessage;
  LoginError({RegularServicesErrors? errorCode, String? message}) {
    if (errorCode != null) {
      errorMessage = getRegularServicesError(errorCode);
    } else {
      errorMessage = message ?? Strings().unKnownError;
    }
  }
}

///********************user data from token states */
class UserDataLoading extends AuthenticationState {
  UserDataLoading();
}

class UserDataLoaded extends AuthenticationState {
  UserDataLoaded();
}

class UserDataError extends AuthenticationState with ServiceErrors {
  late String errorMessage;
  UserDataError({RegularServicesErrors? errorCode, String? message}) {
    if (errorCode != null) {
      errorMessage = getRegularServicesError(errorCode);
    } else {
      errorMessage = message ?? Strings().unKnownError;
    }
  }
}

class LoginAgainState extends AuthenticationState {
  LoginAgainState();
}
