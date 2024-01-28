import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RightSideAppbarMenu extends StatelessWidget {
  const RightSideAppbarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              Icons.search,
              size: 20,
              color: AppColors.accenColor,
            ),
            const SizedBox(width: 3),
            Text(
              'Search',
              style: Styles.tsw300s,
            ),
            const SizedBox(width: 3),
          ],
        ),
        SizedBox(
          width: Gap.xswg,
        ),
        Row(
          children: [
            const Icon(
              Icons.person_sharp,
              size: 20,
              color: AppColors.accenColor,
            ),
            const SizedBox(width: 3),
            Text(
              'Login',
              style: Styles.tsw300s,
            ),
            const SizedBox(width: 3),
          ],
        )
      ],
    );
  }
}
