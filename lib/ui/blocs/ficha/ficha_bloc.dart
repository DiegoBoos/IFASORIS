import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/ficha/ficha_exports.dart';

part 'ficha_event.dart';
part 'ficha_state.dart';

class FichaBloc extends Bloc<FichaEvent, FichasState> {
  final FichaUsecaseDB fichaUsecaseDB;
  FichaBloc({required this.fichaUsecaseDB}) : super(FichasInitial()) {
    on<LoadFichas>((event, emit) async {
      emit(FichasLoading());
    });
    on<LoadFichasDiligenciadas>((event, emit) async {
      emit(FichasLoading());
      final result = await fichaUsecaseDB
          .loadFichasDiligenciadasUsecaseDB(event.familiaId);
      return result.fold((failure) => [], (data) => data);
    });
  }

  Future<List<FichaEntity>> loadFichas(int familiaId) async {
    final result = await fichaUsecaseDB.loadFichasUsecaseDB(familiaId);
    return result.fold((failure) => [], (data) => data);
  }

  Future<List<FichaEntity>> loadFichasDiligenciadas(int familiaId) async {
    final result =
        await fichaUsecaseDB.loadFichasDiligenciadasUsecaseDB(familiaId);
    return result.fold((failure) => [], (data) => data);
  }
}
