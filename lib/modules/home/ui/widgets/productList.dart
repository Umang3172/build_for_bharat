import 'package:build_for_bharat/common/models/tags.dart';
import 'package:build_for_bharat/modules/products/ui/product_detail_screen.dart';
import 'package:build_for_bharat/utils/json_parsing.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/item_grid_tile.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
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
  final TextEditingController _searchTexteEditingController =
      TextEditingController();
  List<ProductModel> curr_list = [];

  void updateContent(String value) {
    Provider.of<ProductProvider>(context, listen: false).seachUpdate(value);
  }

  @override
  Widget build(BuildContext context) {
    JsonParsing jsonParsing = JsonParsing();

    // jsonParsing.currList(widget.products, selectedUserList!);

    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      curr_list = productProvider.prod_list;
      return SingleChildScrollView(
          child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => {
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateList(
                            Tags(
                                cart: [],
                                category: '',
                                color: '',
                                sizes: '',
                                weather_suitable: '',
                                occasion: '',
                                brand: ''),
                            true),
                  },
                  child: Chip(
                    label: Text('All'),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => {
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateList(
                            Tags(
                                cart: [],
                                category: 'tshirt',
                                color: '',
                                sizes: '',
                                weather_suitable: '',
                                occasion: '',
                                brand: ''),
                            true),
                  },
                  child: Chip(
                    label: Text('Tshirt'),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => {
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateList(
                            Tags(
                                cart: [],
                                category: 'shirt',
                                color: '',
                                sizes: '',
                                weather_suitable: '',
                                occasion: '',
                                brand: ''),
                            true),
                  },
                  child: Chip(
                    label: Text('Shirt'),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => {
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateList(
                            Tags(
                                cart: [],
                                category: 'pant',
                                color: '',
                                sizes: '',
                                weather_suitable: '',
                                occasion: '',
                                brand: ''),
                            true),
                  },
                  child: Chip(
                    label: Text('Pants'),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: ScreenUtil.sw * 0.2,
              height: 50,
              child: TextField(
                controller: _searchTexteEditingController,
                onChanged: (value) => updateContent(value),
                decoration: InputDecoration(
                  hintText: 'Enter your text',
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 25,
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: curr_list.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: ScreenUtil.sh * 0.01,
                mainAxisSpacing: ScreenUtil.sh * 0.04,
                childAspectRatio: 0.8),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productModel: curr_list[index],
                          ),
                        ),
                      )
                          .then((_) {
                        // Code to execute when returning back from ProductDetailScreen
                        Provider.of<ProductProvider>(context, listen: false)
                            .notifyListeners();
                      }),
                  child: ItemGridTile(productDetailModel: curr_list[index]));
            })
      ]));
    });
  }
}
