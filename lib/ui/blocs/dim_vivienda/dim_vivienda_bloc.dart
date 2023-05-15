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
            formStatus: SubmissionFailed(failure.properties.first)));
      }, (data) => emit(state.copyWith(formStatus: SubmissionSuccess())));
    });

    on<GetDimVivienda>((event, emit) async {
      final result =
          await dimViviendaUsecaseDB.getDimViviendaUsecaseDB(event.familiaId);
      result.fold(
          (failure) => emit(state.copyWith(
              formStatus: SubmissionFailed(failure.properties.first))), (data) {
        if (data != null) {
          emit(data.copyWith(formStatus: FormLoaded()));
        } else {
          emit(state.copyWith(formStatus: FormEmpty()));
        }
      });
    });

    on<DatoViviendaChanged>((event, emit) {
      emit(state.copyWith(datoViviendaId: event.datoViviendaId));
    });
    on<FamiliaChanged>((event, emit) {
      emit(state.copyWith(familiaId: event.familiaId));
    });
    on<TipoVivienda>((event, emit) {
      emit(state.copyWith(tipoViviendaId: event.tipoViviendaId));
    });
    on<TenenciaViviendaChanged>((event, emit) {
      emit(state.copyWith(tenenciaViviendaId: event.tenenciaViviendaId));
    });
    on<PisoViviendaChanged>((event, emit) {
      emit(state.copyWith(pisoViviendaId: event.pisoViviendaId));
    });
    on<OtroTipoPisoChanged>((event, emit) {
      emit(state.copyWith(otroTipoPiso: event.otroTipoPiso));
    });
    on<TechoViviendaChanged>((event, emit) {
      emit(state.copyWith(techoViviendaId: event.techoViviendaId));
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
    on<ServicioPublicoViviendaChanged>((event, emit) {
      emit(state.copyWith(
          servicioPublicoViviendaId: event.servicioPublicoViviendaId));
    });
    on<TratamientoAguaViviendaChanged>((event, emit) {
      emit(state.copyWith(
          tratamientoAguaViviendaId: event.tratamientoAguaViviendaId));
    });
    on<TipoSanitarioViviendaChanged>((event, emit) {
      emit(state.copyWith(
          tipoSanitarioViviendaId: event.tipoSanitarioViviendaId));
    });
    on<OtroTipoSanitarioChanged>((event, emit) {
      emit(state.copyWith(otroTipoSanitario: event.otroTipoSanitario));
    });
    on<TipoCombustibleViviendaChanged>((event, emit) {
      emit(state.copyWith(
          tipoCombustibleViviendaId: event.tipoCombustibleViviendaId));
    });
    on<OtroTipoCombustibleChanged>((event, emit) {
      emit(state.copyWith(otroTipoCombustible: event.otroTipoCombustible));
    });
    on<FactorRiesgoViviendaChanged>((event, emit) {
      emit(
          state.copyWith(factorRiesgoViviendaId: event.factorRiesgoViviendaId));
    });
    on<PresenciaAnimalViviendaChanged>((event, emit) {
      emit(state.copyWith(
          presenciaAnimalViviendaId: event.presenciaAnimalViviendaId));
    });
    on<OtroPresenciaAnimalChanged>((event, emit) {
      emit(state.copyWith(otroPresenciaAnimal: event.otroPresenciaAnimal));
    });
  }
}
