import 'package:badges/badges.dart';
import 'package:dashboard/bussniessLogic/auth/authentication_cubit.dart';
import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/constatnts/strings.dart';
import 'package:dashboard/data/models/users_models.dart';
import 'package:dashboard/utils/config/responsive.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/circular_image.dart';

class TopBar extends StatelessWidget with Responsive {
  TopBar({
    Key? key,
  }) : super(key: key);
  LoginResponseModel? _loginResponseModel;
  BuildContext? _context;
  final _borderRadius = 30.0;
  @override
  Widget build(BuildContext context) {
    _loginResponseModel = _loginResponseModel ??
        BlocProvider.of<AuthenticationCubit>(context).currentUser;
    _context = _context ?? context;
    return Row(
      children: [
        Expanded(
            child: Padding(
                padding: EdgeInsetsDirectional.only(start: 20),
                child: _buildWelcome())),
        Expanded(child: _buildRightSide(context))
      ],
    );
  }

  Widget _buildRightSide(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSearchField(context),
        const SizedBox(
          width: 10,
        ),
        _buildIconWithBadge(Icons.notifications, "1"),
        const SizedBox(
          width: 10,
        ),
        _buildIconWithBadge(Icons.email, "3"),
        const SizedBox(
          width: 20,
        ),
        _buildProfileImage(),
      ],
    );
  }

  Expanded _buildSearchField(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsetsDirectional.only(start: 20),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.onPrimary),
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            child: TextFormField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                icon: const Icon(Icons.search),
                labelStyle: TextStyle(
                    fontSize: textScalleFactor(context, 15),
                    fontWeight: FontWeight.bold),
                label: Text(Strings().search),
              ),
              maxLines: 1,
            ),
          ),
        ));
  }

  Widget _buildWelcome() {
    // print(_loginResponseModel!.student!.toJson());
    var name = "";
    if (_loginResponseModel!.role == "1") {
      name =
          "${_loginResponseModel!.instructor!.title} ${_loginResponseModel!.instructor!.firstName}";
    } else {
      name = "${_loginResponseModel!.student!.name}";
    }
    return Text(Strings().getWellcome(name)).largeHeadline2(_context!);
  }

  Widget _buildIconWithBadge(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 20,
        child: Badge(
          position: const BadgePosition(start: 20, top: 0),
          badgeContent:
              Text(value).applyColor(textColor: AppColors.onSecondary),
          badgeColor: AppColors.secondary,
          child: Icon(
            icon,
            color: AppColors.gradientColorDark,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    var profileImage = "";
    if (_loginResponseModel!.role == "1") {
      profileImage = _loginResponseModel!.instructor!.profileImage ?? " ";
    } else {
      profileImage = _loginResponseModel!.student!.profileImage ?? " ";
    }
    return CircularImage(profileImage: profileImage, diamention: 50);
  }
}
