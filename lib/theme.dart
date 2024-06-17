import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: const TextStyle(
      fontSize: 28,
    ),
    displayMedium: const TextStyle(
      fontSize: 16,
    ),
    displaySmall: const TextStyle(
      fontSize: 12,
    ),
  ),
);
