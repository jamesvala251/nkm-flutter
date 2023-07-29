import 'package:flutter/material.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/material_color_generator.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF44062C),
    primaryContainer: Color(0xFF44062C),
    secondary: Color(0xFF44062C),
    error: Colors.red,
    errorContainer: Colors.red,
  ),
  primarySwatch: MaterialColorGenerator.generateMaterialColor(
    color: const Color(0xFF44062C),
  ),
  fontFamily: CommonConstants.regular,
  canvasColor: Colors.white,
  highlightColor: const Color(0xFFE651B9),
);
