import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roomie_radar/utils/app_colors.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    primaryColor: appPrimaryColor,
    primaryColorDark: appPrimaryColor,
    hoverColor: Colors.white54,
    dividerColor: viewLineColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: textPrimaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: appPrimaryColor,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    cardTheme: const CardTheme(color: whiteColor),
    cardColor: whiteColor,
    iconTheme: const IconThemeData(color: textPrimaryColor),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: appPrimaryColor, // Primary button color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Global button border radius
        ),
        foregroundColor: Colors.white, // Text and icon color
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: appPrimaryColor),
      titleLarge: TextStyle(color: textPrimaryColor),
      titleSmall: TextStyle(color: textSecondaryColor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(primary: appPrimaryColor)
        .copyWith(error: Colors.red),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: blackColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: appPrimaryColor,
      ),
    ),
    primaryColor: colorPrimaryBlack,
    dividerColor: const Color(0xFFDADADA).withOpacity(0.3),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    fontFamily: 'OpenSans',
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    cardTheme: const CardTheme(color: cardBackgroundBlackDark),
    cardColor: appSecondaryBackgroundColor,
    iconTheme: const IconThemeData(color: whiteColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            appPrimaryColor, // Primary button color (same in dark mode for consistency)
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Global button border radius
        ),
        foregroundColor: Colors.white, // Text and icon color
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: colorPrimaryBlack),
      titleLarge: TextStyle(color: whiteColor),
      titleSmall: TextStyle(color: Colors.white54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
            primary: appBackgroundColorDark, onPrimary: cardBackgroundBlackDark)
        .copyWith(secondary: whiteColor)
        .copyWith(error: const Color(0xFFCF6676)),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
