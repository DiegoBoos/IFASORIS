import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/evento_costumbre_participa_model.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/usecases/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_db_usecase.dart';

part 'dimension_sociocultural_pueblos_indigenas_event.dart';
part 'dimension_sociocultural_pueblos_indigenas_state.dart';

class DimensionSocioculturalPueblosIndigenasBloc extends Bloc<
    DimensionSocioculturalPueblosIndigenasEvent,
    DimensionSocioculturalPueblosIndigenasEntity> {
  final DimensionSocioculturalPueblosIndigenasUsecaseDB
      dimensionSocioculturalPueblosIndigenasUsecaseDB;

  DimensionSocioculturalPueblosIndigenasBloc(
      {required this.dimensionSocioculturalPueblosIndigenasUsecaseDB})
      : super(initObject()) {
    on<DimensionSocioculturalPueblosIndigenasInit>((event, emit) {
      emit(initObject());
    });

    on<DimensionSocioculturalPueblosIndigenasSubmitted>((event, emit) async {
      final result = await dimensionSocioculturalPueblosIndigenasUsecaseDB
          .saveDimensionSocioculturalPueblosIndigenasUsecaseDB(
              event.dimensionSocioculturalPueblosIndigenas);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimensionSocioculturalPueblosIndigenasSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            formStatus:
                DimensionSocioculturalPueblosIndigenasSubmissionSuccess()));
      });
    });

    on<GetDimensionSocioculturalPueblosIndigenas>((event, emit) async {
      final result = await dimensionSocioculturalPueblosIndigenasUsecaseDB
          .getDimensionSocioculturalPueblosIndigenasUsecaseDB(event.afiliadoId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimensionSocioculturalPueblosIndigenasSubmissionFailed(
                failure.properties.first)));
      }, (data) {
        if (data != null) {
          emit(data.copyWith(
              formStatus: DimensionSocioculturalPueblosIndigenasFormLoaded()));
        } else {
          emit(state.copyWith(
              formStatus: DimensionSocioculturalPueblosIndigenasFormEmpty()));
        }
      });
    });

    on<DimensionSocioculturalPuebloIndigenaChanged>((event, emit) {
      emit(state.copyWith(
          dimensionSocioculturalPueblosIndigenasId:
              event.dimensionSocioculturalPueblosIndigenasId));
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
}
