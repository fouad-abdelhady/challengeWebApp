import 'package:bloc/bloc.dart';
import 'package:dashboard/data/repos/announcement_repo.dart';
import 'package:meta/meta.dart';

import '../../constatnts/costants.dart';
import '../../constatnts/strings.dart';
import '../../data/models/announcement_model.dart';
import '../../data/services/services_error_codes.dart';

part 'announcement_state.dart';

class AnnouncmentCubit extends Cubit<AnnouncmentState> {
  final AnnouncementRepo _announcementRepo;
  AnnouncmentCubit(this._announcementRepo) : super(AnnouncmentInitial());

  void addAnnouncement({required String announcement}) {
    emit(AddingAnnouncementLoading());
    _announcementRepo.addAnnouncement(announcement).then((value) {
      emit(AddingAnnouncementLoaded(value));
    }).onError((error, stackTrace) {
      emitAddAnnouncementError(error);
    });
  }

  void getAnnouncement(
      {required Map<String, dynamic> page, String? creatorId}) {
    emit(GettingAnnouncementLoading());
    _announcementRepo.getAnnouncement(page, creatorId).then((value) {
      emit(GettingAnnouncementLoaded(value));
    }).onError((error, stackTrace) {
      emitGetAnnouncementError(error);
    });
  }

  void emitGetAnnouncementError(error) {
    if (error is RegularServicesErrors) {
      if (error == RegularServicesErrors.unAuthorized) {
        emit(LoginAgain());
        return;
      }
      emit(GettingAnnouncementError(errorCode: error));
      return;
    } else {
      emit(GettingAnnouncementError(message: Strings().unKnownError));
    }
  }

  void emitAddAnnouncementError(Object? error) {
    if (error is RegularServicesErrors) {
      if (error == RegularServicesErrors.unAuthorized) {
        emit(LoginAgain());
        return;
      }
      emit(AddingAnnouncementError(errorCode: error));
      return;
    } else {
      emit(AddingAnnouncementError(message: Strings().unKnownError));
    }
  }
}
