import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color colorTheme = Color(0xFF3366FF);

  static const Color lightColor = Color(0xFFFFFFFF);
  static const Color darkColor = Color(0xFF0d1117);

  static const String fontName = 'OpenSans';
  static const Color darkText = Color(0xFF17262A);
  static const Color lightText = Color(0xFFFFFFFF);
  static const Color lightModal = Color(0xFFFFFFFF);
  static const Color darkModal = Color(0xFF1a1a1b);
  static const Color buttonDisable = Color.fromRGBO(143, 155, 179, .24);
  static const Color buttonTextDisable = Color.fromRGBO(143, 155, 179, .48);
  static const Color danger = Color(0xFFFF0000);

  static const Color darkGrey = Color(0xFF3A5160);
  static const Color lightGrey = Color(0xFFF2F3F8);

  static final ThemeData light = ThemeData(
    platform: TargetPlatform.iOS,
    primaryColor: colorTheme,
    backgroundColor: lightColor,
    appBarTheme: AppBarTheme(
      color: lightColor,
      titleTextStyle: titleTextStyle,
      shadowColor: darkColor.withOpacity(0.7),
      iconTheme: const IconThemeData(color: darkColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorTheme,
      selectedIconTheme: const IconThemeData(
        color: lightColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: lightColor.withOpacity(0.7),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: lightModal,
    ),
    dividerTheme: DividerThemeData(
      color: darkColor.withOpacity(0.1),
      thickness: 1.0,
      indent: 65,
      endIndent: 10,
    ),
    colorScheme: ColorScheme.light(
      primary: darkColor.withOpacity(0.5),
      onPrimary: lightColor,
      primaryVariant: lightColor,
      secondary: colorTheme,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: darkColor.withOpacity(0.5),
      ),
      hintStyle: TextStyle(
        color: darkColor.withOpacity(0.5),
      ),
      errorStyle: const TextStyle(
        color: danger,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: danger,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: darkColor.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: colorTheme,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: colorTheme,
      backgroundColor: lightColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: colorTheme,
      disabledColor: buttonDisable,
      highlightColor: Colors.transparent,
      minWidth: 200.0,
      height: 48.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    toggleButtonsTheme: const ToggleButtonsThemeData(selectedColor: colorTheme),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    iconTheme: const IconThemeData(
      color: darkColor,
    ),
    textTheme: const TextTheme(
      headline1: headline1,
      headline4: headline4,
      headline5: headline5,
      headline6: headline6,
      subtitle1: subtitle1,
      subtitle2: subtitle2,
      bodyText1: body1,
      bodyText2: body2,
      caption: caption,
    ),
  );

  static final ThemeData dark = ThemeData(
    platform: TargetPlatform.iOS,
    primaryColor: colorTheme,
    scaffoldBackgroundColor: darkColor,
    backgroundColor: darkColor,
    appBarTheme: const AppBarTheme(
      color: darkColor,
      titleTextStyle: titleTextStyleDark,
      shadowColor: lightColor,
      iconTheme: IconThemeData(color: lightColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorTheme,
      selectedIconTheme: const IconThemeData(
        color: darkColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: darkColor.withOpacity(0.7),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkModal,
    ),
    dividerTheme: DividerThemeData(
      color: lightColor.withOpacity(0.1),
      thickness: 1.0,
      indent: 65,
      endIndent: 10,
    ),
    colorScheme: const ColorScheme.dark(
      primary: lightColor,
      onPrimary: darkColor,
      primaryVariant: darkColor,
      secondary: colorTheme,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: lightColor.withOpacity(0.3),
      ),
      hintStyle: TextStyle(
        color: lightColor.withOpacity(0.3),
      ),
      errorStyle: const TextStyle(
        color: danger,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: danger,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: lightColor.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: colorTheme,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: colorTheme,
      backgroundColor: darkColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: colorTheme,
      disabledColor: buttonDisable,
      highlightColor: Colors.transparent,
      minWidth: 200.0,
      height: 48.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    toggleButtonsTheme: const ToggleButtonsThemeData(selectedColor: colorTheme),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: lightColor,
    ),
    textTheme: const TextTheme(
      headline1: headline1Dark,
      headline4: headline4Dark,
      headline5: headline5Dark,
      headline6: headline6Dark,
      subtitle1: subtitle1Dark,
      subtitle2: subtitle2Dark,
      bodyText1: body1Dark,
      bodyText2: body2Dark,
      caption: captionDark,
    ),
  );

  // Light Text

  static const TextStyle titleTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    letterSpacing: 1.2,
    color: darkText,
  );

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    letterSpacing: 1.2,
    color: darkText,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.27,
    color: darkText,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkText,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.05,
    color: darkText,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: darkText,
  );

  // Dark Text

  static const TextStyle titleTextStyleDark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    letterSpacing: 1.2,
    color: lightText,
  );

  static const TextStyle headline1Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    letterSpacing: 1.2,
    color: lightText,
  );

  static const TextStyle headline4Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: lightText,
  );

  static const TextStyle headline5Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.27,
    color: lightText,
  );

  static const TextStyle headline6Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.18,
    color: lightText,
  );

  static const TextStyle subtitle1Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.05,
    color: lightText,
  );

  static const TextStyle subtitle2Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    letterSpacing: -0.04,
    color: lightText,
  );

  static const TextStyle body1Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: lightText,
  );

  static const TextStyle body2Dark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: lightText,
  );

  static const TextStyle captionDark = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText,
  );
}
