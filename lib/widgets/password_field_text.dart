import 'package:flutter/material.dart';
import 'auth_text_field.dart';

class AuthPasswordTextField extends StatefulWidget {
  const AuthPasswordTextField({super.key, required this.controller, required this.hintText, required this.validator,});

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<AuthPasswordTextField> createState() => _AuthPasswordTextFieldState();
}

class _AuthPasswordTextFieldState extends State<AuthPasswordTextField> {
  bool _obscureText = true;

  void _toggleObscureText(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  AuthTextField(
      hintText: widget.hintText,
      obscureText: _obscureText,
      controller: widget.controller,
      suffixIcon: IconButton(
        onPressed: _toggleObscureText,
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
      ),
      validator: widget.validator,
    );
  }
}
