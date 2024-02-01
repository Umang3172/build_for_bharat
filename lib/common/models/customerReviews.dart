class CustomerReviews {
  final String title;
  final String desc;
  final String rating;

  CustomerReviews(
      {required this.title, required this.desc, required this.rating});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) {
    return CustomerReviews(
      title: json['title'] ?? "",
      desc: json['details'] ?? "",
      rating: json['rating'].toString() ?? "",
    );
  }

  static List<CustomerReviews> fromJsonList(List<dynamic> jsonList) {
    List<CustomerReviews> reviews = [];

    for (var jsonReview in jsonList) {
      reviews.add(
        CustomerReviews.fromJson(jsonReview),
      );
    }

    return reviews;
  }
}
