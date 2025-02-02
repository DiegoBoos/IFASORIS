import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/planta_medicinal.dart';

import '../../../domain/entities/planta_medicinal.dart';
import '../../../domain/usecases/planta_medicinal/planta_medicinal_db_usecase.dart';

part 'planta_medicinal_state.dart';

class PlantaMedicinalCubit extends Cubit<PlantasMedicinalesState> {
  final PlantaMedicinalUsecaseDB plantaMedicinalUsecaseDB;

  PlantaMedicinalCubit({required this.plantaMedicinalUsecaseDB})
      : super(PlantasMedicinalesInitial());

  void getPlantasMedicinalesDB() async {
    final result =
        await plantaMedicinalUsecaseDB.getPlantasMedicinalesUsecaseDB();
    result.fold(
        (failure) => emit(PlantasMedicinalesError(failure.properties.first)),
        (data) => emit(PlantasMedicinalesLoaded(data)));
  }

  Future<List<LstPlantaMedicinal>> getPlantasMedicinalesAtencionSaludDB(
      int? atencionSaludId) async {
    final result = await plantaMedicinalUsecaseDB
        .getPlantasMedicinalesAtencionSaludUsecaseDB(atencionSaludId);
    return result.fold((failure) => [], (data) => data);
  }
}
