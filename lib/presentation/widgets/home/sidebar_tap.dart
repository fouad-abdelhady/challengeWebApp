import 'package:dashboard/presentation/widgets/home/sidebar_widget.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';

import '../../../constatnts/colors.dart';
import '../../../constatnts/strings.dart';

class SideBarTap extends StatelessWidget {
  IconData icon;
  SideBarOptions currentTap;
  SideBarOptions selectedTap;
  void Function(SideBarOptions option) onTap;
  SideBarTap(this.icon, this.currentTap, this.selectedTap, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Color backroundColor =
        selectedTap == currentTap ? AppColors.onSecondary : Colors.transparent;
    Color contentColor =
        selectedTap == currentTap ? AppColors.secondary : AppColors.onSecondary;
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          onTap(currentTap);
        },
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          color: backroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: contentColor,
              ),
              Flexible(
                  child: Text(getLable(currentTap))
                      .applyColor(textColor: contentColor))
            ],
          ),
        ),
      ),
    );
  }

  String getLable(SideBarOptions currentTap) {
    switch (currentTap) {
      case SideBarOptions.dashboard:
        return Strings().dashboard;

      case SideBarOptions.schedual:
        return Strings().schedual;

      case SideBarOptions.courses:
        return Strings().courses;

      case SideBarOptions.gradebook:
        return Strings().gradebook;

      case SideBarOptions.performance:
        return Strings().performance;

      case SideBarOptions.announcement:
        return Strings().announcement;

      case SideBarOptions.logOut:
        return Strings().logOut;
    }
  }
}
