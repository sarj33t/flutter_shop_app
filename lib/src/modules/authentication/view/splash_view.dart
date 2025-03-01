import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_router.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/services/product_service.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [SplashView]
///
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _replaceView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(AppStrings.assetSplash)],
        ),
      ),
    );
  }

  void _replaceView() async {
    Future.delayed(Duration(seconds: 2), () {
      AppRouter.pushReplacementNamed(AppRouter.routeLogin);
    });
  }
}
