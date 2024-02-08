import 'package:build_for_bharat/modules/home/ui/widgets/expanded_categories_widget.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/right_side_appbar_menu.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.sh * 0.04, horizontal: ScreenUtil.sw * 0.02),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'FashionIsta',
                style: Styles.titleHeaderStyle
                    .apply(color: AppColors.primaryTextColor),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the tap here
                    // Navigator.pushNamed(context, '/cart');
                  },
                  child: badges.Badge(
                    position: badges.BadgePosition.bottomStart(),
                    badgeStyle: badges.BadgeStyle(
                        badgeColor: Color.fromRGBO(22, 194, 213, 1)),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    badgeContent: Text(
                        '${Provider.of<ProductProvider>(context, listen: false).tags.cart.length}'),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'Cart',
                  style:
                      Styles.tsw300m.apply(color: AppColors.primaryTextColor),
                ),
                const SizedBox(width: 3),
              ],
            ),
          ],
        ),
      );
    });
  }
}
