import 'package:flutter/material.dart';

import 'dashbord_widgets/anncouncements_section.dart';
import 'dashbord_widgets/quizes_section.dart';
import 'dashbord_widgets/top_section.dart';

class DashboardTap extends StatelessWidget {
  const DashboardTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: DashboardTopSection()),
        Container(
          height: 10,
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildAnnoncementsAndQuizes(),
            ))
      ],
    );
  }

  Widget _buildAnnoncementsAndQuizes() {
    return Row(
      children: [
        Expanded(flex: 3, child: AnnouncementsSection()),
        const SizedBox(
          width: 10,
        ),
        Expanded(flex: 1, child: QuizzesSection()),
      ],
    );
  }
}
