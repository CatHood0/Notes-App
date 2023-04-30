import 'package:flutter/material.dart';
import 'package:notes_project/enums.dart';
import 'constant.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      primaryIconTheme: IconThemeData(color: Colors.black),
      primarySwatch: MaterialColor(0xFefc3ff, const <int, Color>{
        50: const Color(0xFFefc3ff),
        100: const Color(0xFFefc3ff),
        200: const Color(0xFFefc3ff),
        300: const Color(0xFFefc3ff),
        400: const Color(0xFFefc3ff),
        500: const Color(0xFFefc3ff),
        600: const Color(0xFFefc3ff),
        700: const Color(0xFFefc3ff),
        800: const Color(0xFFefc3ff),
        900: const Color(0xFFefc3ff),
      }),
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: primaryColor,
        labelColor: primaryColor, 
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: buttonGeneralColor,
        splashColor: Colors.grey
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 5,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 69, 69, 69),
      ),
      textTheme: const TextTheme(
        titleSmall: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey, unselectedItemColor: Colors.white),
    ),
    AppTheme.lightTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white),
    ),
  };
}