import 'dart:core';

import 'package:build_for_bharat/common/models/customerReviews.dart';

class ProductModel {
  final String title;
  final int price;

  final String productImg;
  final String color;
  final String average_review;
  final String occasion;
  final String weather_suitable;
  final String cloth_type;
  final String category;
  final List<CustomerReviews> reviews;
  final String brand;
  final List<String> sizes;

  ProductModel(
      {required this.title,
      required this.price,
      required this.productImg,
      required this.color,
      required this.average_review,
      required this.occasion,
      required this.weather_suitable,
      required this.cloth_type,
      required this.reviews,
      required this.brand,
      required this.sizes,
      required this.category});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: (json.containsKey('name')) ? json['name'] : "null",
      productImg: (json.containsKey('image_url')) ? json['image_url'] : "",
      price: (json.containsKey('price')) ? json['price'] as int : 0,
      brand: (json.containsKey('brand_name')) ? json['brand_name'] : "null",
      color: (json.containsKey('color')) ? json['color'] : "null",
      sizes: (json.containsKey('sizes_available'))
          ? List<String>.from(json['sizes_available'])
          : [],
      reviews: (json.containsKey('customer_reviews'))
          ? CustomerReviews.fromJsonList(json['customer_reviews'])
          : [],
      cloth_type: (json.containsKey('color')) ? json['color'] : "null",
      category: (json.containsKey('color')) ? json['color'] : "null",
      occasion: (json.containsKey('color')) ? json['color'] : "null",
      weather_suitable: (json.containsKey('color')) ? json['color'] : "null",
      average_review: (json.containsKey('color')) ? json['color'] : "null",
    );
  }

  static final productList = [];

  List<String> getSizes(json) {
    return [];
  }

  List<CustomerReviews> getReviews(json) {
    return [];
  }
}
