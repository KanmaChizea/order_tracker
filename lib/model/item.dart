class Item {
  Item({
    required this.id,
    required this.quantity,
    required this.price,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  final String id;
  final int quantity;
  final double price;
  final String name;
  final String description;
  final String imagePath;
}
