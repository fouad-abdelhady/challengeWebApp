import 'package:bloc/bloc.dart';
import 'package:dashboard/data/local.dart';
import 'package:dashboard/data/models/users_models.dart';
import 'package:dashboard/data/repos/authentication_repo.dart';
import 'package:dashboard/data/services/services.dart';
import 'package:meta/meta.dart';

import '../../constatnts/costants.dart';
import '../../constatnts/strings.dart';
import '../../data/services/services_error_codes.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationRepo _authenticationRepo;
  LoginResponseModel? currentUser;
  AuthenticationCubit(this._authenticationRepo)
      : super(AuthenticationInitial());

  void login({required String userName, required String password}) {
    emit(LoginLoading());
    _authenticationRepo.login(userName, password).then((responsModel) {
      currentUser = responsModel;
      emit(LoginLoaded(responsModel));
    }).onError((error, stackTrace) {
      emitLoginError(error);
    });
  }

  void emitLoginError(Object? error) {
    if (error is RegularServicesErrors) {
      if (error == RegularServicesErrors.notFound ||
          error == RegularServicesErrors.unAuthorized) {
        emit(LoginError(message: Strings().loginError));
        return;
      }
      emit(LoginError(errorCode: error));
    } else {
      emit(LoginError(message: Strings().unKnownError));
    }
  }

  void getUserData() {
    if (Services().token == null) {
      emit(LoginError(message: ""));
      return;
    }
    emit(UserDataLoading());
    _authenticationRepo.getUserData().then((value) {
      currentUser = value;
      emit(UserDataLoaded());
    }).onError((error, stackTrace) {
      emitUserDataError(error);
    });
  }

  void emitUserDataError(Object? error) {
    if (error is RegularServicesErrors) {
      if (error == RegularServicesErrors.unAuthorized) {
        emit(LoginError(message: Strings().gettingUserDataError));
        return;
      }
      emit(UserDataError(errorCode: error));
    } else {
      emit(UserDataError(message: Strings().unKnownError));
    }
  }
}
