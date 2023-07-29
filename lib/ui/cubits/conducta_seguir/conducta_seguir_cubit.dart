import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/conducta_seguir_entity.dart';
import '../../../domain/usecases/conducta_seguir/conducta_seguir_db_usecase.dart';

part 'conducta_seguir_state.dart';

class ConductaSeguirCubit extends Cubit<ConductasSeguirState> {
  final ConductaSeguirUsecaseDB conductaSeguirUsecaseDB;

  ConductaSeguirCubit({required this.conductaSeguirUsecaseDB})
      : super(ConductasSeguirInitial());

  void getConductaSeguirDB() async {
    final result = await conductaSeguirUsecaseDB.getConductasSeguirUsecaseDB();
    result.fold(
        (failure) => emit(ConductasSeguirError(failure.properties.first)),
        (data) => emit(ConductasSeguirLoaded(data)));
  }
}
