import 'package:flutter/material.dart';
import 'package:mantra_application/common/style/colors/colors.dart';
import 'package:mantra_application/common/style/typography/mantra_text_style.dart';

class AppTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: MantraTextStyle.displayLarge,
      displayMedium: MantraTextStyle.displayMedium,
      displaySmall: MantraTextStyle.displaySmall,
      headlineLarge: MantraTextStyle.headlineLarge,
      headlineMedium: MantraTextStyle.headlineMedium,
      headlineSmall: MantraTextStyle.headlineSmall,
      titleLarge: MantraTextStyle.titleLarge,
      titleMedium: MantraTextStyle.titleMedium,
      titleSmall: MantraTextStyle.titleSmall,
      bodyLarge: MantraTextStyle.bodyLargeBold,
      bodyMedium: MantraTextStyle.bodyLargeMedium,
      bodySmall: MantraTextStyle.bodyLargeRegular,
      labelLarge: MantraTextStyle.labelLarge,
      labelMedium: MantraTextStyle.labelMedium,
      labelSmall: MantraTextStyle.labelSmall,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: MantraColors.primaryColors,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: MantraColors.primaryColors,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
    );
  }
}
