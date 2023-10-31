class SliderModel {
  final double currentPage;
  final double bulletPrimario;
  final double bulletSecundario;

  SliderModel(
      {required this.currentPage,
      required this.bulletPrimario,
      required this.bulletSecundario});

  SliderModel copyWith(
          {double? currentPage,
          double? bulletPrimario,
          double? bulletSecundario}) =>
      SliderModel(
        currentPage: currentPage ?? this.currentPage,
        bulletPrimario: bulletPrimario ?? this.bulletPrimario,
        bulletSecundario: bulletSecundario ?? this.bulletSecundario,
      );
}
