import 'package:build_for_bharat/modules/home/ui/widgets/expanded_categories_widget.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/right_side_appbar_menu.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreenLeftWidget extends StatefulWidget {
  const HomeScreenLeftWidget({super.key});

  @override
  State<HomeScreenLeftWidget> createState() => _HomeScreenLeftWidgetState();
}

class _HomeScreenLeftWidgetState extends State<HomeScreenLeftWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [HeaderStackWidget()],
    );
  }
}

class HeaderStackWidget extends StatelessWidget {
  const HeaderStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: ScreenUtil.sh * 0.6,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/header_bg_girl.jpg'),
            ),
          ),
        ),
        Container(
          color: AppColors.imageLayerColor,
          height: ScreenUtil.sh * 0.6,
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil.sh * 0.04,
                  horizontal: ScreenUtil.sw * 0.02),
              child: Row(
                children: [
                  Text(
                    'FashionIsta',
                    style: Styles.titleHeaderStyle,
                  ),
                  SizedBox(
                    width: ScreenUtil.sw * 0.08,
                  ),
                  const ExpandedCategoriesWdget(),
                  const RightSideAppbarMenu(),
                ],
              ),
            ),
            SizedBox(
              height: Gap.shg,
            ),
            Column(
              children: [
                Text(
                  'FashionIsta Inc.',
                  style: Styles.largeHeaderText,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Your fashion now at the comfort of your home',
                  style: Styles.tsw200m,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
