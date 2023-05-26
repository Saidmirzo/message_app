import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  static const Color blue = Color(0xff3461FD);
  static const Color unActText = Color(0xff94A1C5);
  static const Color green = Color(0xff34B529);
  static const Color bgTextfield = Color(0xffF4F7FF);
  static const Color textfield = Color(0xff415077);

  // static Color nightBgClr = const Color(0xFF17171C);
  static Color lightBgClr = const Color(0xFFF1F2F3);
  static Color actionsClmnnClr = const Color(0xFF4B5EFC);
  static Color red = Colors.red;
  static Color indigo = Colors.indigo;
  // static Color actionsRowColor = const Color(0xFFD2D3DA);
  // static Color numbersClr = const Color(0xFF2E2F38);
  static Color lastAction = const Color(0xFF4E505F);
  static Color black = const Color(0xff000000);
  static Color white = const Color(0xffffffff);
  // static Color buttons3night = const Color(0xFF4E505F);
  // static Color buttons3day = const Color(0xFFD2D3DA);

  // static LinearGradient products = LinearGradient(
  //     begin: const Alignment(1, 2),
  //     colors: [Colors.white, Colors.blue.withOpacity(0.8)]);

  // static PrimaryColor primaryLight = const PrimaryColor(
  //   0xFF16A249,
  //   <int, Color>{
  //     100: Color(0xFF16A249),
  //     50: Color(0xFFF2FDF5),
  //   },
  // );

  // static BaseColor baseLight = BaseColor(
  //   0xFF16A249,
  //   <int, Color>{
  //     100: Colors.white,
  //     50: const Color(0xFFF4F4F4),
  //     80: Colors.white.withOpacity(.8),
  //     90: Colors.white.withOpacity(.9),
  //     40: Colors.white.withOpacity(.4),
  //     20: Colors.white.withOpacity(.2),
  //     10: Colors.white.withOpacity(.1),
  //     30: Colors.white.withOpacity(.3),
  //     60: Colors.white.withOpacity(.6),
  //   },
  // );

  // static MetalColor metalColor = MetalColor();
}

// class BaseColor extends ColorSwatch<int> {
//   const BaseColor(super.primary, super.swatch);

//   Color get shade100 => this[100]!;

//   Color get shade50 => this[50]!;

//   Color get shade40 => this[40]!;

//   Color get shade80 => this[80]!;

//   Color get shade20 => this[20]!;

//   Color get shade60 => this[60]!;
// }

// class PrimaryColor extends ColorSwatch<int> {
//   const PrimaryColor(super.primary, super.swatch);

//   Color get shade100 => this[100]!;

//   Color get shade50 => this[50]!;
// }

// class MetalColor extends ColorSwatch<int> {
//   MetalColor()
//       : super(
//           0xff111827,
//           <int, Color>{
//             // 200: const Color(0xffE5E7EB),
//             100: const Color(0xff111827),
//             90: const Color(0xff111827),
//             70: const Color(0xff111827).withOpacity(.7),
//             50: const Color(0xff6B7280),
//             40: const Color(0xff9CA3B0),
//             30: const Color(0xffD1D5DB),
//             10: const Color(0xffF3F4F6),
//           },
//         );

//   Color get shade100 => this[100]!;
//   Color get shade90 => this[90]!;
//   Color get shade70 => this[70]!;
//   Color get shade50 => this[50]!;
//   Color get shade40 => this[40]!;
//   Color get shade30 => this[30]!;
//   Color get shade10 => this[10]!;
// }
