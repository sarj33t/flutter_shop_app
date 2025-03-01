import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_router.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 13/02/25
/// @Message : [AppUtils]
///
class AppUtils {
  static final AppUtils _singleton = AppUtils._();
  AppUtils._();
  static AppUtils get instance => _singleton;

  /// Show Toast message
  void showToast(String message) {
    if (AppRouter.navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
