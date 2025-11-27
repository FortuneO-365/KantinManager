import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget{
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  
  const ProductTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.keyboardType,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0
          ),
        ),
        SizedBox(height: 8.0),
        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: Colors.grey.shade400,
            cursorColor: Colors.grey.shade600,
            selectionHandleColor: Colors.black,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade100,
              hintStyle: TextStyle(
                color: Colors.grey.shade400
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 2.0
                )
              ),
            ),
          ),
        )
      ],
    );
  }
}