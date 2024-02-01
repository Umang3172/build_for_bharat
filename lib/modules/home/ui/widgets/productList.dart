import 'package:build_for_bharat/modules/products/ui/product_detail_screen.dart';
import 'package:build_for_bharat/utils/json_parsing.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/item_grid_tile.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList(
      {super.key,
      required this.products,
      required this.list_of_categories,
      required this.selectedUserList});

  final List<ProductModel> products;
  final List<String> list_of_categories;
  final List<String> selectedUserList;

  @override
  _MyProductList createState() => _MyProductList();
}

class _MyProductList extends State<ProductList> {
  List<String>? selectedUserList = [];
  bool isFirst = true;

  // Future<void> _openFilterDialog(List<String> userList) async {
  //   selectedUserList = selectedUserList = List.from(widget.selectedUserList);
  //   isFirst = false;
  //   ;
  //   await FilterListDialog.display<Categories>(
  //     context as BuildContext,
  //     hideSelectedTextCount: true,
  //     themeData: FilterListThemeData(context as BuildContext),
  //     headlineText: 'Select Users',
  //     height: 500,
  //     listData: userList,
  //     selectedListData: selectedUserList,
  //     choiceChipLabel: (item) => item!.name,
  //     validateSelectedItem: (list, val) => list!.contains(val),
  //     controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
  //     onItemSearch: (user, query) {
  //       return user.name!.toLowerCase().contains(query.toLowerCase());
  //     },
  //     onApplyButtonClick: (list) {
  //       setState(() {
  //         selectedUserList = List.from(list!);
  //       });
  //       Navigator.pop(context as BuildContext);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    JsonParsing jsonParsing = JsonParsing();
    if (isFirst) {
      selectedUserList = widget.list_of_categories;
    }
    List<ProductModel> curr_list = widget.products;
    // jsonParsing.currList(widget.products, selectedUserList!);

    return SingleChildScrollView(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: curr_list.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: ScreenUtil.sh * 0.03,
              mainAxisSpacing: ScreenUtil.sh * 0.04,
              childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productModel: curr_list[index],
                        ),
                      ),
                    ),
                child: ItemGridTile(productDetailModel: curr_list[index]));
          }),
    );
  }

  List<String>? getInitialList() {
    return widget.selectedUserList;
  }
}
