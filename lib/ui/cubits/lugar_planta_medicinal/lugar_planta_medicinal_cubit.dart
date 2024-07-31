import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/lugar_planta_medicinal.dart';
import '../../../domain/usecases/lugar_planta_medicinal/lugar_planta_medicinal_db_usecase.dart';

part 'lugar_planta_medicinal_state.dart';

class LugarPlantaMedicinalCubit extends Cubit<LugaresPlantasMedicinalesState> {
  final LugarPlantaMedicinalUsecaseDB lugarPlantaMedicinalUsecaseDB;

  LugarPlantaMedicinalCubit({required this.lugarPlantaMedicinalUsecaseDB})
      : super(LugaresPlantasMedicinalesInitial());

  void getLugarPlantaMedicinalDB() async {
    final result = await lugarPlantaMedicinalUsecaseDB
        .getLugaresPlantasMedicinalesUsecaseDB();
    result.fold(
        (failure) =>
            emit(LugaresPlantasMedicinalesError(failure.properties.first)),
        (data) => emit(LugaresPlantasMedicinalesLoaded(data)));
  }
}
