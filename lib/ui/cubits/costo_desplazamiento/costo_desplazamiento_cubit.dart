import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';

part 'costo_desplazamiento_state.dart';

class CostoDesplazamientoCubit extends Cubit<CostosDesplazamientoState> {
  final CostoDesplazamientoUsecaseDB costoDesplazamientoUsecaseDB;

  CostoDesplazamientoCubit({required this.costoDesplazamientoUsecaseDB})
      : super(CostosDesplazamientoInitial());

  void getCostosDesplazamientoDB() async {
    final result =
        await costoDesplazamientoUsecaseDB.getCostosDesplazamientoUsecase();
    result.fold(
        (failure) => emit(CostosDesplazamientoError(failure.properties.first)),
        (data) => emit(CostosDesplazamientoLoaded(data)));
  }
}
