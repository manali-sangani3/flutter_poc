import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {

  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const subHeading = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const taskTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}