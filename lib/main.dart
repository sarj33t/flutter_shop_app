import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/firebase_options.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/core/core.dart';
import 'package:flutter_shop_app/src/services/database_service.dart';
import 'package:flutter_shop_app/src/modules/authentication/authentication_exports.dart';
import 'package:flutter_shop_app/src/modules/cart/cart_exports.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';
import 'package:flutter_shop_app/src/network/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  DatabaseService.instance.init(firebaseApp);

  /// Setup Networking Client on App Launch
  final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  dio.interceptors.add(LogInterceptor());
  final ApiClient apiClient = ApiClient(dio);

  /// Register Bloc and Repository Providers Globally
  runApp(MultiBlocProvider(providers: [
    RepositoryProvider(create: (ctx) => ProductRepository(apiClient)),
    RepositoryProvider(create: (ctx) => CartRepository()),
    RepositoryProvider(create: (ctx) => AuthRepository()),
    BlocProvider(create: (ctx) => ProductCubit(ctx.read<ProductRepository>())),
    BlocProvider(create: (ctx) => CartCubit(ctx.read<CartRepository>())),
    BlocProvider(create: (ctx) => AuthCubit(ctx.read<AuthRepository>())),
  ], child: ShopApp()));
}

/// [ShopApp]
class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: AppRouter.navigatorKey,
      home: const SplashView(),
      // home: CartScreen(),
    );
  }
}
