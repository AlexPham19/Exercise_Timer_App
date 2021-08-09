import 'dart:ui' show Color;

import 'package:flutter/material.dart';

class Themes {
  static const Color appBarTheme = Color.fromRGBO(246, 48, 83, 1);
  static const Color background = Colors.white;

  //------ THEME FOR WELCOME PAGES -----//

  static const Color exerciseThemeMain = Color.fromRGBO(230, 250, 239, 1);
  static const Color exerciseIconMain = Color.fromRGBO(82, 229, 163, 1);
  static const Color exerciseDialogTheme = Color.fromRGBO(93, 228, 162, 1);

  static const Color restThemeMain = Color.fromRGBO(250, 223, 228, 1);
  static const Color restIconMain = Color.fromRGBO(224, 60, 91, 1);
  static const Color restDialogTheme = Color.fromRGBO(244, 46, 82, 1);

  static const Color numberExerciseThemeMain = Color.fromRGBO(234, 235, 237, 1);
  static const Color numberExerciseIconMain = Color.fromRGBO(124, 123, 129, 1);
  static const Color numberExerciseDialogTheme =
      Color.fromRGBO(124, 123, 129, 1);

  static const Color numberRepetitionsThemeMain =
      Color.fromRGBO(231, 232, 250, 1);
  static const Color numberRepetitionsIconMain =
      Color.fromRGBO(111, 129, 214, 1);
  static const Color numberRepetitionsDialogTheme =
      Color.fromRGBO(98, 120, 240, 1);

  static const Color timeToChangeRepThemeMain =
      Color.fromRGBO(254, 245, 230, 1);
  static const Color timeToChangeRepIconMain = Color.fromRGBO(234, 210, 117, 1);
  static const Color timeToChangeRepDialogTheme =
      Color.fromRGBO(244, 206, 99, 1);

  // -------- THEME FOR EXERCISE PAGES -------------//
  static const Color readyThemeStart =
      Color.fromRGBO(251, 204, 86, 1); // gradient
  static const Color readyThemeEnd = Color.fromRGBO(251, 204, 86, 1);
  static const Color readyTimerBorder = Color.fromRGBO(218, 141, 30, 1);

  static const Color exerciseThemeStart = Color.fromRGBO(92, 227, 161, 1);
  static const Color exerciseThemeEnd = Color.fromRGBO(81, 203, 144, 1);
  static const Color exerciseTimerBorder = Color.fromRGBO(75, 197, 138, 1);

  static const Color restThemeStart = Color.fromRGBO(252, 104, 83, 1);
  static const Color restThemeEnd = Color.fromRGBO(241, 15, 81, 1);
  static const Color restTimerBorder = Color.fromRGBO(226, 71, 76, 1);

  static const Color wordExercise = Color(0xFFF2F2F2);

  // ------------- THEME FOR CUSTOM EXERCISE -------------- //

  static const Color customExerciseBorder = Color.fromRGBO(144, 145, 146, 1.0);
  static const Color customExerciseInactiveButton =
      Color.fromRGBO(210, 208, 208, 1.0);

  // --------------OTHER-------------------//
  static TextStyle textOptions =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
}
