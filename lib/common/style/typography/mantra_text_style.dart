import 'package:flutter/material.dart';

class MantraTextStyle {
  static const _commonStyle = TextStyle(fontFamily: "Poppins");

  /// displayLarge Text Style
  static TextStyle displayLarge = _commonStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
  );

  /// displayMedium Text Style
  static TextStyle displayMedium = _commonStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    letterSpacing: -1,
  );

  /// displaySmall Text Style
  static TextStyle displaySmall = _commonStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
  );

  /// headlineLarge Text Style
  static TextStyle headlineLarge = _commonStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -1,
  );

  /// headlineMedium Text Style
  static TextStyle headlineMedium = _commonStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    letterSpacing: -1,
  );

  /// headlineMedium Text Style
  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: -1,
  );

  /// titleLarge Text Style
  static TextStyle titleLarge = _commonStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );

  /// titleMedium Text Style
  static TextStyle titleMedium = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.2,
  );

  /// titleSmall Text Style
  static TextStyle titleSmall = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    letterSpacing: 1.2,
  );

  /// bodyLargeBold Text Style
  static TextStyle bodyLargeBold = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// bodyLargeMedium Text Style
  static TextStyle bodyLargeMedium = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// bodyLargeRegular Text Style
  static TextStyle bodyLargeRegular = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /// labelLarge Text Style
  static TextStyle labelLarge = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.3,
  );

  /// labelMedium Text Style
  static TextStyle labelMedium = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.3,
  );

  /// labelSmall Text Style
  static TextStyle labelSmall = _commonStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w100,
    letterSpacing: 1.3,
  );
}
