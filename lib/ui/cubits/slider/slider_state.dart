part of 'slider_cubit.dart';

class SliderState extends Equatable {
  final SliderModel sliderModel;
  const SliderState(this.sliderModel);

  @override
  List<Object> get props => [sliderModel];
}

class SliderInitial extends SliderState {
  SliderInitial()
      : super(SliderModel(
          currentPage: 0,
          bulletPrimario: 0.0,
          bulletSecundario: 0.0,
        ));
}

class SliderChanged extends SliderState {
  final SliderModel sliderModelLoaded;
  const SliderChanged(this.sliderModelLoaded) : super(sliderModelLoaded);
}
