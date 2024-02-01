import 'dart:convert';

import 'package:build_for_bharat/common/models/product_model.dart';

class JsonParsing {
  // List<Categories> userList(List<TestItem> list) {
  //   List<Categories> ans = [];
  //   for (int i = 0; i < list.length; i++) {
  //     Categories c = new Categories(name: list[i].category);
  //     if (!ans.contains(c)) {
  //       ans.add(c);
  //     }
  //   }
  //   return ans;
  // }

  List<ProductModel> currList(
      List<ProductModel> list, List<String?> categories) {
    return list
        .where(
            (item) => categories.any((category) => category == item.category))
        .toList();
  }

  List<ProductModel> parseProducts(String jsonString) {
    final List<dynamic> responseBody = jsonDecode(jsonString);
    return responseBody
        .map<ProductModel>(
          (json) => ProductModel.fromJson(json),
        )
        .toList();
  }
}
