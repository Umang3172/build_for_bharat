import 'package:build_for_bharat/common/models/jsonParsing.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/item_grid_tile.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  _MyProductList createState() => _MyProductList();
}

class _MyProductList extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    JsonParsing jsonParsing = JsonParsing();

    List<ProductModel> curr_list = [];
    // jsonParsing.currList(widget.products, selectedUserList!);

    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      curr_list = productProvider.prod_list;
      return SingleChildScrollView(
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: curr_list.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: ScreenUtil.sh * 0.01,
                  mainAxisSpacing: ScreenUtil.sh * 0.04,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return ItemGridTile(productDetailModel: curr_list[index]);
              }));
    });
  }
}