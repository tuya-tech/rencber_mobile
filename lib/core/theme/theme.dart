import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent, overlayColor: Colors.transparent)),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        displayMedium: GoogleFonts.poppins(),
        displaySmall: GoogleFonts.poppins(fontSize: 23.sp, fontWeight: FontWeight.w600), //fontSize 36
        headlineLarge: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        headlineMedium: GoogleFonts.poppins(),
        headlineSmall: GoogleFonts.poppins(fontSize: 21.5.sp, fontWeight: FontWeight.w600), //fontSize 32
        titleLarge: GoogleFonts.poppins(fontSize: 17.5.sp, fontWeight: FontWeight.w500), //fontSize 20
        titleMedium: GoogleFonts.poppins(fontSize: 15.5.sp, fontWeight: FontWeight.normal), //fontSize 16
        titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        labelLarge: GoogleFonts.poppins(fontSize: 14.5.sp, fontWeight: FontWeight.w500), //fontSize 14
        labelMedium: GoogleFonts.poppins(),
        labelSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        bodyMedium: GoogleFonts.poppins(),
        bodySmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ));
}
