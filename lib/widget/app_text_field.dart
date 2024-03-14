import 'package:flutter/material.dart';

import '../../res/colors.dart';

class AppTextField extends StatefulWidget {
  AppTextField(
      {super.key,
      this.obscureText = false,
      required this.hintText,
      required this.controller,
      this.keyboardType,
      this.validator});

  bool obscureText;
  String hintText;
  TextEditingController controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: kSecondaryColor,
        filled: true,
        border: InputBorder.none,
        hintText: widget.hintText,
      ),
      cursorColor: Theme.of(context).colorScheme.onBackground,
    );
  }
}
