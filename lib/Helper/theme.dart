import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {

  const AppColors();
   static const Color loginGradientStart = const Color(0xFF09d73df);
   static const Color loginGradientEnd = const Color(0xFF09d73df);


  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}


class AppTypoGraphy{
  
 static const TextStyle normalTextStyle = TextStyle(fontSize:14,color: Colors.black38);


}