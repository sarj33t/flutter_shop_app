import 'package:flutter_shop_app/src/modules/product/data/product.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [ProductDetailsResponse]
///
class ProductDetailsResponse {
  String? status;
  String? message;
  Product? product;

  ProductDetailsResponse({this.status, this.message, this.product});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

// class ProductDetails {
//   int? id;
//   String? title;
//   String? image;
//   int? price;
//   String? description;
//   String? brand;
//   String? model;
//   String? color;
//   String? category;
//   bool? popular;
//   int? discount;
//
//   ProductDetails(
//       {this.id,
//         this.title,
//         this.image,
//         this.price,
//         this.description,
//         this.brand,
//         this.model,
//         this.color,
//         this.category,
//         this.popular,
//         this.discount});
//
//   ProductDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     image = json['image'];
//     price = json['price'];
//     description = json['description'];
//     brand = json['brand'];
//     model = json['model'];
//     color = json['color'];
//     category = json['category'];
//     popular = json['popular'];
//     discount = json['discount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['image'] = image;
//     data['price'] = price;
//     data['description'] = description;
//     data['brand'] = brand;
//     data['model'] = model;
//     data['color'] = color;
//     data['category'] = category;
//     data['popular'] = popular;
//     data['discount'] = discount;
//     return data;
//   }
// }