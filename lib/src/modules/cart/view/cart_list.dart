import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/modules/cart/cart_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 13/02/25
/// @Message : [CartList]
///
class CartList extends StatelessWidget {
  const CartList({super.key, required this.cartItems});
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItemCard(cartItem: cartItems[index]);
      },
    );
  }
}

// [CartItemCard]
class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Product Image
            CachedNetworkImage(
              imageUrl: cartItem.imageUrl ?? '',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                AppStrings.assetSplash,
                fit: BoxFit.fill,
              ),
              fit: BoxFit.fill,
              width: 80.0,
              height: 80.0,
            ),
            SizedBox(width: 16.0),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _labelTxt('\$${cartItem.price.toStringAsFixed(2)} each'),
                  SizedBox(height: 8.0),
                  BlocBuilder<CartCubit, CartState>(
                    bloc: context.read<CartCubit>(),
                    buildWhen: (previous, current) =>
                        previous.cartItems != current.cartItems,
                    builder: (BuildContext context, CartState state) {
                      return _labelTxt(
                          '${AppStrings.labelQuantity}: ${cartItem.quantity}');
                    },
                  ),
                  SizedBox(height: 8.0),
                  _quantityRow(context),
                  SizedBox(height: 8.0),
                ],
              ),
            ),

            // Remove Button (optional)
            IconButton(
              icon: Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () {
                context.read<CartCubit>().removeItem(cartItem.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Label Txt
  Widget _labelTxt(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black54,
      ),
    );
  }

  // Quantity Changer Row
  Widget _quantityRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0),
            child: Icon(
              Icons.add_circle_outline,
              size: 24.0,
              color: Colors.green,
            ),
          ),
          onTap: () {
            cartItem.quantity = cartItem.quantity += 1;
            context.read<CartCubit>().updateItem(cartItem);
            context.read<CartCubit>().calculateTotalPrice();
          },
        ),
        const SizedBox(
          width: 12.0,
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0),
            child: Icon(
              Icons.remove_circle_outline,
              size: 24.0,
              color: Colors.red,
            ),
          ),
          onTap: () {
            if (cartItem.quantity > 1) {
              cartItem.quantity = cartItem.quantity -= 1;
              context.read<CartCubit>().updateItem(cartItem);
              context.read<CartCubit>().calculateTotalPrice();
            }
          },
        ),
      ],
    );
  }
}
