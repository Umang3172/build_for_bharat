class ProductModel {
  final String title;
  final String price;
  final String description;
  final String productImg;

  ProductModel({
    required this.title,
    required this.price,
    required this.description,
    required this.productImg,
  });

  static final productList = [
    ProductModel(
        title: 'Black tshirt new',
        price: '₹999',
        description:
            'Introducing our sleek and versatile black T-shirt, a wardrobe essential that effortlessly combines style and comfort. Crafted from high-quality cotton, this classic piece boasts a luxuriously soft feel against the skin, ensuring all-day comfort. The deep, rich black hue adds a touch of sophistication, making it the perfect canvas for any outfit.',
        productImg: 'assets/images/tshirt_person_1.jpg'),
    ProductModel(
        title: 'Classic Black Cotton T-Shirt',
        price: '₹1299',
        description:
            'Timeless and comfortable, this classic black T-shirt is made from premium cotton for a soft feel. A versatile wardrobe staple suitable for any occasion.',
        productImg: 'assets/images/tshirt_person_2.webp'),
    ProductModel(
        title: 'Classic Black Cotton T-Shirt',
        price: '₹1299',
        description:
            'Timeless and comfortable, this classic black T-shirt is made from premium cotton for a soft feel. A versatile wardrobe staple suitable for any occasion.',
        productImg: 'assets/images/tshirt_person_3.jpg'),
    ProductModel(
        title: 'Classic Black Cotton T-Shirt',
        price: '₹1299',
        description:
            'Timeless and comfortable, this classic black T-shirt is made from premium cotton for a soft feel. A versatile wardrobe staple suitable for any occasion.',
        productImg: 'assets/images/tshirt_person_4.jpg'),
    ProductModel(
        title: 'Classic Black Cotton T-Shirt',
        price: '₹1299',
        description:
            'Timeless and comfortable, this classic black T-shirt is made from premium cotton for a soft feel. A versatile wardrobe staple suitable for any occasion.',
        productImg: 'assets/images/tshirt_person_2.webp'),
    ProductModel(
        title: 'Classic Black Cotton T-Shirt',
        price: '₹1299',
        description:
            'Timeless and comfortable, this classic black T-shirt is made from premium cotton for a soft feel. A versatile wardrobe staple suitable for any occasion.',
        productImg: 'assets/images/tshirt_person_2.webp'),
  ];
}
