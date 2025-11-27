import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData? prefixIcon;
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscure = true;

  final Color mainColor = const Color.fromARGB(255, 144, 202, 249);
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
        controller: widget.controller,
        obscureText: widget.isPassword ? obscure : false,
        onChanged: (_) => setState(() {}), // refresh UI when typing
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: mainColor),

          // PREFIX ICON
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, size: 20)
              : null,

          // SUFFIX ICON — only shows when user has typed & it's a password input
          suffixIcon: widget.isPassword && widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                )
              : null,

          labelText: widget.labelText,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.2),
          ),
        ),
      ),
    );
  }
}
