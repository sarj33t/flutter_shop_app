/// [Product]
class Product {
  int? id;
  String? title;
  String? image;
  double? price;
  String? description;
  String? brand;
  String? model;
  String? color;
  String? category;
  double? discount;
  bool? popular;
  bool? onSale;

  Product(
      {this.id,
      this.title,
      this.image,
      this.price,
      this.description,
      this.brand,
      this.model,
      this.color,
      this.category,
      this.discount,
      this.popular,
      this.onSale});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'] is int
        ? (json['price'] as int).toDouble()
        : json['price'];
    description = json['description'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    category = json['category'];
    discount = json['discount'] is int
        ? (json['discount'] as int).toDouble()
        : json['discount'];
    popular = json['popular'];
    onSale = json['onSale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['description'] = description;
    data['brand'] = brand;
    data['model'] = model;
    data['color'] = color;
    data['category'] = category;
    data['discount'] = discount;
    data['popular'] = popular;
    data['onSale'] = onSale;
    return data;
  }
}
