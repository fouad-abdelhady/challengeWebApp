part of 'quiz_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class AddingQuizLoading extends QuizState {
  AddingQuizLoading();
}

class AddingQuizLoaded extends QuizState {
  final Quiz quiz;
  AddingQuizLoaded(this.quiz);
}

class AddingQuizError extends QuizState with ServiceErrors {
  late String errorMessage;
  AddingQuizError({RegularServicesErrors? errorCode, String? message}) {
    if (errorCode != null) {
      errorMessage = getRegularServicesError(errorCode);
    } else {
      errorMessage = message ?? Strings().unKnownError;
    }
  }
}

///******************get quizzes states ***************** */

class GettingQuizLoading extends QuizState {
  GettingQuizLoading();
}

class GettingQuizLoaded extends QuizState {
  final List<Quiz> quizzes;
  GettingQuizLoaded(this.quizzes);
}

class GettingQuizError extends QuizState with ServiceErrors {
  late String errorMessage;
  GettingQuizError({RegularServicesErrors? errorCode, String? message}) {
    if (errorCode != null) {
      errorMessage = getRegularServicesError(errorCode);
    } else {
      errorMessage = message ?? Strings().unKnownError;
    }
  }
}

class LoginAgain extends QuizState {
  LoginAgain();
}
