import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../domain/usecases/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_db_usecase.dart';

part 'tuberculo_platano_by_dpto_state.dart';

class TuberculoPlatanoByDptoCubit extends Cubit<TuberculosPlatanosByDptoState> {
  final TuberculoPlatanoByDptoUsecaseDB tuberculoPlatanoByDptoUsecaseDB;

  TuberculoPlatanoByDptoCubit({required this.tuberculoPlatanoByDptoUsecaseDB})
      : super(TuberculosPlatanosByDptoInitial());

  void getTuberculosPlatanosByDptoDB() async {
    final result = await tuberculoPlatanoByDptoUsecaseDB
        .getTuberculosPlatanosByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(TuberculosPlatanosByDptoError(failure.properties.first)),
        (data) => emit(TuberculosPlatanosByDptoLoaded(data)));
  }
}
