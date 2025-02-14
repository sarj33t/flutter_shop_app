import 'package:flutter_shop_app/src/models/api_response.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ProductCubit]
///
class ProductCubit extends Cubit<ProductState>{
  ProductCubit(this.repository): super(ProductState());
  final ProductRepository repository;

  /// Fetch Products
  Future<void> fetchProducts(String path) async{
    emit(
      state.copyWith(apiStatus: ApiStatus.loading)
    );
    final ApiResponse response = await repository.fetchProducts(path);
    int lastIndex = state.page;

    if(response.status){
      final products = (response.data) as List<Product>;
      emit(
        state.copyWith(
          apiStatus: ApiStatus.success,
          productList: products,
          pageVal: lastIndex + 1,
          hasMore: products.length >= 20
        )
      );
    }
    else{
      emit(state.copyWith(apiStatus: ApiStatus.failed, errorMsg: response.message,));
    }
  }

  Future<void> fetchCategories(String path) async{
    final ApiResponse response = await repository.fetchCategories(path);
    emit(state.copyWith(
      categoryList: (response.data) as List<String>
    ));
  }

  /// Fetch Products by Category
  Future<void> fetchProductsByCategory(String path) async{
    emit(
      state.copyWith(apiStatus: ApiStatus.loading)
    );
    final ApiResponse response = await repository.fetchProducts(path);

    if(response.status){
      final products = (response.data) as List<Product>;
      emit(
        state.copyWith(
          apiStatus: ApiStatus.success,
          productList: products,
          hasMore: false,
          pageVal: 1
        )
      );
    }
    else{
      emit(state.copyWith(apiStatus: ApiStatus.failed, errorMsg: response.message,));
    }
  }

  /// Fetch Product Details
  Future<void> fetchProductDetails(String path) async{
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final ApiResponse response = await repository.fetchProductDetails(path);

    if(response.status){
      emit(state.copyWith(
        details: (response.data) as Product,
        apiStatus: ApiStatus.success
      ));
    }
    else{
      emit(state.copyWith(apiStatus: ApiStatus.failed, errorMsg: response.message,));
    }
  }
}