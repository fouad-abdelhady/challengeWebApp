import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  Widget body;
  ResponsiveContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        if (p1.maxWidth < 790) {
          return Container(
            color: AppColors.containersColors,
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            child:
                Center(child: Text("comming soon :(").largeHeadline(context)),
          );
        } else {
          return body;
        }
      },
    );
  }
}
