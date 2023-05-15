import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/iluminacion_vivienda_entity.dart';
import '../../../domain/usecases/iluminacion_vivienda/iluminacion_vivienda_db_usecase.dart';

part 'iluminacion_vivienda_state.dart';

class IluminacionViviendaCubit extends Cubit<IluminacionesViviendaState> {
  final IluminacionViviendaUsecaseDB iluminacionViviendaUsecaseDB;

  IluminacionViviendaCubit({required this.iluminacionViviendaUsecaseDB})
      : super(IluminacionesViviendaInitial());

  void getIluminacionesViviendaDB() async {
    final result =
        await iluminacionViviendaUsecaseDB.getIluminacionesViviendaUsecaseDB();
    result.fold(
        (failure) => emit(IluminacionesViviendaError(failure.properties.first)),
        (data) => emit(IluminacionesViviendaLoaded(data)));
  }
}
