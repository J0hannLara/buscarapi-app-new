import 'package:flutter/material.dart';
import 'config.dart'; // Importa tu Config donde tengas los colores

final ThemeData lightTheme = ThemeData(
  fontFamily: 'Oswald',
  brightness: Brightness.light,
  scaffoldBackgroundColor: Config.lightBackgroundColor,
  primaryColor: Config.lightPrimaryColor,
  colorScheme: ColorScheme.light(
    primary: Config.lightPrimaryColor,
    secondary: Config.lightSecondaryColor,
    background: Config.lightBackgroundColor,
    surface: Config.lightBackgroundColor,
    onPrimary: Config.lightTextPrimaryColor,
    onSecondary: Config.lightAccentColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Config.lightPrimaryColor,
    foregroundColor: Config.lightTextPrimaryColor, 
    elevation: 0,
  ),
  iconTheme: IconThemeData(
    color: Config.lightAccentColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(color: Config.lightTextPrimaryColor),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Config.lightPrimaryColor,
    selectedItemColor: Config.lightSecondaryColor,
    unselectedItemColor: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  fontFamily: 'Oswald',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Config.darkBackgroundColor,
  primaryColor: Config.darkPrimaryColor,
  colorScheme: ColorScheme.dark(
    primary: Config.darkPrimaryColor,
    secondary: Config.darkSecondaryColor,
    background: Config.darkBackgroundColor,
    surface: Config.darkBackgroundColor,
    onPrimary: Config.darkTextPrimaryColor,
    onSecondary: Config.darkAccentColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Config.darkPrimaryColor,
    foregroundColor: Config.darkTextPrimaryColor, // Texto de AppBar
    elevation: 0,
  ),
  iconTheme: IconThemeData(
    color: Config.darkAccentColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(color: Config.darkTextPrimaryColor),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Config.darkPrimaryColor,
    selectedItemColor: Config.darkSecondaryColor,
    unselectedItemColor: Colors.white,
  ),
);
