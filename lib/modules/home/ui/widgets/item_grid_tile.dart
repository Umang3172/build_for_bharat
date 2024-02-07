import 'dart:js';

import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/modules/home/ui/chatbot_widget.dart';
import 'package:build_for_bharat/modules/products/ui/product_detail_screen.dart';
import 'package:build_for_bharat/openai_service.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/strings.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ItemGridTile extends StatelessWidget {
  // final VoidCallback onTap;

  final ProductModel productDetailModel;

  const ItemGridTile({super.key, required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: ScreenUtil.sh * 0.32,
              width: ScreenUtil.sw * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/tshirt_person_4.jpg'),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accenColor.withOpacity(0.6),
                ),
                child: Icon(
                  Icons.favorite_outline,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accenColor.withOpacity(0.6),
                ),
                child: Icon(
                  Icons.bookmark,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Gap.xxxxshg,
        ),
        Text(
          productDetailModel.title,
          style: Styles.tsw400xxs.apply(color: AppColors.primaryTextColor),
        ),
        Text(
          " ${productDetailModel.price}",
          style: Styles.tsw700xxs.apply(color: AppColors.primaryTextColor),
        )
      ],
    );
  }
}
