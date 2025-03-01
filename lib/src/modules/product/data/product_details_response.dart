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
