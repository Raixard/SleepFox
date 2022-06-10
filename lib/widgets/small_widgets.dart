import 'package:flutter/material.dart';

class SeparatorV extends StatelessWidget {
  const SeparatorV({Key? key, this.small = false,}) : super(key: key);

  final bool small;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: small ? 16 : 32,
    );
  }
}