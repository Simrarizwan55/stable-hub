import "package:flutter/material.dart";
import "package:flutter/services.dart";
// import "../constants.dart";

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.floatingLabelBehavior,
    this.alignLabelWithHint,
    this.enabled,
    this.counterText,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? alignLabelWithHint;
  final bool? enabled;
  final String? counterText;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      // style: AppTextStyles.kBodyMedium,
      textInputAction: TextInputAction.next,
      controller: controller,
      validator: validator,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        counterText: counterText,
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        floatingLabelBehavior: floatingLabelBehavior,
        alignLabelWithHint: alignLabelWithHint,
        hintText: hintText,
        contentPadding: EdgeInsets.zero,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
            width: 1.5,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
            width: 1.5,
          ),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
