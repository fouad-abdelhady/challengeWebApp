import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/presentation/widgets/common/responsive_container.dart';
import 'package:dashboard/presentation/widgets/home/sidebar_widget.dart';
import 'package:dashboard/presentation/widgets/home/taps/dashboard_tap.dart';
import 'package:dashboard/presentation/widgets/home/taps/defalut_tap.dart';
import 'package:dashboard/utils/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/home/top_bar.dart';

class Dashboard extends StatefulWidget {
  static const PAGE_ROUTE = "/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with Responsive {
  late SideBarOptions selectedTap;
  @override
  void initState() {
    selectedTap = SideBarOptions.dashboard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: ResponsiveContainer(
          body: Container(
            child: Row(
              children: [
                Expanded(
                    flex: 1, child: SideBar(selectedTap, updateSelectedTap)),
                Expanded(flex: 5, child: _buildBody(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: screenHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.onSecondary,
            child: TopBar(),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(bottom: 40),
              child: Builder(builder: (context) {
                return _builTap();
              }),
            ),
          )
        ],
      ),
    );
  }

  void updateSelectedTap(SideBarOptions tap) {
    setState(() {
      selectedTap = tap;
    });
  }

  Widget _builTap() {
    switch (selectedTap) {
      case SideBarOptions.dashboard:
        return DashboardTap();
      default:
        return DefalutTap();
    }
  }
}
