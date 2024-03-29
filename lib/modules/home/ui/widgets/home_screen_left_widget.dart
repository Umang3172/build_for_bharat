import 'dart:convert';

import 'package:build_for_bharat/utils/json_parsing.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/common/models/tags.dart';
import 'package:build_for_bharat/common/widgets/common_app_bar.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/expanded_categories_widget.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/item_grid_tile.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/productList.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/right_side_appbar_menu.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/modules/products/ui/product_detail_screen.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreenLeftWidget extends StatefulWidget {
  const HomeScreenLeftWidget({super.key});

  @override
  State<HomeScreenLeftWidget> createState() => _HomeScreenLeftWidgetState();
}

class _HomeScreenLeftWidgetState extends State<HomeScreenLeftWidget> {
  @override
  Widget build(BuildContext context) {
    JsonParsing jsonParsing = JsonParsing();

    return SingleChildScrollView(
        child: Column(
      children: [
        const HeaderStackWidget(),
        SizedBox(
          height: Gap.xxshg,
        ),
        Text('New Arrivals', style: Styles.ts500l),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Our new arrivals are built to withstand your activities while keeping you looking your best!',
          style: Styles.tsw300s.apply(color: AppColors.secondaryTextColor),
        ),
        SizedBox(
          height: Gap.xxxshg,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder<String>(
            future: _loadJsonFile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error loading data: ${snapshot.error}"),
                  );
                }
                print("calling parse method");
                List<ProductModel> list =
                    jsonParsing.parseProducts(snapshot.data!);

                print(list.length);

                print(
                    "${list[0].category} ${list[0].color} ${list[0].weather_suitable} ${list[0].occasion} ${list[0].sizes}");

                Provider.of<ProductProvider>(context, listen: false)
                    .initiateList(list);

                return ProductList(
                  products: list,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    ));
  }

  Future<String> _loadJsonFile() async {
    try {
      return await rootBundle.loadString('products.json');
    } catch (e) {
      print("Error loading JSON file: $e");
      return "";
    }
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
              image: AssetImage('images/header_bg_girl.jpg'),
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
                  style: Styles.tsw300s,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

// GridView.builder(
//               shrinkWrap: true,
//               itemCount: ProductModel.productList.length,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: ScreenUtil.sh * 0.03,
//                   mainAxisSpacing: ScreenUtil.sh * 0.04,
//                   childAspectRatio: 0.8),
//               itemBuilder: (context, index) {
//                 return ItemGridTile(
//                     productDetailModel: ProductModel.productList[index]);
//               }),
