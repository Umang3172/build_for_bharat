import 'package:build_for_bharat/common/models/cart.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SingleItemWidget extends StatelessWidget {
  final Cart cartItems;

  const SingleItemWidget({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/tshirt_person_1.jpg',
              fit: BoxFit.cover,
              height: ScreenUtil.sh * 0.25,
              width: ScreenUtil.sw * 0.1,
            ),
          ),
          SizedBox(
            width: Gap.xswg,
          ),
          Text(
            cartItems.title,
            style: Styles.tsw700xs.apply(color: AppColors.primaryTextColor),
          ),
        ],
      ),
    );
  }
}
