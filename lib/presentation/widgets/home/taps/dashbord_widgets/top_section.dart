import 'dart:ui';

import 'package:dashboard/constatnts/strings.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';

import '../../../../../constatnts/colors.dart';

class DashboardTopSection extends StatelessWidget {
  DashboardTopSection({super.key});
  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    _context = _context ?? context;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsetsDirectional.only(start: 20),
      decoration: const BoxDecoration(
          color: AppColors.containersColors,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadlineText(),
              _buildSubtitle1Text(),
              const SizedBox(
                height: 10,
              ),
              _buildIdum(),
              const SizedBox(
                height: 10,
              ),
              _buildLoginButton()
            ],
          ),
          //here gose the image
        ],
      ),
    );
  }

  Widget _buildHeadlineText() {
    return Text(Strings().dashboardTopBarTitle)
        .largeHeadline(_context!, textColor: AppColors.secondary);
  }

  Widget _buildSubtitle1Text() {
    return Flexible(
        child: Text(
      Strings().dashboardSubText,
    ));
  }

  Widget _buildIdum() {
    return Text(
      Strings().dashboardSubtext1,
      style: const TextStyle(
          color: AppColors.grayColor, fontStyle: FontStyle.italic),
    );
  }

  Widget _buildLoginButton() {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(_context!).colorScheme.secondary),
        child: Text(
          Strings().viewExamsTips,
          style: const TextStyle(
              color: AppColors.onSecondary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
