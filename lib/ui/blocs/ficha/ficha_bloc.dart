import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/estadistica.dart';
import '../../../domain/entities/ficha.dart';
import '../../../domain/usecases/ficha/ficha_db_usecase.dart';

part 'ficha_event.dart';
part 'ficha_state.dart';

class FichaBloc extends Bloc<FichaEvent, FichasState> {
  final FichaUsecaseDB fichaUsecaseDB;
  FichaBloc({required this.fichaUsecaseDB}) : super(FichasInitial()) {
    on<LoadFichas>((event, emit) async {
      emit(FichasLoading());
    });
    on<LoadFichasSincronizadas>((event, emit) async {
      emit(FichasLoading());
      final result = await fichaUsecaseDB.loadFichasSincronizadasUsecaseDB();
      result.fold(
          (failure) => emit(const FichasError('Error al cargar los datos')),
          (data) => emit(FichasLoaded(data)));
    });
  }

  Future<List<FichaEntity>> loadFichas(int familiaId) async {
    final result = await fichaUsecaseDB.loadFichasUsecaseDB(familiaId);
    return result.fold((failure) => [], (data) => data);
  }

  Future<List<EstadisticaEntity>> loadEstadisticas() async {
    final result = await fichaUsecaseDB.loadEstadisticasUsecaseDB();
    return result.fold((failure) => [], (data) => data);
  }
}
