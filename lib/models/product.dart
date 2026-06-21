class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id, required this.name, required this.category,
    required this.price, required this.imageUrl, required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? 'Bilinmeyen Ürün',
      category: json['category'] ?? 'Genel',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150',
      description: json['description'] ?? 'Ürün açıklaması bulunmuyor.',
    );
  }
}