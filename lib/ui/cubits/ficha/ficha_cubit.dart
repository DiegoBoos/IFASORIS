import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/ficha.dart';
import '../../../domain/usecases/ficha/ficha_db_usecase.dart';

part 'ficha_state.dart';

class FichaCubit extends Cubit<FichaState> {
  final FichaUsecaseDB fichaUsecaseDB;
  FichaCubit({required this.fichaUsecaseDB}) : super(FichaInitial());

  void initState() => emit(FichaInitial());

  createFichaDB(FichaEntity ficha) async {
    final result = await fichaUsecaseDB.createFichaUsecaseDB(ficha);
    result.fold((failure) => emit(FichaError(failure.properties.first)),
        (data) => emit(FichaCreated(data)));
  }

  deleteFicha(int fichaId) async {
    final result = await fichaUsecaseDB.deleteFichaUsecaseDB(fichaId);
    result.fold((failure) => emit(FichaError(failure.properties.first)),
        (data) => emit(FichaInitial()));
  }
}
