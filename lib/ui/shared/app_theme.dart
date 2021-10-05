import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  const AppTheme(this.context);

  ThemeData get defaultTheme {
    return ThemeData(
      primaryColor: AppColors.primaryDark,
      primaryColorLight: AppColors.primaryLight,
      primaryColorDark: AppColors.primaryDark,
      colorScheme: const ColorScheme.light(primary: AppColors.primaryDark),
      canvasColor: Colors.white,
      dividerColor: AppColors.darkGrey,
      errorColor: AppColors.error,
      scaffoldBackgroundColor: Colors.white,
      indicatorColor: AppColors.accent,
      textSelectionTheme: _buildTextSelectionTheme(),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: AppColors.darkGrey),
      ),
      fontFamily: 'OpenSans',
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      bottomNavigationBarTheme: _buildBottomNavBarTheme(),
    );
  }

  BottomNavigationBarThemeData _buildBottomNavBarTheme() {
    return const BottomNavigationBarThemeData(
      unselectedItemColor: AppColors.grey,
      selectedItemColor: AppColors.primaryDark,
    );
  }

  TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.primaryDark),
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    ///
    return InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.grey.withOpacity(.6)),
      contentPadding: const EdgeInsets.all(12),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.accent),
        borderRadius: BorderRadius.circular(30),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.accent),
      ),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonTheme() {
    ////
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  TextSelectionThemeData _buildTextSelectionTheme() {
    return const TextSelectionThemeData(
      cursorColor: AppColors.accent,
      selectionColor: AppColors.accent,
      selectionHandleColor: AppColors.accentDark,
    );
  }
}
