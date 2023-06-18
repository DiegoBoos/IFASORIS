import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/pueblo_indigena_entity.dart';
import '../../../domain/usecases/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_db_usecase.dart';

part 'pueblo_indigena_by_dpto_state.dart';

class PuebloIndigenaByDptoCubit extends Cubit<PueblosIndigenasByDptoState> {
  final PuebloIndigenaByDptoUsecaseDB puebloIndigenaByDptoUsecaseDB;

  PuebloIndigenaByDptoCubit({required this.puebloIndigenaByDptoUsecaseDB})
      : super(PueblosIndigenasByDptoInitial());

  void getPueblosIndigenasByDptoDB() async {
    final result = await puebloIndigenaByDptoUsecaseDB
        .getPueblosIndigenasByDptoUsecaseDB();
    result.fold(
        (failure) =>
            emit(PueblosIndigenasByDptoError(failure.properties.first)),
        (data) => emit(PueblosIndigenasByDptoLoaded(data)));
  }
}
