import 'package:build_for_bharat/basic_layout_widget.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/common/widgets/common_app_bar.dart';
import 'package:build_for_bharat/modules/home/ui/chatbot_widget.dart';
import 'package:build_for_bharat/modules/products/ui/widgets/product_detail_widget.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BasicLayoutWidget(
        leftWidget: SingleChildScrollView(
          child: Column(
            children: [
              CommonAppBar(),
              SizedBox(
                height: Gap.xxxxshg,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.productModel.category,
                          style: Styles.tsw400xxs
                              .apply(color: AppColors.primaryTextColor),
                        ),
                        SizedBox(
                          width: Gap.xxswg,
                        ),
                        Container(
                          width: 2,
                          height: 2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryTextColor),
                        ),
                        SizedBox(
                          width: Gap.xxswg,
                        ),
                        Text(
                          widget.productModel.brand,
                          style: Styles.tsw400xxs
                              .apply(color: AppColors.primaryTextColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Gap.xxshg,
                    ),
                    ProductDetailWidget(productModel: widget.productModel)
                  ],
                ),
              )
            ],
          ),
        ),
        rightWidget: const ChatPage());
  }
}
