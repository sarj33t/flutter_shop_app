import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/modules/cart/bloc/cart_cubit.dart';
import 'package:flutter_shop_app/src/modules/cart/bloc/cart_state.dart';
import 'package:flutter_shop_app/src/modules/cart/view/cart_list.dart';
import 'package:flutter_shop_app/src/modules/cart/view/empty_cart.dart';
import 'package:flutter_shop_app/src/modules/product/bloc/product_state.dart';
import 'package:flutter_shop_app/src/utils/app_utils.dart';
import 'package:flutter_shop_app/src/widgets/custom_appbar.dart';
import 'package:flutter_shop_app/src/widgets/reusable_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [CartScreen]
///
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Your Shopping Cart',
      ),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: context.read<CartCubit>()..fetchCartItems(),
        buildWhen: (p, c) => p.cartItems.length != c.cartItems.length,
        builder: (BuildContext context, CartState state) {
          if(state.apiStatus == ApiStatus.loading){
            return Center(child: CupertinoActivityIndicator());
          }
          if(state.apiStatus == ApiStatus.success){
            context.read<CartCubit>().calculateTotalPrice();
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: state.cartItems.isNotEmpty? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CartList(cartItems: state.cartItems,)
                    ),
                    SizedBox(height: 20.0),

                    BlocSelector<CartCubit, CartState, double>(
                      selector: (state){
                        return state.totalPrice;
                      },
                      builder: (context, cartItems){
                        return _priceLabel('Total Price: \$${cartItems.toStringAsFixed(2)}');
                      }
                    ),
                    SizedBox(height: 16.0),

                    SafeArea(
                      child: Center(
                        child: ReusableWidgets.getButton('Proceed to Checkout', (){
                          AppUtils.instance.showToast('Proceed to checkout!');
                        }),
                      ),
                    ),
                  ],
                ): EmptyCartView()
            );
          }
          return const SizedBox();
        },
      )
    );
  }

  // Price Label
  Widget _priceLabel(String label){
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}


