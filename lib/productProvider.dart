import 'package:build_for_bharat/common/models/tags.dart';
import 'package:build_for_bharat/common/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:build_for_bharat/openai_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> prod_list = [];
  List<ProductModel> og_prod_list = [];
  List<types.Message> messages = [];
  bool isListening = false;
  OpenAIService openAiService = OpenAIService();
  Tags tags = Tags(
      cart: [],
      category: '',
      color: '',
      sizes: '',
      weather_suitable: '',
      occasion: '',
      brand: '');

  void initiateList(List<ProductModel> list) {
    og_prod_list = list;
    prod_list = list;
  }

  void alterMessages() {
    notifyListeners();
  }

  void updateList(Tags tags1, bool include) {
    if (!include) {
      return;
    }
    this.tags = tags1;
    print(
        "tags ${tags1.category} ${tags1.color} ${tags1.occasion} ${tags1.sizes} ${tags1.weather_suitable}");
    prod_list = [];
    for (int i = 0; i < og_prod_list.length; i++) {
      ProductModel curr = og_prod_list[i];
      // print(curr.category.trim().toLowerCase() ==
      //     tags.category.trim().toLowerCase());
      // print(tags.weather_suitable.trim().length == 0 ||
      //     curr.weather_suitable.trim().toLowerCase() ==
      //         tags.weather_suitable.trim().toLowerCase());
      // print(curr.color.trim().toLowerCase() == tags.color.trim().toLowerCase());
      // print(curr.occasion.trim().toLowerCase() ==
      //     tags.occasion.trim().toLowerCase());
      // print(
      // "curr ${curr.category} ${curr.color} ${curr.occasion} ${curr.sizes} ${curr.weather_suitable}");
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

    print(tags.cart.length);

    // &&curr.sizes.contains(tags.sizes.toUpperCase())

    notifyListeners();
  }
}
