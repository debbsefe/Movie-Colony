import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../cache/app_cache.dart';
import '../utils/strings.dart';

@LazySingleton()
class CustomTheme extends StateNotifier<ThemeData> {
  CustomTheme(this.appCache)
      : super(

            ///check current theme at app start
            /// and pass to the super-constructor
            appCache.retrieveString(Strings.theme) == Strings.darkTheme
                ? CustomTheme.darkThemeData
                : CustomTheme.lightThemeData);
  final AppCache appCache;

  ///change the theme by passing selected themeData and name of the theme
  void changeTheme(ThemeData themeData, String name) {
    if (state != themeData) {
      state = themeData;
      appCache.saveString(Strings.theme, name);
    }
  }

  static const Color scaffoldLight = Color(0xFFFFF9FA);
  static const Color scaffoldDark = Color(0xFF160105);

  ///PRIMARY COLORS, TINTS AND SHADES
  static const Color primaryColor = Color(0xFF8C1B2F);
  static const Color primaryTint1 = Color(0xFFE5798C);
  static const Color primaryTint2 = Color(0xFFED9FAD);
  static const Color primaryTint3 = Color(0xFFF4C5CE);
  static const Color primaryTint4 = Color(0xFFF8D9DE);
  static const Color primaryTint5 = Color(0xFFFBECEF);
  static const Color primaryShade1 = Color(0xFF2F0910);
  static const Color primaryShade2 = Color(0xFF380B13);
  static const Color primaryShade3 = Color(0xFF410D16);
  static const Color primaryShade4 = Color(0xFF54101C);
  static const Color primaryShade5 = Color(0xFF671422);

  ///secondary colors, tints and shades
  static const Color secondaryColor = Color(0xFF1B8C78);
  static const Color secondaryTint1 = Color(0xFF2CD6B8);
  static const Color secondaryTint2 = Color(0xFF52DEC5);
  static const Color secondaryTint3 = Color(0xFF79E5D2);
  static const Color secondaryTint4 = Color(0xFF8CE9D8);
  static const Color secondaryTint5 = Color(0xFFD9F8F2);
  static const Color secondaryShade1 = Color(0xFF051C18);
  static const Color secondaryShade2 = Color(0xFF092F28);
  static const Color secondaryShade3 = Color(0xFF0D4138);
  static const Color secondaryShade4 = Color(0xFF105448);
  static const Color secondaryShade5 = Color(0xFF146758);

  ///tmc grey colors
  static const Color greyColor1 = Color(0xFF4A1C24);
  static const Color greyColor2 = Color(0xFF806066);
  static const Color greyColor3 = Color(0xFFA58E92);
  static const Color greyColor4 = Color(0xFFB7A4A7);
  static const Color greyColor5 = Color(0xFFB7A4A7);
  static const Color greyColor6 = Color(0xFFC9BBBD);
  static const Color greyColor7 = Color(0xFFDBD2D3);

  ///generic colors
  static const Color successGreen = Color(0xFF1CAE4B);
  static const Color blueColor = Color(0xFF1F8CBD);
  static const Color errorRed = Color(0xFF9B1B33);
  static const Color orangeColor = Color(0xFFC8511B);
  static const Color yellowColor = Color(0xFFC9A717);
  static const Color buttonColor1 = Color(0xFFFBECEF);
  static const Color yellowStar = Color(0xFFF3CD2A);

  static ThemeData lightThemeData = ThemeData(
      primarySwatch: Colors.brown,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'NotoSansKR-Regular',
      scaffoldBackgroundColor: scaffoldLight,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      buttonColor: buttonColor1,
      cardColor: primaryTint5,
      appBarTheme: const AppBarTheme(
        titleTextStyle: bodyTextLight,
        elevation: 0,
        backgroundColor: scaffoldLight,
        iconTheme: IconThemeData(color: greyColor2),
      ),
      textTheme: lightTextTheme);

  static ThemeData darkThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'NotoSansKR-Regular',
    primarySwatch: Colors.brown,
    scaffoldBackgroundColor: scaffoldDark,
    brightness: Brightness.dark,
    primaryColor: scaffoldLight,
    buttonColor: buttonColor1,
    textTheme: darkTextTheme,
    cardColor: primaryShade2,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: scaffoldDark,
      titleTextStyle: bodyTextDark,
      iconTheme: IconThemeData(color: scaffoldLight),
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    subtitle1: subtitleRegDark,
    subtitle2: subtitle,
    headline4: headline4Dark,
    headline6: headline6Dark,
    caption: captionDark,
    bodyText1: bodyTextDark,
    bodyText2: bodyText2,
  );

  static TextTheme lightTextTheme = const TextTheme(
    subtitle1: subtitleRegLight,
    subtitle2: subtitle,
    headline4: headline4Light,
    headline6: headline6Light,
    caption: captionLight,
    bodyText1: bodyTextLight,
    bodyText2: bodyText2,
  );

  static const TextStyle bodyText2 = TextStyle(
    color: greyColor1,
    fontSize: 12,
  );
  static const TextStyle bodyTextLight = TextStyle(
    color: greyColor2,
    fontSize: 16,
  );

  static const TextStyle bodyTextDark = TextStyle(
    color: scaffoldLight,
    fontSize: 16,
  );

  static const TextStyle headline4Light = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: greyColor1,
  );

  static const TextStyle headline4Dark = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: scaffoldLight,
  );

  static const TextStyle headline6Light = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: greyColor1,
  );

  static const TextStyle headline6Dark = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: greyColor7,
  );

  static const TextStyle captionLight = TextStyle(
    fontSize: 10,
    color: greyColor2,
  );

  static const TextStyle captionDark = TextStyle(
    fontSize: 10,
    color: buttonColor1,
  );
  static const TextStyle subtitle = TextStyle(
    // subtitle -> subtitleLight
    fontSize: 12,
    color: greyColor4,
  );

  static const TextStyle subtitleRegLight = TextStyle(
    // subtitle1 -> subtitleRegular
    fontSize: 20,
    color: primaryColor,
  );

  static const TextStyle subtitleRegDark = TextStyle(
    // subtitle1 -> subtitleRegular
    fontSize: 20,
    color: scaffoldLight,
  );
}
