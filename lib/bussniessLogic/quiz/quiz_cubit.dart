import 'package:bloc/bloc.dart';
import 'package:dashboard/data/repos/quiz_repo.dart';
import 'package:meta/meta.dart';

import '../../constatnts/costants.dart';
import '../../constatnts/strings.dart';
import '../../data/models/quiz_models.dart';
import '../../data/services/services_error_codes.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepo _quizRepo;
  QuizCubit(this._quizRepo) : super(QuizInitial());

  void addQuiz({required Map<String, dynamic> newQuiz}) {
    emit(AddingQuizLoading());
    _quizRepo.addQuiz(newQuiz).then((value) {
      emit(AddingQuizLoaded(value));
    }).onError((error, stackTrace) {
      emitAddQuizError(error);
    });
  }

  void getQuizzes({String? classId}) {
    emit(GettingQuizLoading());
    _quizRepo.getQuizzes(classId).then((value) {
      emit(GettingQuizLoaded(value));
    }).onError((error, stackTrace) {
      emitAddQuizError(error);
    });
  }

  void emitGetQuizzesError(Object? error) {
    if (error is RegularServicesErrors) {
      if (error == RegularServicesErrors.unAuthorized) {
        emit(LoginAgain());
        return;
      }
      emit(GettingQuizError(errorCode: error));
    } else {
      emit(GettingQuizError(message: Strings().unKnownError));
    }
  }

  void emitAddQuizError(Object? error) {
    if (error is RegularServicesErrors) {
      if (error == RegularServicesErrors.unAuthorized) {
        emit(LoginAgain());
        return;
      }
      emit(AddingQuizError(errorCode: error));
    } else {
      emit(AddingQuizError(message: Strings().unKnownError));
    }
  }
}
