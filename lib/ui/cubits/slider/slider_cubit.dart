import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/slider_model.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  void initState() {
    emit(SliderInitial());
  }

  void updatePageController(PageController pageController) {
    emit(
      SliderChanged(state.sliderModel.copyWith(
        pageController: pageController,
      )),
    );
  }

  void updateCurrentPage(int newCurrentPage) async {
    emit(
      SliderChanged(state.sliderModel.copyWith(
        currentPage: newCurrentPage,
      )),
    );

    await state.sliderModel.pageController.animateToPage(
      newCurrentPage.round(),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
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
