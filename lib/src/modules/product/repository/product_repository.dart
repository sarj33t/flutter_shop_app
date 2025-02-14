import 'package:flutter_shop_app/src/models/api_response.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';
import 'package:flutter_shop_app/src/network/api_client.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ProductRepository]
///
class ProductRepository{
  ProductRepository(this.apiClient);
  final ApiClient apiClient;

  /// Fetch Products
  Future<ApiResponse> fetchProducts(String path) async{
    try{
      final response = await apiClient.getApi(path);

      if(response.statusCode != null && response.statusCode == 200){
        if(response.data != null){
          final List<Product> products = ProductListResponse.fromJson(response.data).products?? [];
          // final List<Product> products = (response.data as List<dynamic>)
          //   .map((element) => ProductListResponse.fromJson(element).).toList();
          return ApiResponse(
            status: true,
            message: 'success',
            data: products,
          );
        }else{
          return ApiResponse(status: true, message: 'success', data: null);
        }
      }else{
        return ApiResponse(status: false, message: 'failed', data: null);
      }
    }catch(ex){
      return ApiResponse(
        message: ex.toString(),
        status: false, data: null
      );
    }
  }

  /// Fetch Product Categories
  Future<ApiResponse> fetchCategories(String path) async{
    try{
      final response = await apiClient.getApi(path);
      if(response.statusCode != null && response.statusCode == 200){
        if(response.data != null){
          final List<String> categories = CategoryListResponse.fromJson(response.data).categories?? <String>[];
            // .map((element) => element.toString()).toList();
          return ApiResponse(
            status: true,
            message: 'success',
            data: categories
          );
        }else{
          return ApiResponse(status: true, message: 'success', data: null);
        }
      }else{
        return ApiResponse(status: false, message: 'failed', data: null);
      }
    }catch(ex){
      return ApiResponse(
        message: ex.toString(),
        status: false, data: null
      );
    }
  }

  /// Fetch Product Details
  Future<ApiResponse> fetchProductDetails(String path) async{
    try{
      final response = await apiClient.getApi(path);
      if(response.statusCode != null && response.statusCode == 200){
        if(response.data != null){
          final Product? details = ProductDetailsResponse.fromJson(response.data).product;
          return ApiResponse(
              status: true,
              message: 'success',
              data: details
          );
        }else{
          return ApiResponse(status: true, message: 'success', data: null);
        }
      }else{
        return ApiResponse(status: false, message: 'failed', data: null);
      }
    }catch(ex){
      return ApiResponse(
          message: ex.toString(),
          status: false, data: null
      );
    }
  }
}