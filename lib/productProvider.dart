import 'package:build_for_bharat/common/models/tags.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> prod_list = [];
  List<ProductModel> og_prod_list = [];

  void initiateList(List<ProductModel> list) {
    og_prod_list = list;
    prod_list = list;
  }

  void updateList(Tags tags, bool include) {
    if (!include) {
      return;
    }
    print(
        "tags ${tags.category} ${tags.color} ${tags.occasion} ${tags.sizes} ${tags.weather_suitable}");
    prod_list = [];
    for (int i = 0; i < og_prod_list.length; i++) {
      ProductModel curr = og_prod_list[i];
      print(curr.category.trim().toLowerCase() ==
          tags.category.trim().toLowerCase());
      print(tags.weather_suitable.trim().length == 0 ||
          curr.weather_suitable.trim().toLowerCase() ==
              tags.weather_suitable.trim().toLowerCase());
      print(curr.color.trim().toLowerCase() == tags.color.trim().toLowerCase());
      print(curr.occasion.trim().toLowerCase() ==
          tags.occasion.trim().toLowerCase());
      print(
          "curr ${curr.category} ${curr.color} ${curr.occasion} ${curr.sizes} ${curr.weather_suitable}");
      if ((tags.category.length == 0 ||
              (curr.category.trim().toLowerCase() ==
                  tags.category.trim().toLowerCase())) &&
          (tags.color.length == 0 ||
              curr.color.trim().toLowerCase() ==
                  tags.color.trim().toLowerCase()) &&
          (tags.occasion.length == 0 ||
              curr.occasion.trim().toLowerCase() ==
                  tags.occasion.trim().toLowerCase()) &&
          (tags.weather_suitable.length == 0 ||
              curr.weather_suitable.trim().toLowerCase() ==
                  tags.weather_suitable.trim().toLowerCase()) &&
          (tags.brand.length == 0 ||
              curr.brand.trim().toLowerCase() ==
                  tags.brand.trim().toLowerCase())) {
        prod_list.add(curr);
      }
    }

    // &&curr.sizes.contains(tags.sizes.toUpperCase())

    notifyListeners();
  }
}
