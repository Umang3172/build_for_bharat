import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class RightSideAppbarMenu extends StatelessWidget {
  const RightSideAppbarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
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
              const SizedBox(width: 3),
              Text(
                'Cart',
                style: Styles.tsw300s,
              ),
              const SizedBox(width: 3),
            ],
          )
        ],
      );
    });
  }
}
