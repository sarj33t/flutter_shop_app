import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/core/core.dart';
import 'package:flutter_shop_app/src/modules/cart/cart_exports.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';
import 'package:flutter_shop_app/src/utils/app_utils.dart';
import 'package:flutter_shop_app/src/widgets/reusable_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [ProductDetails]
///
class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {super.key, required this.productId, required this.productName});

  final int productId;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: context.read<ProductCubit>()
          ..fetchProductDetails('${ApiConstants.productsPath}/$productId'),
        builder: (BuildContext context, ProductState state) {
          if (state.status == ApiStatus.loading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state.status == ApiStatus.success &&
              state.productDetails != null) {
            final String pName = state.productDetails?.title ?? '';
            final double price = state.productDetails?.price ?? 0.0;
            final String pDetails = state.productDetails?.description ?? '';

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  shadowColor: Colors.black,
                  elevation: 5.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        EdgeInsets.only(left: 50.0, right: 10.0, bottom: 10.0),
                    title: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        pName.capitalizeEachWord(),
                        maxLines: 1,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    background: CachedNetworkImage(
                      imageUrl: state.productDetails?.image ?? '',
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        AppStrings.assetSplash,
                        fit: BoxFit.fill,
                      ),
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppStrings.description,
                              style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            SizedBox(height: 8.0),

                            Text(
                              pDetails,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black45),
                            ),
                            SizedBox(height: 16.0),

                            // Brand Section
                            _buildDetailText(
                                '${AppStrings.labelPrice}: \$${price.toStringAsFixed(2)}'),

                            SizedBox(height: 32.0),

                            SizedBox(
                              width: double.infinity,
                              child: ReusableWidgets.getButton(
                                  AppStrings.addToCart, () {
                                _onAddToCart(context, state.productDetails!);
                              }),
                            ),
                            SizedBox(height: 80.0)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Add to Cart
  Future<void> _onAddToCart(BuildContext context, Product product) async {
    final itemsInCart = await context.read<CartCubit>().fetchCartItems();
    if (itemsInCart.any((element) => element.id == product.id)) {
      AppUtils.instance.showToast(AppStrings.itemAlreadyInCart);
      return;
    }
    if (context.mounted) {
      context.read<CartCubit>().addItem(CartItem(
          id: product.id ?? 0,
          name: product.title ?? '',
          price: product.price ?? 0.0,
          quantity: 1,
          imageUrl: product.image ?? ''));
      AppUtils.instance.showToast(AppStrings.itemAddedToCart);
    }
  }
}
