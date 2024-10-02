import 'package:flutter/material.dart';
import 'package:ricardo_peres/core/color_pallete.dart';

class PessoaStyles {
  static TextStyle accordionSectionTitle() {
    return TextStyle(
        color: ColorPallete.primaryColor, fontWeight: FontWeight.bold);
  }

  static TextStyle accordionSectionAtribute() {
    return const TextStyle(
        fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold);
  }
}
