import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(const SliderInitial());

  void updateCurrentPage(double newCurrentPage) {
    final currentState = state as SliderChanged;
    final newState = SliderChanged(
      newCurrentPage,
      currentState.bulletPrimarioChanged,
      currentState.bulletSecundarioChanged,
    );
    emit(newState);
  }

  void updateBulletPrimatio(double bulletPrimario) {
    final currentState = state as SliderChanged;
    final newState = SliderChanged(
      currentState.currentPageChanged,
      bulletPrimario,
      currentState.bulletSecundarioChanged,
    );
    emit(newState);
  }

  void updateBulletSecundatio(double bulletSecundario) {
    final currentState = state as SliderChanged;
    final newState = SliderChanged(
      currentState.currentPageChanged,
      currentState.bulletPrimarioChanged,
      bulletSecundario,
    );
    emit(newState);
  }
}
