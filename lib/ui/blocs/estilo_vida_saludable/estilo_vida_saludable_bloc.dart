import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/estilo_vida_saludable_entity.dart';
import '../../../domain/usecases/estilo_vida_saludable/estilo_vida_saludable_db_usecase.dart';

part 'estilo_vida_saludable_event.dart';
part 'estilo_vida_saludable_state.dart';

class EstiloVidaSaludableBloc
    extends Bloc<EstiloVidaSaludableEvent, EstiloVidaSaludableEntity> {
  final EstiloVidaSaludableUsecaseDB estiloVidaSaludableUsecaseDB;

  EstiloVidaSaludableBloc({required this.estiloVidaSaludableUsecaseDB})
      : super(initObject()) {
    on<EstiloVidaSaludableInit>((event, emit) {
      emit(initObject());
    });

    on<EstiloVidaSaludableSubmitted>((event, emit) async {
      final result = await estiloVidaSaludableUsecaseDB
          .saveEstiloVidaSaludableUsecaseDB(event.estiloVidaSaludable);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                EstiloVidaSaludableSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(
            state.copyWith(formStatus: EstiloVidaSaludableSubmissionSuccess()));
      });
    });

    on<GetEstiloVidaSaludable>((event, emit) async {
      final result = await estiloVidaSaludableUsecaseDB
          .getEstiloVidaSaludableUsecaseDB(event.afiliadoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus:
                EstiloVidaSaludableSubmissionFailed(failure.properties.first)));
      }, (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: EstiloVidaSaludableFormLoaded()));
        } else {
          emit(state.copyWith(formStatus: EstiloVidaSaludableFormEmpty()));
        }
      });
    });

    on<ActividadFisicaChanged>((event, emit) {
      emit(state.copyWith(actividadFisicaId: event.actividadFisicaId));
    });
    on<AlimentacionChanged>((event, emit) {
      emit(state.copyWith(alimentacionId: event.alimentacionId));
    });
    on<ConsumeCigarrilloChanged>((event, emit) {
      emit(state.copyWith(consumeCigarrillo: event.consumeCigarrillo));
    });
    on<NumeroCigarrillosDiaChanged>((event, emit) {
      emit(state.copyWith(numeroCigarrilloDiaId: event.numeroCigarrilloDiaId));
    });
    on<ConsumoAlcoholChanged>((event, emit) {
      emit(state.copyWith(consumoAlcoholId: event.consumoAlcoholId));
    });
    on<ConsumoSustanciasChanged>((event, emit) {
      emit(state.copyWith(
          consumoSustanciasPsicoactivas: event.consumoSustanciasPsicoactivas));
    });
  }
}
