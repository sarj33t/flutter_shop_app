import 'package:flutter/material.dart';
import 'package:flutter_shop_app/src/utils/hex_color.dart';

///
/// @AUTHOR : Sarjeet Sandhu
/// @DATE : 12/02/25
/// @Message : [ReusableWidgets]
///
class ReusableWidgets{

  static Widget getTxtFormField(String labelTxt, String hintTxt, TextEditingController controller,
    String? Function(String?)? validator, {bool isPassword = false}){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelTxt,
        hintText: hintTxt,
        border: OutlineInputBorder(),
      ),
      keyboardType: isPassword? null: TextInputType.emailAddress,
      validator: (v)=> validator?.call(v),
      obscureText: isPassword,
    );
  }

  /// App Button
  static Widget getButton(String labelTxt, void Function()? onPressed){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), // Round the corners
        gradient: LinearGradient(
          colors: [
            HexColor('#3D86DB'),
            HexColor('#BB53C7'),
            HexColor('#F57173'),
            HexColor('#FCB142'),
            HexColor('#2B92E4'),
            HexColor('#E4245B'),
            HexColor('#D21078'),
          ], // Define gradient colors
          begin: Alignment.topLeft, // Gradient starts from the top left
          end: Alignment.bottomRight, // Gradient ends at the bottom right
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make button background transparent
          shadowColor: Colors.transparent, // Remove shadow
          padding: EdgeInsets.symmetric(horizontal: 46.0, vertical: 8.0),
        ),
        child: Text(labelTxt, style: TextStyle(fontSize: 18.0, color: Colors.white),),
      ),
    );
  }

  /// Descriptive Txt
  static Widget getDescriptiveTxt(){
    return Text(
      'Buy Smart, Sell Easy',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
        letterSpacing: 2.0,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.grey,
            offset: Offset(3.0, 3.0),
          ),
        ],
      ),
    );
  }
}
