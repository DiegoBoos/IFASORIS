import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/autoridad_indigena_entity.dart';
import '../../../domain/usecases/autoridad_indigena/autoridad_indigena_db_usecase.dart';

part 'autoridad_indigena_state.dart';

class AutoridadIndigenaCubit extends Cubit<AutoridadesIndigenasState> {
  final AutoridadIndigenaUsecaseDB autoridadIndigenaUsecaseDB;

  AutoridadIndigenaCubit({required this.autoridadIndigenaUsecaseDB})
      : super(AutoridadesIndigenasInitial());

  void getAutoridadesIndigenasDB() async {
    final result =
        await autoridadIndigenaUsecaseDB.getAutoridadesIndigenasUsecaseDB();
    result.fold(
        (failure) => emit(AutoridadesIndigenasError(failure.properties.first)),
        (data) => emit(AutoridadesIndigenasLoaded(data)));
  }
}
