class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;
  final String prodId;

  CartItem({
    required this.prodId,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}
