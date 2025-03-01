import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_strings.dart';
import 'package:flutter_shop_app/src/utils/app_utils.dart';
import 'package:flutter_shop_app/src/widgets/widgets_exports.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [SignupView]
///
class SignupView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: AppStrings.registerAccount,
      ),
      body: Padding(
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
                  ReusableWidgets.getTxtFormField(
                      AppStrings.email,
                      AppStrings.emptyEmailOrNull,
                      _emailController,
                      _validateEmail),
                  SizedBox(height: 16.0),
                  ReusableWidgets.getTxtFormField(
                      AppStrings.password,
                      AppStrings.emptyPasswordOrNull,
                      _passwordController,
                      _validatePassword,
                      isPassword: true),
                  SizedBox(height: 16.0),
                  ReusableWidgets.getTxtFormField(
                      AppStrings.confirmPassword,
                      AppStrings.validConfirmPassword,
                      _confirmPasswordController,
                      _validatePassword,
                      isPassword: true),
                  SizedBox(height: 36.0),
                  ReusableWidgets.getButton(AppStrings.signUp, () {
                    _onSignUp(context);
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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

  void _onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        AppUtils.instance.showToast(AppStrings.signUpSuccess);
      } else {
        AppUtils.instance.showToast(AppStrings.passwordMatch);
      }
    }
  }
}
