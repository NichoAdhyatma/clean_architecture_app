import 'package:blog_app_clean_tdd/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static _inputBorder({
    Color borderColor = AppPallete.borderColor,
    double width = 1.0,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: width,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final _fredokaFont = GoogleFonts.fredoka();

  static final _textTheme = TextTheme(
    labelLarge: _fredokaFont,
    labelMedium: _fredokaFont,
    labelSmall: _fredokaFont,
    bodyLarge: _fredokaFont,
    bodyMedium: _fredokaFont,
    bodySmall: _fredokaFont,
    displayLarge: _fredokaFont,
    displayMedium: _fredokaFont.copyWith(
      fontWeight: FontWeight.w700,
    ),
    displaySmall: _fredokaFont,
    titleLarge: _fredokaFont,
    titleMedium: _fredokaFont,
    titleSmall: _fredokaFont,
  );

  static InputDecoration defaultInputDecoration(
          {String? labelText, String? hintText}) =>
      InputDecoration(
        labelText: labelText,
        hintText: hintText,
      );

  static InputDecoration obscureInputDecoration(
          {String? labelText, String? hintText, void Function()? onTap}) =>
      InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(23.0),
        suffix: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(Icons.visibility),
          ),
        ),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      surfaceTintColor: AppPallete.backgroundColor,
    ),
    textTheme: _textTheme,
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27.0),
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(
        borderColor: AppPallete.gradient2,
        width: 2,
      ),
      focusedErrorBorder: _inputBorder(
        borderColor: AppPallete.errorColor,
        width: 2,
      ),
      errorBorder: _inputBorder(
        borderColor: AppPallete.errorColor,
        width: 2,
      ),
      labelStyle: _textTheme.labelMedium?.copyWith(
        color: AppPallete.whiteColor,
      ),
    ),
  );
}
