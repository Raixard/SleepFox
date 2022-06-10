import 'package:flutter/material.dart';

// Untuk menyimpan style widget

final defaultBoxGlow = [
  BoxShadow(
    color: Colors.white.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 8,
    offset: const Offset(2, 3),
  ),
];

const defaultPadding = EdgeInsets.all(18);
const defaultPaddingSmall = EdgeInsets.all(12);
var defaultBorderRadius = BorderRadius.circular(24);
var defaultBorderRadiusSmall = BorderRadius.circular(12);