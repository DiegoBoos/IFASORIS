import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/evento_costumbre_participa.dart';

import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas.dart';
import '../../../domain/usecases/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_db_usecase.dart';
import '../../../domain/usecases/evento_costumbre_participa/evento_costumbre_participa_db_usecase.dart';

part 'dimension_sociocultural_pueblos_indigenas_event.dart';
part 'dimension_sociocultural_pueblos_indigenas_state.dart';

class DimensionSocioCulturalPueblosIndigenasBloc extends Bloc<
    DimensionSocioCulturalPueblosIndigenasEvent,
    DimensionSocioCulturalPueblosIndigenasEntity> {
  final DimensionSocioCulturalPueblosIndigenasUsecaseDB
      dimensionSocioCulturalPueblosIndigenasUsecaseDB;
  final EventoCostumbreParticipaUsecaseDB eventoCostumbreParticipaUsecaseDB;

  DimensionSocioCulturalPueblosIndigenasBloc(
      {required this.dimensionSocioCulturalPueblosIndigenasUsecaseDB,
      required this.eventoCostumbreParticipaUsecaseDB})
      : super(initObject()) {
    on<DimensionSocioCulturalPueblosIndigenasInit>((event, emit) {
      emit(initObject());
    });

    on<DimensionSocioCulturalPueblosIndigenasSubmitted>((event, emit) async {
      emit(state.copyWith(
          formStatus: DimensionSocioCulturalPueblosIndigenasFormLoading()));
      final result = await dimensionSocioCulturalPueblosIndigenasUsecaseDB
          .saveDimensionSocioCulturalPueblosIndigenasUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimensionSocioCulturalPueblosIndigenasSubmissionFailed(
                failure.properties.first)));
      }, (data) async => await saveAsp6EventosCostumbresParticipa(data));
    });

    on<GetDimensionSocioCulturalPueblosIndigenas>((event, emit) async {
      emit(state.copyWith(
          formStatus: DimensionSocioCulturalPueblosIndigenasFormLoading()));
      final result = await dimensionSocioCulturalPueblosIndigenasUsecaseDB
          .getDimensionSocioCulturalPueblosIndigenasUsecaseDB(event.afiliadoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimensionSocioCulturalPueblosIndigenasSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        if (data != null) {
          emit(data);
          add(GetEventosCostumbresParticipa(
              data.dimSocioCulturalPueblosIndigenasId));
        } else {
          emit(initObject().copyWith(
              formStatus: DimensionSocioCulturalPueblosIndigenasFormEmpty()));
        }
      });
    });

    on<GetEventosCostumbresParticipa>((event, emit) async {
      emit(state.copyWith(
          formStatus: DimensionSocioCulturalPueblosIndigenasFormLoading()));
      final result = await eventoCostumbreParticipaUsecaseDB
          .getAsp6EventosCostumbresParticipaUsecaseDB(
              event.dimSocioCulturalPueblosIndigenasId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimensionSocioCulturalPueblosIndigenasSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            lstEventoCostumbreParticipa: data,
            formStatus: DimensionSocioCulturalPueblosIndigenasFormLoaded()));
      });
    });

    on<DimensionSocioCulturalPueblosIndigenasFormSubmissionSuccess>(
        (event, emit) {
      emit(state.copyWith(
        dimSocioCulturalPueblosIndigenasId:
            event.dimSocioCulturalPueblosIndigenasId,
        formStatus: DimensionSocioCulturalPueblosIndigenasSubmissionSuccess(),
      ));
    });

    on<DimensionSocioCulturalPueblosIndigenasChanged>((event, emit) {
      emit(state.copyWith(
          dimSocioCulturalPueblosIndigenasId:
              event.dimSocioCulturalPueblosIndigenasId));
    });
    on<AfiliadoChanged>((event, emit) {
      emit(state.copyWith(afiliadoId: event.afiliadoId));
    });
    on<FamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });
    on<ConoceUsosCostumbresChanged>((event, emit) {
      emit(
          state.copyWith(conoceUsosCostumbresId: event.conoceUsosCostumbresId));
    });
    on<CostumbrePracticaChanged>((event, emit) {
      emit(state.copyWith(costumbrePracticaId: event.costumbrePracticaId));
    });
    on<JusticiaSancionaChanged>((event, emit) {
      emit(state.copyWith(sancionJusticiaId: event.sancionJusticiaId));
    });
    on<SitioSagradoChanged>((event, emit) {
      emit(state.copyWith(sitiosSagradosId: event.sitiosSagradosId));
    });
    on<ReligionProfesaChanged>((event, emit) {
      emit(state.copyWith(religionProfesaId: event.religionProfesaId));
    });
    on<CualesUsosCostumbresChanged>((event, emit) {
      emit(state.copyWith(cualesUsosCostumbres: event.cualesUsosCostumbres));
    });
    on<ParticipaCostumbresChanged>((event, emit) {
      emit(state.copyWith(participaCostumbresId: event.participaCostumbresId));
    });
    on<EventosCostumbresParticipaChanged>((event, emit) {
      emit(state.copyWith(
          lstEventoCostumbreParticipa: event.lstEventoCostumbreParticipa));
    });
    on<SancionJusticiaChanged>((event, emit) {
      emit(state.copyWith(sancionJusticiaId: event.sancionJusticiaId));
    });
    on<CualesSitiosSagradosChanged>((event, emit) {
      emit(state.copyWith(cualesSitiosSagrados: event.cualesSitiosSagrados));
    });
  }

  Future<void> saveAsp6EventosCostumbresParticipa(
    int dimSocioCulturalPueblosIndigenasId,
  ) async {
    final result = await eventoCostumbreParticipaUsecaseDB
        .saveAsp6EventosCostumbresParticipaUsecaseDB(
            dimSocioCulturalPueblosIndigenasId,
            state.lstEventoCostumbreParticipa!);
    result.fold((failure) {
      add(DimensionSocioCulturalPueblosIndigenasFormSubmissionFailed(
          failure.properties.first));
    }, (data) {
      add(DimensionSocioCulturalPueblosIndigenasFormSubmissionSuccess(
          dimSocioCulturalPueblosIndigenasId));
    });
  }
}
