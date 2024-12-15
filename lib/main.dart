import 'package:flutter/material.dart';
import 'expenses.dart';

var mColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var mDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        colorScheme: mDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
            color: mDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: mDarkColorScheme.primaryContainer,
                foregroundColor: mDarkColorScheme.onPrimaryContainer))),
    theme: ThemeData().copyWith(
      colorScheme: mColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: mColorScheme.onPrimaryContainer,
          foregroundColor: mColorScheme.primaryContainer),
      cardTheme: const CardTheme().copyWith(
          color: mColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: mColorScheme.primaryContainer)),
      textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: mColorScheme.onSecondaryContainer,
              fontSize: 16)),
    ),
    home: const Expenses(),
  ));
}
