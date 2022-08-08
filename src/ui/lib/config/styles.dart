import 'package:flutter/material.dart';


class Fonts {
  static const String primary = 'Roboto';
}


class Colors_ {
  static const Color accent = Color(0xFF0F59FA);
  static const Color info = Color(0xFF2C91FB);
  static const Color infoBg = Color(0xFFDAEEFC);
  static const Color infoBorder = Color(0xFFD3EAFB);
  static const Color success = Color(0xFF09AD95);
  static const Color successBg = Color(0xFF00E682);
  static const Color successBorder = Color(0xFFCAF9E4);
  static const Color warning = Color(0xFFF7B731);
  static const Color warningBg = Color(0xFFFCF3CF);
  static const Color warningBorder = Color(0xFFFBEEBC);
  static const Color danger = Color(0xFFF82649);
  static const Color dangerBg = Color(0xFFFF382B);
  static const Color dangerBorder = Color(0xFFFFDEDB);
  static const Color hover = Color(0xFFF8FBFF);
  static const Color primaryLightBg = Color(0xFFFFFFFF);
  static const Color secondaryLightBg = Color(0xFFF2F3F9);
  static const Color teriaryLightBg = Color(0xFFFFFFFF);
  static const Color primaryLightFont = Color(0xFF0D0C22);
  static const Color secondaryLightFont = Color(0xFF76839A);
  static const Color teriaryLightFont = Color(0xFF495584);
  static const Color quaternaryLightFont = Color(0xFFFFFFFF);
  static const Color primaryDarkBg = Color(0xFF30304D);
  static const Color secondaryDarkBg = Color(0xFF22223B);
  static const Color tertiaryDarkBg = Color(0xFF2E2E4A);
  static const Color primaryDarkFont = Color(0xFFDEDEFD);
  static const Color secondaryDarkFont = Color(0xFF77778E);
  static const Color tertiaryDarkFont = Color(0xFFDEDEFD);
  static const Color quaternaryDarkFont = Color(0xFFFFFFFF);
  static const Color primaryBorder = Color(0xFFD8D8D8);
  static const Color primaryShadow = Color(0xFFC4CDEB);
  static const Color secondaryShadow = Color(0xFFEFC2C9);
  static const Color tertiaryShadow = Color(0xFFE4CBFB);
  static const Color quaternaryShadow = Color(0xFF99DAEA);
  static const Color lightShadow = Color(0xFF040407);
  static const Color darkShadow = Color(0xFF1A1A2F);
}


class Gradients {
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF9070FF), Color(0xFFFF5D9E)]
  );
  static const LinearGradient secondary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF9E88F5), Color(0xFF6259ca)]
  );
  static const LinearGradient tertiary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFFF1BF64), Color(0xFFF71D36)]
  );
  static const LinearGradient quaternary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF4BE8D4), Color(0xFF129BD2)]
  );
}


class Shadows {
  static const BoxShadow light = BoxShadow(
    color: Color(0xFFD3D3D3),
    spreadRadius: 3.0,
    blurRadius: 2.0,
    offset: Offset(3.0, 2.0)
  );
  static const BoxShadow dark = BoxShadow(
    color: Color(0xFF1A1A2F),
    spreadRadius: 3.0,
    blurRadius: 2.0,
    offset: Offset(3.0, 2.0)
  );
}
