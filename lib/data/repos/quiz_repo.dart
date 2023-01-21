import '../services/services.dart';

import '../models/quiz_models.dart';

class QuizRepo {
  final _addQuizRoute = "addQuiz";
  final _updateQuizRoute = "updateQuiz";
  final _deleteQuizRoute = "deleteQuiz";
  final _getQuizzesRoute = "quizes";
  final _services = Services();

  Future<Quiz> addQuiz(Map<String, dynamic> newQuiz) async {
    var response =
        await _services.postRequest(route: _addQuizRoute, body: newQuiz);
    return Quiz.fromJson(response.data);
  }

  Future<List<Quiz>> getQuizzes(String? classId) async {
    Map<String, dynamic> body = {};
    if (classId != null) {
      body['classId'] = classId;
    }
    var response =
        await _services.postRequest(route: _getQuizzesRoute, body: body);
    List<Quiz> quizzes = [];
    for (var quiz in response.data) {
      quizzes.add(Quiz.fromJson(quiz));
    }
    return quizzes;
  }
}
