part of 'slider_cubit.dart';

class SliderState extends Equatable {
  final double currentPage;
  final double bulletPrimario;
  final double bulletSecundario;
  const SliderState(
      this.currentPage, this.bulletPrimario, this.bulletSecundario);

  @override
  List<Object> get props => [currentPage, bulletPrimario, bulletSecundario];
}

class SliderInitial extends SliderState {
  const SliderInitial() : super(0, 0, 0);
}

class SliderChanged extends SliderState {
  final double currentPageChanged;
  final double bulletPrimarioChanged;
  final double bulletSecundarioChanged;
  const SliderChanged(this.currentPageChanged, this.bulletPrimarioChanged,
      this.bulletSecundarioChanged)
      : super(
            currentPageChanged, bulletPrimarioChanged, bulletSecundarioChanged);
}
