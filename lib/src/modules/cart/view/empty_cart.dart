import 'package:flutter/material.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 13/02/25
/// @Message : [EmptyCartView]
///
class EmptyCartView extends StatelessWidget{
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/splash.png'),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text('No item in your cart!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),

                Text('Try shopping!')
              ],
            ),
          ),
        )
      ],
    );
  }
}