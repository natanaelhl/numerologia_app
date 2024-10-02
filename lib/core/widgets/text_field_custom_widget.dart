import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';

class TextFieldCustomWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final String hintText;
  const TextFieldCustomWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: ColorPallete.primaryColor,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: ColorPallete.primaryColor, width: 2.0),
          ),
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hintText),
    );
  }
}
