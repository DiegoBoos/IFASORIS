import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/resguardo_entity.dart';
import '../../../domain/usecases/resguardo_by_dpto/resguardo_by_dpto_db_usecase.dart';

part 'resguardo_by_dpto_state.dart';

class ResguardoByDptoCubit extends Cubit<ResguardosByDptoState> {
  final ResguardoByDptoUsecaseDB resguardoByDptoUsecaseDB;

  ResguardoByDptoCubit({required this.resguardoByDptoUsecaseDB})
      : super(ResguardosByDptoInitial());

  void getResguardosByDptoDB() async {
    final result =
        await resguardoByDptoUsecaseDB.getResguardosByDptoUsecaseDB();
    result.fold(
        (failure) => emit(ResguardosByDptoError(failure.properties.first)),
        (data) => emit(ResguardosByDptoLoaded(data)));
  }
}
