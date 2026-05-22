import 'package:flutter/material.dart';
import 'package:flutter_poc/theme/app_colors.dart';

class AppTheme {
  /// LIGHT THEME
  static final lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: const Color(0xffF5F7FB),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        isDense: true,
      ),
      menuStyle: MenuStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    ),

    cardColor: Colors.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );

  /// DARK THEME
  static final darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: const Color(0xff181A20),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xff181A20),
      foregroundColor: Colors.white,
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        isDense: true,
      ),
      menuStyle: MenuStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    ),
    cardColor: const Color(0xff242731),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}
