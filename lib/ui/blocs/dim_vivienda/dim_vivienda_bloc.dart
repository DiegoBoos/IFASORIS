import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/factor_riesgo_vivienda_model.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../../data/models/techo_vivienda_model.dart';
import '../../../data/models/tipo_combustible_vivienda_model.dart';
import '../../../data/models/tipo_sanitario_vivienda_model.dart';
import '../../../data/models/tratamiento_agua_vivienda_model.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/usecases/dim_vivienda/dim_vivienda_db_usecase.dart';
import '../../../domain/usecases/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_db_usecase.dart';
import '../../../domain/usecases/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_db_usecase.dart';
import '../../../domain/usecases/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_db_usecase.dart';
import '../../../domain/usecases/techo_vivienda_by_dpto/techo_vivienda_by_dpto_db_usecase.dart';
import '../../../domain/usecases/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_db_usecase.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_db_usecase.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_db_usecase.dart';

part 'dim_vivienda_event.dart';
part 'dim_vivienda_state.dart';

class DimViviendaBloc extends Bloc<DimViviendaEvent, DimViviendaEntity> {
  final DimViviendaUsecaseDB dimViviendaUsecaseDB;
  final FactorRiesgoViviendaByDptoUsecaseDB factorRiesgoViviendaByDptoUsecaseDB;
  final ServicioPublicoViviendaByDptoUsecaseDB
      servicioPublicoViviendaByDptoUsecaseDB;
  final TechoViviendaByDptoUsecaseDB techoViviendaByDptoUsecaseDB;
  final TipoCombustibleViviendaByDptoUsecaseDB
      tipoCombustibleViviendaByDptoUsecaseDB;
  final TipoSanitarioViviendaByDptoUsecaseDB
      tipoSanitarioViviendaByDptoUsecaseDB;
  final TratamientoAguaViviendaByDptoUsecaseDB
      tratamientoAguaViviendaByDptoUsecaseDB;
  final PresenciaAnimalViviendaByDptoUsecaseDB
      presenciaAnimalViviendaByDptoUsecaseDB;

  DimViviendaBloc({
    required this.dimViviendaUsecaseDB,
    required this.factorRiesgoViviendaByDptoUsecaseDB,
    required this.servicioPublicoViviendaByDptoUsecaseDB,
    required this.techoViviendaByDptoUsecaseDB,
    required this.tipoCombustibleViviendaByDptoUsecaseDB,
    required this.tipoSanitarioViviendaByDptoUsecaseDB,
    required this.tratamientoAguaViviendaByDptoUsecaseDB,
    required this.presenciaAnimalViviendaByDptoUsecaseDB,
  }) : super(initObject()) {
    on<DimViviendaInit>((event, emit) {
      emit(initObject());
    });

    on<DimViviendaSubmitted>((event, emit) async {
      final result = await dimViviendaUsecaseDB.saveDimViviendaUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) => saveFactoresRiesgoVivienda(data));
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

    on<DimViviendaFormSubmissionSuccess>((event, emit) {
      emit(state.copyWith(
          datoViviendaId: event.datoViviendaId,
          formStatus: DimViviendaSubmissionSuccess()));
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
    on<PisoViviendaChanged>((event, emit) {
      emit(state.copyWith(pisoViviendaId: event.pisoViviendaId));
    });
    on<OtroTipoPisoChanged>((event, emit) {
      emit(state.copyWith(otroTipoPiso: event.otroTipoPiso));
    });
    on<TechosViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTechos: event.lstTechos));
    });
    on<VentilacionViviendaChanged>((event, emit) {
      emit(state.copyWith(ventilacionViviendaId: event.ventilacionViviendaId));
    });
    /* on<IluminacionViviendaChanged>((event, emit) {
      emit(state.copyWith(iluminacionViviendaId: event.iluminacionViviendaId));
    }); */
    on<ServiciosPublicosViviendaChanged>((event, emit) {
      emit(state.copyWith(lstServPublicos: event.lstServPublicos));
    });
    on<TratamientoAguaViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTmtoAguas: event.lstTmtoAguas));
    });
    on<TiposSanitarioViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTiposSanitario: event.lstTiposSanitario));
    });
    on<TiposCombustibleViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTiposCombustible: event.lstTiposCombustible));
    });
    on<FactoresRiesgoViviendaChanged>((event, emit) {
      emit(state.copyWith(lstFactoresRiesgo: event.lstFactoresRiesgo));
    });
    on<PresenciaAnimalesViviendaChanged>((event, emit) {
      emit(state.copyWith(lstPresenciaAnimales: event.lstPresenciaAnimales));
    });
  }

  void saveFactoresRiesgoVivienda(int datoViviendaId) async {
    final result = await factorRiesgoViviendaByDptoUsecaseDB
        .saveFactoresRiesgoViviendaUsecaseDB(
            datoViviendaId, state.lstFactoresRiesgo!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => saveServiciosPublicosVivienda(datoViviendaId));
  }

  void saveServiciosPublicosVivienda(int datoViviendaId) async {
    final result = await servicioPublicoViviendaByDptoUsecaseDB
        .saveServiciosPublicosViviendaUsecaseDB(
            datoViviendaId, state.lstServPublicos!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => saveTechosVivienda(datoViviendaId));
  }

  void saveTechosVivienda(int datoViviendaId) async {
    final result = await techoViviendaByDptoUsecaseDB
        .saveTechosViviendaUsecaseDB(datoViviendaId, state.lstTechos!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => saveTiposCombustibleVivienda(datoViviendaId));
  }

  void saveTiposCombustibleVivienda(int datoViviendaId) async {
    final result = await tipoCombustibleViviendaByDptoUsecaseDB
        .saveTiposCombustibleViviendaUsecaseDB(
            datoViviendaId, state.lstTiposCombustible!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => saveTiposSanitarioVivienda(datoViviendaId));
  }

  void saveTiposSanitarioVivienda(int datoViviendaId) async {
    final result = await tipoSanitarioViviendaByDptoUsecaseDB
        .saveTiposSanitarioViviendaUsecaseDB(
            datoViviendaId, state.lstTiposSanitario!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => saveTmtoAguasVivienda(datoViviendaId));
  }

  void saveTmtoAguasVivienda(int datoViviendaId) async {
    final result = await tratamientoAguaViviendaByDptoUsecaseDB
        .saveTmtoAguasViviendaUsecaseDB(datoViviendaId, state.lstTmtoAguas!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => savePresenciaAnimalesVivienda(datoViviendaId));
  }

  void savePresenciaAnimalesVivienda(int datoViviendaId) async {
    final result = await presenciaAnimalViviendaByDptoUsecaseDB
        .savePresenciaAnimalesViviendaUsecaseDB(
            datoViviendaId, state.lstPresenciaAnimales!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => add(DimViviendaFormSubmissionSuccess(datoViviendaId)));
  }
}
