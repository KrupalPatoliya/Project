class Product {
  int id;
  String name;
  double price;
  String image;
  int quantity;
  bool isLike;
  double price2;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.isLike,
    required this.price2,
  });

  factory Product.fromMap({required Map data}) {
    return Product(
      id: data["id"],
      name: data["name"],
      price: data["price"],
      image: data["image"],
      quantity: data["quantity"],
      price2: data["price2"],
      isLike: data["isLike"],
    );
  }
}
