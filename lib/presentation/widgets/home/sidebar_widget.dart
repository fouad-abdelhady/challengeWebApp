import 'package:dashboard/data/local.dart';
import 'package:dashboard/presentation/screens/auth_screen.dart';
import 'package:dashboard/presentation/widgets/home/sidebar_tap.dart';
import 'package:dashboard/utils/config/responsive.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constatnts/colors.dart';
import '../../../constatnts/strings.dart';

enum SideBarOptions {
  dashboard,
  schedual,
  courses,
  gradebook,
  performance,
  announcement,
  logOut
}

class SideBar extends StatefulWidget {
  void Function(SideBarOptions tap) updateSelectedTap;
  SideBarOptions selectedTap;
  SideBar(this.selectedTap, this.updateSelectedTap, {super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with Responsive {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        AppColors.gradientColorDark,
        AppColors.gradientColorLight
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        children: [
          _buildTitle(),
          SideBarTap(Icons.home_rounded, SideBarOptions.dashboard,
              widget.selectedTap, widget.updateSelectedTap),
          SideBarTap(Icons.calendar_month, SideBarOptions.schedual,
              widget.selectedTap, widget.updateSelectedTap),
          SideBarTap(Icons.book, SideBarOptions.courses, widget.selectedTap,
              widget.updateSelectedTap),
          SideBarTap(Icons.grade_rounded, SideBarOptions.gradebook,
              widget.selectedTap, widget.updateSelectedTap),
          SideBarTap(Icons.auto_graph_rounded, SideBarOptions.performance,
              widget.selectedTap, widget.updateSelectedTap),
          SideBarTap(Icons.mic, SideBarOptions.announcement, widget.selectedTap,
              widget.updateSelectedTap),
          SideBarTap(Icons.logout, SideBarOptions.logOut, widget.selectedTap,
              (SideBarOptions option) async {
            await LocalData().deleteToken();
            Navigator.of(context)
                .pushReplacementNamed(AuthenticationPage.PAGE_ROUTE);
          })
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(Strings().appName)
            .largeHeadline(context, textColor: AppColors.onSecondary),
      ),
    );
  }
}
