import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/medio_utiliza_ca/medio_utiliza_ca_db_usecase.dart';

import '../../../domain/entities/medio_utiliza_ca_entity.dart';

part 'medio_utiliza_ca_state.dart';

class MedioUtilizaCACubit extends Cubit<MediosUtilizaCAState> {
  final MedioUtilizaCAUsecaseDB medioUtilizaCAUsecaseDB;

  MedioUtilizaCACubit({required this.medioUtilizaCAUsecaseDB})
      : super(MediosUtilizaCAInitial());

  void getMediosUtilizaCA() async {
    final result = await medioUtilizaCAUsecaseDB.getMediosUtilizaCAUsecase();
    result.fold(
        (failure) => emit(MediosUtilizaCAError(failure.properties.first)),
        (data) => emit(MediosUtilizaCALoaded(data)));
  }
}
