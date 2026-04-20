class CartItem {
  final int productId;
  final String title;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}
