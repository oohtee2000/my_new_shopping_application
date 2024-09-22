import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Avenir",
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      height: 1.75,
      fontSize: 12,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
  );
}
