import 'package:flutter/material.dart';

class AppColors {
  AppColors();

  AppColors._();

  static const _oylexWindowBackground = 0xfff3f5f9;
  static const _oylexPrimaryPrivate = 0xff37b1c6;
  static const _oylexPrimaryDarkPrivate = 0xff008195;
  static const _oylexAccentPrivate = 0xffC64C37;

  static const MaterialColor windowBackground = const MaterialColor(
    _oylexWindowBackground,
    const <int, Color>{
      500: const Color(_oylexWindowBackground),
      600: const Color(0xFFeef1f6),
      700: const Color(0xFFdee2e8),
      800: const Color(0xFFccd5e5),
      900: const Color(0xFFbbc6dd),
    },
  );

  static const MaterialColor oylexPrimary = const MaterialColor(
    _oylexPrimaryPrivate,
    const <int, Color>{
      50: const Color(0xFF9bd9e4),
      100: const Color(0xFF87d1de),
      200: const Color(0xFF73c9d9),
      300: const Color(0xFF5fc2d3),
      400: const Color(0xFF4bbace),
      500: const Color(_oylexPrimaryPrivate),
      600: const Color(0xFF31a1b4),
      700: const Color(0xFF2c8fa0),
      800: const Color(0xFF267d8c),
      900: const Color(0xFF216b78),
    },
  );

  static const MaterialColor oylexPrimaryDark = const MaterialColor(
    _oylexPrimaryDarkPrivate,
    const <int, Color>{
      50: const Color(0xFF00ddff),
      100: const Color(0xFF00c7e6),
      200: const Color(0xFF00b1cc),
      300: const Color(0xFF009bb3),
      400: const Color(0xFF008599),
      500: const Color(_oylexPrimaryDarkPrivate),
      600: const Color(0xFF006f80),
      700: const Color(0xFF005866),
      800: const Color(0xFF00424d),
      900: const Color(0xFF002c33),
    },
  );

  static const MaterialColor oylexAccent = const MaterialColor(
    _oylexAccentPrivate,
    const <int, Color>{
      50: const Color(0xFFe4a69b),
      100: const Color(0xFFde9487),
      200: const Color(0xFFd98273),
      300: const Color(0xFFd3705f),
      400: const Color(0xFFce5e4b),
      500: const Color(_oylexAccentPrivate),
      600: const Color(0xFFb44531),
      700: const Color(0xFFa03d2c),
      800: const Color(0xFF8c3626),
      900: const Color(0xFF782e21),
    },
  );

  Color hexToColor(String hex) {
    return new Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
