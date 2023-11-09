import 'package:flutter/material.dart';

class SliderModel {
  final PageController pageController;
  final int currentPage;
  final double bulletPrimario;
  final double bulletSecundario;

  SliderModel(
      {required this.pageController,
      required this.currentPage,
      required this.bulletPrimario,
      required this.bulletSecundario});

  SliderModel copyWith(
          {PageController? pageController,
          int? currentPage,
          double? bulletPrimario,
          double? bulletSecundario}) =>
      SliderModel(
        pageController: pageController ?? this.pageController,
        currentPage: currentPage ?? this.currentPage,
        bulletPrimario: bulletPrimario ?? this.bulletPrimario,
        bulletSecundario: bulletSecundario ?? this.bulletSecundario,
      );
}
