import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/core/core.dart';
import 'package:flutter_shop_app/src/modules/authentication/authentication_exports.dart';
import 'package:flutter_shop_app/src/modules/product/product_exports.dart';
import 'package:flutter_shop_app/src/widgets/widgets_exports.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [LoginView]
///
class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({super.key});

  // Validate Email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyEmailOrNull;
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return AppStrings.validEmail;
    }
    return null;
  }

  // Validate Password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyPasswordOrNull;
    } else if (value.length < 6) {
      return AppStrings.validPassword;
    }
    return null;
  }

  // Sign In function
  void _signIn(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppStrings.signIn
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: context.read<AuthCubit>(),
        builder: (BuildContext context, AuthState state) {
          if(state.apiStatus == ApiStatus.idle){
            return loginForm(context);
          }
          if(state.apiStatus == ApiStatus.loading){
            return Stack(
              fit: StackFit.expand,
              children: [
                loginForm(context),
                Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
                ),
              ],
            );
          }
          if(state.apiStatus == ApiStatus.success && state.isAuthenticated){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppRouter.pushReplacementNamed(AppRouter.routeProductList);
            });
          }
          if(state.apiStatus == ApiStatus.success && !state.isAuthenticated){
            return loginForm(context);
          }
          return SizedBox();
        },
      )
    );
  }

  // Login Form
  Widget loginForm(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(AppStrings.assetSplash),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                ReusableWidgets.getDescriptiveTxt(),
                SizedBox(height: 36.0),

                // Email Field
                ReusableWidgets.getTxtFormField(AppStrings.email, AppStrings.enterEmail, _emailController, _validateEmail),
                SizedBox(height: 16.0),

                // Password Field
                ReusableWidgets.getTxtFormField(AppStrings.password, AppStrings.enterPassword, _passwordController,
                    _validatePassword, isPassword: true),
                SizedBox(height: 12.0),

                Center(
                  child: GestureDetector(
                    onTap: (){
                      AppRouter.pushNamed(AppRouter.routeSignUp);
                    }, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppStrings.newUserRegister, style: TextStyle(color: Colors.blue, fontSize: 16.0),),
                  )
                  ),
                ),
                SizedBox(height: 16.0),

                // Sign In Button
                ReusableWidgets.getButton(AppStrings.signIn, (){
                  _signIn(context);
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
