import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/entities/via_acceso_entity.dart';

import '../../../domain/usecases/via_acceso/via_acceso_db_usecase.dart';

part 'via_acceso_state.dart';

class ViaAccesoCubit extends Cubit<ViasAccesoState> {
  final ViaAccesoUsecaseDB viaAccesoUsecaseDB;

  ViaAccesoCubit({required this.viaAccesoUsecaseDB})
      : super(ViasAccesoInitial()) {
    getViasAccesoDB();
  }

  void getViasAccesoDB() async {
    final result = await viaAccesoUsecaseDB.getViasAccesoUsecaseDB();
    result.fold((failure) => emit(ViasAccesoError(failure.properties.first)),
        (data) => emit(ViasAccesoLoaded(data)));
  }
}
