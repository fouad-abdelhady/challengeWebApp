import 'package:dashboard/bussniessLogic/auth/authentication_cubit.dart';
import 'package:dashboard/bussniessLogic/quiz/quiz_cubit.dart';
import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/data/models/users_models.dart';
import 'package:dashboard/utils/config/indicators.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../constatnts/strings.dart';
import '../../../../../data/local.dart';
import '../../../../../data/models/quiz_models.dart';

class QuizzesSection extends StatefulWidget {
  QuizzesSection({super.key});

  @override
  State<QuizzesSection> createState() => _QuizzesSectionState();
}

class _QuizzesSectionState extends State<QuizzesSection> with Indicators {
  List<Quiz> quizzes = [];
  String? _userRole;
  String? _classId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userRole = BlocProvider.of<AuthenticationCubit>(context).currentUser!.role;
    if (_userRole == "2") {
      _classId = BlocProvider.of<AuthenticationCubit>(context)
          .currentUser!
          .student!
          .classId;
    }
    _getQuizes();
  }

  void _getQuizes() {
    BlocProvider.of<QuizCubit>(context).getQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.containersColors,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          _buildTopBar(),
          const Text("The Quizes are ordered acording to creation date"),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _buildBody())
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<QuizCubit, QuizState>(
      listenWhen: (previous, current) => current is LoginAgain,
      buildWhen: (previous, current) =>
          current is GettingQuizError ||
          current is GettingQuizLoaded ||
          current is GettingQuizLoading,
      builder: (context, state) {
        if (state is GettingQuizLoading) {
          return Center(child: getLoadingIndicator());
        }
        if (state is GettingQuizError) {
          return _buildErrorBody(state);
        }
        if (state is GettingQuizLoaded) {
          quizzes = state.quizzes;
        }
        return _buildQuizes();
      },
      listener: (context, state) {
        if (state is LoginAgain) {
          LocalData().deleteToken();
          /*Navigator.pushReplacementNamed(
              context, AuthenticationPage.PAGE_ROUTE);*/
        }
      },
    );
  }

  ListView _buildQuizes() {
    return ListView.builder(
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return index == quizzes.length - 1
            ? QuizItem(quizzes[index])
            : Column(
                children: [
                  QuizItem(quizzes[index]),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider()
                ],
              );
      },
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(Strings().whatsDue).applyBold(context),
          ),
          Text(Strings().all).applyBold(context, textColor: AppColors.secondary)
        ],
      ),
    );
  }

  Center _buildErrorBody(GettingQuizError state) {
    return Center(
      child: Column(
        children: [
          Text(state.errorMessage),
          SizedBox(height: 10),
          IconButton(onPressed: _getQuizes, icon: Icon(Icons.refresh))
        ],
      ),
    );
  }
}

class QuizItem extends StatelessWidget {
  final Quiz _quiz;
  QuizItem(this._quiz);
  BuildContext? _context;
  String formattedDate = "";
  @override
  Widget build(BuildContext context) {
    _setFormattedDate();
    _context = context;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          _buildTopPart(context),
          _buildQuizDetail("Course", _quiz.course),
          _buildQuizDetail("Topic", _quiz.topic),
          _buildQuizDetail("Due to", formattedDate),
          const SizedBox(
            height: 10,
          ),
          _buildStartQuiz()
        ],
      ),
    );
  }

  Widget _buildQuizDetail(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$title :   ").applyColor(textColor: AppColors.grayColor),
          Expanded(
              child:
                  Text(value ?? "").applyColor(textColor: AppColors.grayColor))
        ],
      ),
    );
  }

  Widget _buildTopPart(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.timer_rounded,
          color: AppColors.secondary,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: Text(_quiz.quizTitle ?? "").applyBold(context))
      ],
    );
  }

  Widget _buildStartQuiz() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text("Start Quiz")
          .applyBold(_context!, textColor: AppColors.secondary),
    );
  }

  void _setFormattedDate() {
    var dateText = _quiz.dueDate ?? "2023-07-12T00:00:00:000Z";
    var parsedDate = DateTime.parse(dateText);
    final DateFormat formatter = DateFormat('dd MMM yyyy -').add_jm();
    formattedDate = formatter.format(parsedDate);
  }
}
