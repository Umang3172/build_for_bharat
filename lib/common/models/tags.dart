import 'package:build_for_bharat/common/models/Cart.dart';
import 'package:flutter/material.dart';

class Tags {
  final String category;
  final String weather_suitable;
  final String occasion;
  final String color;
  final String sizes;
  final String brand;
  final List<Cart> cart;

  Tags(
      {required this.category,
      required this.occasion,
      required this.sizes,
      required this.weather_suitable,
      required this.cart,
      required this.color,
      required this.brand});

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
        category: json['category'] ?? '',
        occasion: json['occasion'] ?? '',
        sizes: json['size'] ?? '',
        weather_suitable: json['weather_suitable'] ?? '',
        color: json['color'] ?? '',
        cart: List<Cart>.from(
            (json['cart'] ?? []).map((item) => Cart.fromJson(item))),
        brand: json['brand'] ?? '');
  }
}
