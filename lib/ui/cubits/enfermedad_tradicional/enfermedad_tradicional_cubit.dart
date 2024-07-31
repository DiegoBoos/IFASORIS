import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/enfermedad_tradicional.dart';

import '../../../domain/entities/enfermedad_tradicional.dart';
import '../../../domain/usecases/enfermedad_tradicional/enfermedad_tradicional_db_usecase.dart';

part 'enfermedad_tradicional_state.dart';

class EnfermedadTradicionalCubit extends Cubit<EnfermedadesTradicionalesState> {
  final EnfermedadTradicionalUsecaseDB enfermedadTradicionalUsecaseDB;

  EnfermedadTradicionalCubit({required this.enfermedadTradicionalUsecaseDB})
      : super(EnfermedadesTradicionalesInitial());

  void getEnfermedadTradicionalDB() async {
    final result = await enfermedadTradicionalUsecaseDB
        .getEnfermedadesTradicionalesUsecaseDB();
    result.fold(
        (failure) =>
            emit(EnfermedadesTradicionalesError(failure.properties.first)),
        (data) => emit(EnfermedadesTradicionalesLoaded(data)));
  }

  Future<List<LstEnfermedadTradicional>>
      getEnfermedadesTradicionalesAtencionSaludDB(int? atencionSaludId) async {
    final result = await enfermedadTradicionalUsecaseDB
        .getEnfermedadesTradicionalesAtencionSaludUsecaseDB(atencionSaludId);
    return result.fold((failure) => [], (data) => data);
  }
}
