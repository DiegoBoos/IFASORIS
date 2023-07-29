import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/enfermedad_acude_entity.dart';
import '../../../domain/usecases/enfermedad_acude/enfermedad_acude_db_usecase.dart';

part 'enfermedad_acude_state.dart';

class EnfermedadAcudeCubit extends Cubit<EnfermedadesAcudeState> {
  final EnfermedadAcudeUsecaseDB enfermedadAcudeUsecaseDB;

  EnfermedadAcudeCubit({required this.enfermedadAcudeUsecaseDB})
      : super(EnfermedadesAcudeInitial());

  void getEnfermedadAcudeDB() async {
    final result =
        await enfermedadAcudeUsecaseDB.getEnfermedadesAcudeUsecaseDB();
    result.fold(
        (failure) => emit(EnfermedadesAcudeError(failure.properties.first)),
        (data) => emit(EnfermedadesAcudeLoaded(data)));
  }
}
