import 'package:flutter_shop_app/src/modules/authentication/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/src/modules/authentication/repository/auth_repository.dart';
import 'package:flutter_shop_app/src/modules/product/bloc/product_state.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [AuthCubit]
///
class AuthCubit extends Cubit<AuthState>{
  AuthCubit(this.repository): super(AuthState());

  final AuthRepository repository;

  /// Login
  Future<void> login() async{
    emit(state.copyWith(status: ApiStatus.loading, authenticated: false));

    await repository.login();

    emit(
      state.copyWith(
        status: ApiStatus.success,
        authenticated: true
      )
    );
  }

  /// Sign Up
  Future<void> signUp() async{

  }

  // Logout
  Future<void> logout() async{
    emit(
      state.copyWith(
        status: ApiStatus.success,
        authenticated: false
      )
    );
  }
}