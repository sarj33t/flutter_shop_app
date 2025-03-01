import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/src/modules/cart/data/cart_item.dart';
import 'package:flutter_shop_app/src/modules/product/bloc/product_state.dart';

/// [CartState]
class CartState extends Equatable {
  final List<CartItem> cartItems;
  final ApiStatus apiStatus;
  final double totalPrice;

  const CartState(
      {this.cartItems = const [],
      this.apiStatus = ApiStatus.idle,
      this.totalPrice = 0.0});

  CartState copyWith(
      {List<CartItem>? items, ApiStatus? status, double? price}) {
    return CartState(
        cartItems: items ?? cartItems,
        apiStatus: status ?? apiStatus,
        totalPrice: price ?? totalPrice);
  }

  @override
  List<Object?> get props => [cartItems, apiStatus, totalPrice];
}
