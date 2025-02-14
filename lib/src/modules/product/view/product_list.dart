import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_router.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ProductList]
///
class ProductList extends StatelessWidget {
  ProductList({super.key, required this.products});
  final List<Product> products;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      controller: scrollController..addListener((){
        bool hasData = context.read<ProductCubit>().state.hasMoreData;
        if(scrollController.offset == scrollController.position.maxScrollExtent && hasData){
          int page = context.read<ProductCubit>().state.page;
          context.read<ProductCubit>().fetchProducts('products?page=$page&limit=20');
        }
      }),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final Product product = products[index];
        return _buildProductCard(product);
      },
    );
  }

  // Build Product Card
  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          // Handle tap (e.g., navigate to product details page)
          print('Tapped on ${product.title}');

          Navigator.pushNamed(AppRouter.navigatorKey!.currentContext!, AppRouter.routeProductDetails,
          arguments: {
            "product_id": product.id?? 0,
            "product_name": product.title?? ''
          });
        },
        child: Stack(
          children: [
            // Product Image
            CachedNetworkImage(
              imageUrl: product.image?.isNotEmpty ?? false ? product.image! : '',
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),

            // Overlay for darkening the image (frosted glass effect)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Product details overlay
            Positioned(
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    '${product.title}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  // Price
                  Text(
                    '€${product.price}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
