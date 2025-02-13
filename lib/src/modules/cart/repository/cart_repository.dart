import 'package:flutter_shop_app/src/modules/cart/data/cart_item.dart';

/// [CartRepository]
class CartRepository{

  /// Add Item to Cart
  List<CartItem>  addItem(CartItem item, List<CartItem> items) {
    final List<CartItem> itemList = [...items];
    itemList.add(item);
    return itemList;
  }

  /// Remove Item from Cart
  List<CartItem> removeItem(int productId, List<CartItem> items) {
    final List<CartItem> tempList = [...items];

    if(tempList.any((element) => element.id == productId)){
      tempList.removeWhere((element) => element.id == productId);
    }
    return tempList;
  }

  /// Update Item in Cart (Change Quantity, Price, etc.,)
  List<CartItem> updateItem(CartItem cartItem, List<CartItem> items) {
    final List<CartItem> itemList = [...items];
    itemList.removeWhere((element) => element.id == cartItem.id);
    itemList.add(cartItem);
    return itemList;
  }
}