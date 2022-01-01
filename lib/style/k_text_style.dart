import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class KTextStyle {
  static final TextStyle headline1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: KColor.black,
  );

  // TODO :: Warning: We do not use TextStyle simply for colors
  /// we stick to a theme color just define font sizes, and weight here
  /// for different font colors we use copyWith
  /// eg: 
  /// KTextStyle.copyWith(color: KColor.black)
  static final TextStyle button = TextStyle(
    color: KColor.k_white,
  );

  static final TextStyle body = TextStyle(
    color: KColor.black,
  );
}
