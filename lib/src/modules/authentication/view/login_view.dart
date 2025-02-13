import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/core/app_router.dart';
import 'package:flutter_shop_app/src/widgets/custom_appbar.dart';
import 'package:flutter_shop_app/src/widgets/reusable_widgets.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 11/02/25
/// @Message : [LoginView]
///
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validate Email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate Password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Sign In function
  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      AppRouter.pushReplacementNamed(AppRouter.routeProductList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Sign In',
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
                child: Image.asset('assets/images/splash.png'),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  ReusableWidgets.getDescriptiveTxt(),
                  SizedBox(height: 36.0),

                  // Email Field
                  ReusableWidgets.getTxtFormField('Email', 'Enter your email', _emailController, _validateEmail),
                  SizedBox(height: 16.0),

                  // Password Field
                  ReusableWidgets.getTxtFormField('Password', 'Enter your password', _passwordController,
                      _validatePassword, isPassword: true),
                  SizedBox(height: 12.0),

                  Center(
                    child: GestureDetector(
                      onTap: (){
                        // Navigator.pushNamed(context, AppRouter.routeSignUp);
                        AppRouter.pushNamed(AppRouter.routeSignUp);
                      }, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('New User? Register', style: TextStyle(color: Colors.blue, fontSize: 16.0),),
                      )
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Sign In Button
                  ReusableWidgets.getButton('Sign In', _signIn)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
