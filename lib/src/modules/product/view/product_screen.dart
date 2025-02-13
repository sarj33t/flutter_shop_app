import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/api_constants.dart';
import 'package:flutter_shop_app/src/core/app_extensions.dart';
import 'package:flutter_shop_app/src/core/app_router.dart';
import 'package:flutter_shop_app/src/modules/cart/bloc/cart_cubit.dart';
import 'package:flutter_shop_app/src/modules/cart/bloc/cart_state.dart';
import 'package:flutter_shop_app/src/modules/product/data/product.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_shop_app/src/modules/product/bloc/product_cubit.dart';
import 'package:flutter_shop_app/src/modules/product/bloc/product_state.dart';
import 'package:flutter_shop_app/src/modules/product/view/product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [ProductScreen]
///
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<Product> productList = [];
  final List<String> categories = [];
  int initialPage = 1;
  int itemLimit = 20;
  int filterPageIndex = 1;

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        title: Text('Products', style: TextStyle(color: Colors.white),),
        actions: [

          BlocBuilder<CartCubit, CartState>(
            buildWhen: (p, c) => p.cartItems != c.cartItems,
            builder: (context, state){
              return GestureDetector(
                onTap: (){
                  AppRouter.pushNamed(AppRouter.routeCartScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: badges.Badge(
                    showBadge: state.cartItems.isNotEmpty,
                    badgeContent: Text('${state.cartItems.length}',
                      style: TextStyle(color: Colors.white),),
                    badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.black
                    ),
                    position: badges.BadgePosition.topEnd(top: -16, end: -12),
                    child: Icon(Icons.shopping_cart, color: Colors.white, size: 30.0,),
                    onTap: (){

                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: context.read<ProductCubit>(),
        builder: (BuildContext context, ProductState state) {
          if(state.error.isNotEmpty){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(state.error),
              ),
            );
          }
          if(state.status == ApiStatus.success && state.products.isNotEmpty){
            if(state.categories.isNotEmpty){
              categories.clear();
              categories.addAll(state.categories);
            }

            productList.addAll(state.products);
          }
          return Stack(
            children: [
              Column(
                children: [
                  TextButton(
                      onPressed: (){
                        if(categories.isNotEmpty){
                          showBottomSheetCategory();
                        }
                      }, child: Text('Filter Products By Category')
                  ),

                  Expanded(
                    child: ProductList(
                      products: productList,
                    ),
                  )
                ],
              ),

              Visibility(
                visible: state.status == ApiStatus.loading,
                child: Align(
                  child: CupertinoActivityIndicator(),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  /// Fetch Initial Data
  void getInitialData() {
    String path = ApiConstants.productsPath;
    String queryStr = '?page=$initialPage&limit=$itemLimit';
    context.read<ProductCubit>().fetchProducts(path + queryStr);
    context.read<ProductCubit>().fetchCategories(ApiConstants.categoriesPath);
  }

  /// Show Bottom Sheet for Product Category
  void showBottomSheetCategory() async{
    final String? result = await showModalBottomSheet(
        context: context,
        builder: (ctx){
          return Container(
            height: 360.0,
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.sizeOf(ctx).width,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filter Products',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0), textAlign: TextAlign.start),

                      TextButton(
                        onPressed: (){
                          if(Navigator.canPop(context)){
                            Navigator.pop(context, 'clear_filter');
                          }
                      }, child: Text('Clear Filters'))
                    ],
                  )
                ),

                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index){
                      return Divider();
                    },
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String category = categories[index];
                      return GestureDetector(
                        onTap: (){
                          if(Navigator.canPop(context)){
                            Navigator.pop(context, category);
                          }
                        },
                        child: ListTile(
                          title: Text(category.capitalizeEachWord(), style: TextStyle(fontSize: 14.0), maxLines: 1,),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
    );
    if(result != null){
      if(result == 'clear_filter'){
        productList.clear();
        categories.clear();
        getInitialData();
      }
      else{
        productList.clear();
        String path = ApiConstants.productsPath;
        String queryStr = 'category?type=$result';
        if(mounted){
          context.read<ProductCubit>().fetchProductsByCategory(path + queryStr);
        }
      }
    }
  }
}
