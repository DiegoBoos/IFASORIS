import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/usecases/dim_vivienda/dim_vivienda_db_usecase.dart';

part 'dim_vivienda_event.dart';
part 'dim_vivienda_state.dart';

class DimViviendaBloc extends Bloc<DimViviendaEvent, DimViviendaEntity> {
  final DimViviendaUsecaseDB dimViviendaUsecaseDB;

  DimViviendaBloc({required this.dimViviendaUsecaseDB}) : super(initObject()) {
    on<DimViviendaInit>((event, emit) {
      emit(initObject());
    });

    on<DimViviendaSubmitted>((event, emit) async {
      final result = await dimViviendaUsecaseDB.saveDimViviendaUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(formStatus: DimViviendaSubmissionSuccess()));
      });
    });

    on<GetDimVivienda>((event, emit) async {
      final result =
          await dimViviendaUsecaseDB.getDimViviendaUsecaseDB(event.familiaId);
      result.fold(
          (failure) => emit(state.copyWith(
              formStatus:
                  DimViviendaSubmissionFailed(failure.properties.first))),
          (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: DimViviendaFormLoaded()));
        } else {
          emit(state.copyWith(formStatus: DimViviendaFormEmpty()));
        }
      });
    });

    on<DatoViviendaChanged>((event, emit) {
      emit(state.copyWith(datoViviendaId: event.datoViviendaId));
    });
    on<DimViviendaFamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });
    on<TipoViviendaChanged>((event, emit) {
      emit(state.copyWith(tipoViviendaId: event.tipoViviendaId));
    });
    on<TenenciaViviendaChanged>((event, emit) {
      emit(state.copyWith(tenenciaViviendaId: event.tenenciaViviendaId));
    });
    on<PisosViviendaChanged>((event, emit) {
      emit(state.copyWith(pisosViviendaIds: event.pisosViviendaIds));
    });
    on<OtroTipoPisoChanged>((event, emit) {
      emit(state.copyWith(otroTipoPiso: event.otroTipoPiso));
    });
    on<TechosViviendaChanged>((event, emit) {
      emit(state.copyWith(techosViviendaIds: event.techosViviendaIds));
    });
    on<OtroTipoTechoChanged>((event, emit) {
      emit(state.copyWith(otroTipoTecho: event.otroTipoTecho));
    });
    on<VentilacionViviendaChanged>((event, emit) {
      emit(state.copyWith(ventilacionViviendaId: event.ventilacionViviendaId));
    });
    on<IluminacionViviendaChanged>((event, emit) {
      emit(state.copyWith(iluminacionViviendaId: event.iluminacionViviendaId));
    });
    on<ServiciosPublicosViviendaChanged>((event, emit) {
      emit(state.copyWith(
          serviciosPublicosViviendaIds: event.serviciosPublicosViviendaIds));
    });
    on<TratamientoAguaViviendaChanged>((event, emit) {
      emit(state.copyWith(
          tratamientosAguaViviendaIds: event.tratamientosAguaViviendaIds));
    });
    on<TiposSanitarioViviendaChanged>((event, emit) {
      emit(state.copyWith(
          tiposSanitarioViviendaIds: event.tiposSanitarioViviendaIds));
    });
    on<OtroTipoSanitarioChanged>((event, emit) {
      emit(state.copyWith(otroTipoSanitario: event.otroTipoSanitario));
    });
    on<TiposCombustibleViviendaChanged>((event, emit) {
      emit(state.copyWith(
          tiposCombustibleViviendaIds: event.tiposCombustibleViviendaIds));
    });
    on<OtroTipoCombustibleChanged>((event, emit) {
      emit(state.copyWith(otroTipoCombustible: event.otroTipoCombustible));
    });
    on<FactoresRiesgoViviendaChanged>((event, emit) {
      emit(state.copyWith(
          factoresRiesgoViviendaIds: event.factoresRiesgoViviendaIds));
    });
    on<PresenciaAnimalesViviendaChanged>((event, emit) {
      emit(state.copyWith(
          presenciaAnimalesViviendaIds: event.presenciaAnimalesViviendaIds));
    });
    on<OtroPresenciaAnimalChanged>((event, emit) {
      emit(state.copyWith(otroPresenciaAnimal: event.otroPresenciaAnimal));
    });
  }
}
