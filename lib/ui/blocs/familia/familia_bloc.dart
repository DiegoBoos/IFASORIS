import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/familia/familia_exports.dart';

import '../../../domain/entities/familia_entity.dart';

part 'familia_event.dart';
part 'familia_state.dart';

class FamiliaBloc extends Bloc<FamiliaEvent, FamiliasState> {
  final FamiliaUsecaseDB familiaUsecaseDB;
  FamiliaBloc({required this.familiaUsecaseDB}) : super(FamiliasInitial()) {
    on<LoadFamilias>((event, emit) async {
      emit(FamiliasLoading());
      await _loadFamilias(event, emit);
    });
  }

  _loadFamilias(event, emit) async {
    final result = await familiaUsecaseDB.loadFamiliasUsecaseDB();
    result.fold((failure) {
      emit(FamiliasError(failure.properties.first));
    }, (data) {
      emit(FamiliasLoaded(data));
    });
  }
}
