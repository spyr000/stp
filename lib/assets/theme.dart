import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final applicationTheme = ThemeData(
    actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => BackButton(
              color: Colors.grey[500],
            )),
    primaryColor: Colors.red[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.red[50],
      surfaceTintColor: Colors.redAccent,
      actionsIconTheme: IconThemeData(color: Colors.grey[700]),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.deepOrange,
      tertiary: Colors.pinkAccent,
      background: Colors.red[50],
      surfaceTint: Colors.redAccent,
    ),
    cardColor: Colors.red[100],
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserrat(
          textStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      )),
      bodyMedium: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
        ),
      ),
      bodySmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[700],
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.deepOrange.withOpacity(0.04);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return Colors.deepOrange.withOpacity(0.12);
            }
            return null;
          },
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.deepOrange.withOpacity(0.04);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return Colors.deepOrange.withOpacity(0.12);
            }
            return null;
          },
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
      labelStyle: TextStyle(
        color: Colors.deepOrange.withOpacity(0.5),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.deepOrange,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.deepOrange,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.deepOrange.withOpacity(0.04);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return Colors.deepOrange.withOpacity(0.12);
          }
          return null;
        },
      ),
    ),
    snackBarTheme: const SnackBarThemeData(actionTextColor: Colors.deepOrange));
