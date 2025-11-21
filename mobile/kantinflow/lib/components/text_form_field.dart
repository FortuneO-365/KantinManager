import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String labelText;
  final bool obscureText;
  final TextEditingController _controller;

  CustomTextFormField(this.prefixIcon, this.suffixIcon, this.labelText, this.obscureText, this._controller, {super.key, required InputDecoration decoration});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final Color selectionColor = const Color.fromARGB(255, 187, 222, 251);

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: selectionColor,     
        cursorColor: mainColor,
        selectionHandleColor: Colors.black,
      ),
      child: TextFormField(
        controller: _controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: mainColor
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 20.0,
                )
              : null,
          suffixIcon:suffixIcon != null
              ? Icon(
                  suffixIcon,
                  size: 20.0,
                )
              : null,
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, 
              width: 1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mainColor, 
              width: 1.2
            ),
          ),
        ),
      ),
    );
  }
}