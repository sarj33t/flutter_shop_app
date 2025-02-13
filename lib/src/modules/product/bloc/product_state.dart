import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/src/modules/product/data/product.dart';
import 'package:flutter_shop_app/src/modules/product/data/product_list_response.dart';
import 'package:flutter_shop_app/src/modules/product/data/product_details_response.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ProductState]
///
class ProductState extends Equatable {
  final List<Product> products;
  final List<String> categories;
  final String error;
  final ApiStatus status;
  final int page;
  final bool hasMoreData;
  final Product? productDetails;

  const ProductState({
    this.products = const [],
    this.categories = const [],
    this.error = '',
    this.status = ApiStatus.idle,
    this.page = 1,
    this.hasMoreData = false,
    this.productDetails
  });

  ProductState copyWith({
    List<Product>? productList,
    List<String>? categoryList,
    String? errorMsg,
    ApiStatus? apiStatus,
    int? pageVal,
    bool? hasMore,
    Product? details
  }){
    return ProductState(
      products: productList?? products,
      categories: categoryList?? categories,
      error: errorMsg?? error,
      status: apiStatus?? status,
      page: pageVal?? page,
      hasMoreData: hasMore?? hasMoreData,
      productDetails: details?? productDetails
    );
  }

  @override
  List<Object?> get props => [
    products,
    categories,
    error,
    status,
    page,
    hasMoreData,
    productDetails
  ];
}

/// [ApiStatus]
enum ApiStatus{
  idle,
  loading,
  success,
  failed
}