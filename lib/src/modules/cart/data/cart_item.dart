// Cart Item Model
class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  @override
  String toString() {
    return '''
      CartItem(
        id: $id,
        name: $name,
        price: $price,
        quantity: $quantity,
        imageUrl: $imageUrl,
      )
    ''';
  }
}
