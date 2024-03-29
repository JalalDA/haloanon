import 'package:flutter/material.dart';


ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primary: Colors.grey.shade100,
    secondary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade800
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black
  )
);