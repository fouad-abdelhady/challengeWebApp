import 'package:dashboard/bussniessLogic/auth/authentication_cubit.dart';
import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/data/local.dart';
import 'package:dashboard/data/services/services.dart';
import 'package:dashboard/presentation/screens/dashboard_screen.dart';
import 'package:dashboard/presentation/widgets/common/common_text_field.dart';
import 'package:dashboard/utils/config/indicators.dart';
import 'package:dashboard/utils/config/responsive.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/locale.dart';

import '../../constatnts/strings.dart';
import '../widgets/common/responsive_container.dart';

class AuthenticationPage extends StatefulWidget {
  static const PAGE_ROUTE = "/authentication";

  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with Responsive, Indicators {
  final _boderRadius = 20.0;
  final _formKey = new GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? errorMessage;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chekIfLoggedIn();
  }

  _chekIfLoggedIn() async {
    Services().token = await LocalData().isUserLogeIn();
    BlocProvider.of<AuthenticationCubit>(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveContainer(
        body: Center(
            child: Container(
          width: screenWidth(context) * 0.4,
          height: screenWidth(context) * 0.3,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: _buildDecoration(),
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
            listenWhen: (previous, current) => current is UserDataLoaded,
            listener: (context, state) {
              showSnacBarWithMessage(
                  context: context,
                  message:
                      "current user role is ${BlocProvider.of<AuthenticationCubit>(context).currentUser!.role}");
              Navigator.of(context).pushReplacementNamed(Dashboard.PAGE_ROUTE);
            },
            buildWhen: (previous, current) =>
                current is UserDataError ||
                current is UserDataLoading ||
                current is LoginError,
            builder: (context, state) {
              if (state is UserDataError) {
                return _buildRefreshBody();
              }
              if (state is UserDataLoading) {
                return getLoadingIndicator();
              }
              return _buildLoginSection();
            },
          ),
        )),
      ),
    );
  }

  Form _buildLoginSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(flex: 2, child: _buildTitle()),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: CommonTextField(
                        _userNameController, Strings().userName)),
                const SizedBox(height: 10),
                Flexible(
                    child: CommonTextField(
                  _passwordController,
                  Strings().password,
                  isObsecure: true,
                )),
                const SizedBox(height: 15),
              ],
            ),
          ),
          _buildLoginButtonSection()
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
        color: AppColors.containersColors,
        borderRadius: BorderRadius.all(Radius.circular(_boderRadius)),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowColor, blurRadius: 4, offset: Offset(0, 3))
        ]);
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(Strings().appName).largeHeadline(context),
    );
  }

  Widget _buildLoginButton() {
    return InkWell(
      onTap: _logUserIn,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_boderRadius)),
            color: AppColors.secondary),
        child: Text(Strings().login)
            .applyColor(textColor: AppColors.buttonLableColor),
      ),
    );
  }

  Widget _buildLoginButtonSection() {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listenWhen: (previous, current) => _getStates(current),
      listener: (context, state) {
        if (state is LoginError && state.errorMessage != "") {
          showSnacBarWithMessage(context: context, message: state.errorMessage);
        }
        if (state is LoginLoaded) {
          Navigator.of(context).pushReplacementNamed(Dashboard.PAGE_ROUTE);
        }
      },
      buildWhen: (previous, current) => _getStates(current),
      builder: (context, state) {
        if (state is LoginLoading) {
          return getLoadingIndicator();
        } else {
          return _buildLoginButton();
        }
      },
    );
  }

  bool _getStates(AuthenticationState current) {
    return current is LoginLoading ||
        current is LoginLoaded ||
        current is LoginError;
  }

  void _logUserIn() {
    if (!_formKey.currentState!.validate()) return;
    BlocProvider.of<AuthenticationCubit>(context).login(
        userName: _userNameController.text, password: _passwordController.text);
  }

  Widget _buildRefreshBody() {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              _chekIfLoggedIn();
            },
            icon: const Icon(
              Icons.refresh,
              color: AppColors.secondary,
            )),
        const SizedBox(
          height: 30,
        ),
        IconButton(
            onPressed: () async {
              await LocalData().deleteToken();
              setState(() {});
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }
}
