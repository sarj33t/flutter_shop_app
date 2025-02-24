import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/modules/authentication/authentication_exports.dart';
import 'package:flutter_shop_app/src/modules/cart/cart_exports.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [AppRouter]
///
class AppRouter{
  static const String routeProductList = 'product_list';
  static const String routeProductDetails = 'product_details';
  static const String routeLogin = 'login_view';
  static const String routeSignUp = 'signup_view';
  static const String routeCartScreen = 'cart_screen';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name){
      case routeProductList:
        return MaterialPageRoute(builder: (ctx) => ProductScreen());
      case routeProductDetails:
        if(settings.arguments != null){
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          String name = args['product_name'] as String;
          int id = args['product_id'] as int;
          return MaterialPageRoute(builder: (ctx) => ProductDetails(productId: id, productName: name));
        }
      case routeLogin:
        return MaterialPageRoute(builder: (ctx) => LoginView());
      case routeSignUp:
        return MaterialPageRoute(builder: (ctx) => SignupView());
      case routeCartScreen:
        return MaterialPageRoute(builder: (ctx) => CartScreen());
    }
    return MaterialPageRoute(builder: (ctx) => Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text(AppStrings.noRouteFound)
          ],
        ),
      ),
    ));
  }

  static void pushReplacementNamed(String route){
    Navigator.pushReplacementNamed(navigatorKey.currentContext!, route);
  }

  static void pushNamed(String route){
    Navigator.pushNamed(navigatorKey.currentContext!, route);
  }
}