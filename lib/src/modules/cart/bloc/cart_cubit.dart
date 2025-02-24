import 'package:flutter_shop_app/src/modules/cart/cart_exports.dart';
import 'package:flutter_shop_app/src/modules/product/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit(this.repository): super(CartState());

  final CartRepository repository;

  /// Add Item
  void addItem(CartItem cartItem) async{
    emit(state.copyWith(status: ApiStatus.loading));
    final List<CartItem> itemList = repository.addItem(cartItem, state.cartItems);
    emit(
      state.copyWith(
        status: ApiStatus.success,
        items: itemList
      )
    );
  }

  /// Remove Item
  void removeItem(int productId) {
    emit(state.copyWith(status: ApiStatus.loading));
    final List<CartItem> itemList = repository.removeItem(productId, state.cartItems);
    emit(
      state.copyWith(
        status: ApiStatus.success,
        items: itemList
      )
    );
  }

  /// Update Item
  void updateItem(CartItem cartItem){
    emit(state.copyWith(status: ApiStatus.loading));
    final List<CartItem> itemList = repository.updateItem(cartItem, state.cartItems);
    emit(
      state.copyWith(
        status: ApiStatus.success,
        items: itemList
      )
    );
  }

  /// Calculate Total Price
  void calculateTotalPrice(){
    double total = 0;
    for (var item in state.cartItems) {
      total += item.price * item.quantity;
    }
    emit(
      state.copyWith(price: total)
    );
  }

  /// Fetch All Cart Items
  Future<List<CartItem>> fetchCartItems() async{
    emit(
      state.copyWith(
        status: ApiStatus.loading
      )
    );
    var items = state.cartItems;
    final List<CartItem> itemList = [];
    itemList.addAll(items);
    emit(
      state.copyWith(
        status: ApiStatus.success,
        items: itemList
      )
    );
    return itemList;
  }
}