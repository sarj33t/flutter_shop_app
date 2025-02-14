import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/src/modules/product/bloc/product_state.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [AuthState]
///
class AuthState extends Equatable{
  final bool isAuthenticated;
  final ApiStatus apiStatus;

  const AuthState({
    this.isAuthenticated = false,
    this.apiStatus = ApiStatus.idle
  });

  AuthState copyWith({
    bool? authenticated,
    ApiStatus? status
  }){
    return AuthState(
      isAuthenticated: authenticated?? false,
      apiStatus: status?? apiStatus
    );
  }

  @override
  List<Object?> get props => [
    isAuthenticated,
    apiStatus
  ];
}