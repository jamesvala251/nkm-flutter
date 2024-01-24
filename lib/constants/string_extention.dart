import 'package:flutter/material.dart';

extension StringExtension on String {
  Color caratBGColo() {
    if ( this == "18") {
      return const Color(0xFF44062C);
    } else if (this == "52") { // SNKP
      return const Color.fromRGBO(0, 0, 68, 1);
    } else if (this == "62") { // NKM
      return const Color.fromRGBO(188, 155, 51, 1);
    } else {
      return const Color(0xFF44062C);
    }
  }
}
