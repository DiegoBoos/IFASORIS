import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/religion_profesa.dart';
import '../../../domain/usecases/religion_profesa/religion_profesa_db_usecase.dart';

part 'religion_profesa_state.dart';

class ReligionProfesaCubit extends Cubit<ReligionesProfesaState> {
  final ReligionProfesaUsecaseDB religionProfesaUsecaseDB;

  ReligionProfesaCubit({required this.religionProfesaUsecaseDB})
      : super(ReligionesProfesaInitial());

  void getReligionProfesaDB() async {
    final result =
        await religionProfesaUsecaseDB.getReligionesProfesaUsecaseDB();
    result.fold(
        (failure) => emit(ReligionesProfesaError(failure.properties.first)),
        (data) => emit(ReligionesProfesaLoaded(data)));
  }
}
