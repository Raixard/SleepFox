import 'package:flutter/material.dart';
import 'package:sleepfox/utils/colors.dart';

// Garis pemisah vertikal
class SeparatorV extends StatelessWidget {
  const SeparatorV({
    Key? key,
    this.small = false,
  }) : super(key: key);

  final bool small;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: small ? 16 : 32,
    );
  }
}

// Kolom inputan teks
class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final Icon icon;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        focusColor: cOrange,
        fillColor: cDarkPurple.withOpacity(0.5),
        filled: true,
        labelText: labelText,
        prefixIcon: icon,
      ),
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
