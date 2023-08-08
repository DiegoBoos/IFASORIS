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
import '../../../domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_db_usecase.dart';
import '../../../domain/usecases/presencia_animal_vivienda/presencia_animal_vivienda_db_usecase.dart';
import '../../../domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_db_usecase.dart';
import '../../../domain/usecases/techo_vivienda/techo_vivienda_db_usecase.dart';
import '../../../domain/usecases/tipo_combustible_vivienda/tipo_combustible_vivienda_db_usecase.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda/tipo_sanitario_vivienda_db_usecase.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda/tratamiento_agua_vivienda_db_usecase.dart';

part 'dim_vivienda_event.dart';
part 'dim_vivienda_state.dart';

class DimViviendaBloc extends Bloc<DimViviendaEvent, DimViviendaEntity> {
  final DimViviendaUsecaseDB dimViviendaUsecaseDB;
  final FactorRiesgoViviendaUsecaseDB factorRiesgoViviendaUsecaseDB;
  final ServicioPublicoViviendaUsecaseDB servicioPublicoViviendaUsecaseDB;
  final TechoViviendaUsecaseDB techoViviendaUsecaseDB;
  final TipoCombustibleViviendaUsecaseDB tipoCombustibleViviendaUsecaseDB;
  final TipoSanitarioViviendaUsecaseDB tipoSanitarioViviendaUsecaseDB;
  final TratamientoAguaViviendaUsecaseDB tratamientoAguaViviendaUsecaseDB;
  final PresenciaAnimalViviendaUsecaseDB presenciaAnimalViviendaUsecaseDB;

  DimViviendaBloc({
    required this.dimViviendaUsecaseDB,
    required this.factorRiesgoViviendaUsecaseDB,
    required this.servicioPublicoViviendaUsecaseDB,
    required this.techoViviendaUsecaseDB,
    required this.tipoCombustibleViviendaUsecaseDB,
    required this.tipoSanitarioViviendaUsecaseDB,
    required this.tratamientoAguaViviendaUsecaseDB,
    required this.presenciaAnimalViviendaUsecaseDB,
  }) : super(initObject()) {
    on<DimViviendaInit>((event, emit) {
      emit(initObject());
    });

    on<DimViviendaSubmitted>((event, emit) async {
      final result = await dimViviendaUsecaseDB.saveDimViviendaUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) async => await saveFactoresRiesgoVivienda(data));
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
          emit(data);
          add(GetTechosVivienda(data.datoViviendaId));
        } else {
          emit(state.copyWith(formStatus: DimViviendaFormEmpty()));
        }
      });
    });

    on<GetTechosVivienda>((event, emit) async {
      final result = await techoViviendaUsecaseDB
          .getTechosViviendaViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTechos: data));
        add(GetServiciosPublicosVivienda(event.datoViviendaId));
      });
    });

    on<GetServiciosPublicosVivienda>((event, emit) async {
      final result = await servicioPublicoViviendaUsecaseDB
          .getServiciosPublicosViviendaDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstServPublicos: data));
        add(GetTratamientosAguaVivienda(event.datoViviendaId));
      });
    });

    on<GetTratamientosAguaVivienda>((event, emit) async {
      final result = await tratamientoAguaViviendaUsecaseDB
          .getTratamientosAguaViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTmtoAguas: data));
        add(GetTiposSanitarioVivienda(event.datoViviendaId));
      });
    });

    on<GetTiposSanitarioVivienda>((event, emit) async {
      final result = await tipoSanitarioViviendaUsecaseDB
          .getTiposSanitarioViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTiposSanitario: data));
        add(GetTiposCombustibleVivienda(event.datoViviendaId));
      });
    });

    on<GetTiposCombustibleVivienda>((event, emit) async {
      final result = await tipoCombustibleViviendaUsecaseDB
          .getTiposCombustibleViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTiposCombustible: data));
        add(GetFactoresRiesgoVivienda(event.datoViviendaId));
      });
    });

    on<GetFactoresRiesgoVivienda>((event, emit) async {
      final result = await factorRiesgoViviendaUsecaseDB
          .getFactoresRiesgoViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstFactoresRiesgo: data));
        add(GetPresenciaAnimales(event.datoViviendaId));
      });
    });

    on<GetPresenciaAnimales>((event, emit) async {
      final result = await presenciaAnimalViviendaUsecaseDB
          .getPresenciaAnimalesViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            lstPresenciaAnimales: data, formStatus: DimViviendaFormLoaded()));
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
    on<TratamientosAguaViviendaChanged>((event, emit) {
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

  Future<void> saveFactoresRiesgoVivienda(int datoViviendaId) async {
    final result =
        await factorRiesgoViviendaUsecaseDB.saveFactoresRiesgoViviendaUsecaseDB(
            datoViviendaId, state.lstFactoresRiesgo!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveServiciosPublicosVivienda(datoViviendaId));
  }

  Future<void> saveServiciosPublicosVivienda(int datoViviendaId) async {
    final result = await servicioPublicoViviendaUsecaseDB
        .saveServiciosPublicosViviendaUsecaseDB(
            datoViviendaId, state.lstServPublicos!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTechosVivienda(datoViviendaId));
  }

  Future<void> saveTechosVivienda(int datoViviendaId) async {
    final result = await techoViviendaUsecaseDB.saveTechosViviendaUsecaseDB(
        datoViviendaId, state.lstTechos!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTiposCombustibleVivienda(datoViviendaId));
  }

  Future<void> saveTiposCombustibleVivienda(int datoViviendaId) async {
    final result = await tipoCombustibleViviendaUsecaseDB
        .saveTiposCombustibleViviendaUsecaseDB(
            datoViviendaId, state.lstTiposCombustible!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTiposSanitarioVivienda(datoViviendaId));
  }

  Future<void> saveTiposSanitarioVivienda(int datoViviendaId) async {
    final result = await tipoSanitarioViviendaUsecaseDB
        .saveTiposSanitarioViviendaUsecaseDB(
            datoViviendaId, state.lstTiposSanitario!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTmtoAguasVivienda(datoViviendaId));
  }

  Future<void> saveTmtoAguasVivienda(int datoViviendaId) async {
    final result = await tratamientoAguaViviendaUsecaseDB
        .saveTmtoAguasViviendaUsecaseDB(datoViviendaId, state.lstTmtoAguas!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await savePresenciaAnimalesVivienda(datoViviendaId));
  }

  Future<void> savePresenciaAnimalesVivienda(int datoViviendaId) async {
    final result = await presenciaAnimalViviendaUsecaseDB
        .savePresenciaAnimalesViviendaUsecaseDB(
            datoViviendaId, state.lstPresenciaAnimales!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => add(DimViviendaFormSubmissionSuccess(datoViviendaId)));
  }
}
