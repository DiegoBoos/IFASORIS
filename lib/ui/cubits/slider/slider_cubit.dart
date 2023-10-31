import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/slider_model.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  void updateCurrentPage(double newCurrentPage) {
    emit(SliderChanged(
      state.sliderModel.copyWith(currentPage: newCurrentPage),
    ));
  }

  void updateBulletPrimario(double newBulletPrimario) {
    emit(SliderChanged(
      state.sliderModel.copyWith(bulletPrimario: newBulletPrimario),
    ));
  }

  void updateBulletSecundario(double newBulletSecundario) {
    emit(SliderChanged(
      state.sliderModel.copyWith(bulletSecundario: newBulletSecundario),
    ));
  }
}
