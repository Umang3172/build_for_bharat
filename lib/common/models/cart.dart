class Cart {
  final String title;
  final int count;
  final int total_price;

  Cart({
    required this.title,
    required this.count,
    required this.total_price,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      title: json['product_name'] ?? '',
      count: json['quantity'] as int? ?? 0,
      total_price: json['total_cost'] as int? ?? 0,
    );
  }
}
