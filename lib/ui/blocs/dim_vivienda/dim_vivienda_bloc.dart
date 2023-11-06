import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/factor_riesgo_vivienda_model.dart';
import '../../../data/models/piso_vivienda_model.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../../data/models/techo_vivienda_model.dart';
import '../../../data/models/tipo_combustible_vivienda_model.dart';
import '../../../data/models/tipo_sanitario_vivienda_model.dart';
import '../../../data/models/tratamiento_agua_vivienda_model.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/usecases/dim_vivienda/dim_vivienda_db_usecase.dart';
import '../../../domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_db_usecase.dart';
import '../../../domain/usecases/piso_vivienda/piso_vivienda_db_usecase.dart';
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
  final PisoViviendaUsecaseDB pisoViviendaUsecaseDB;

  DimViviendaBloc({
    required this.dimViviendaUsecaseDB,
    required this.factorRiesgoViviendaUsecaseDB,
    required this.servicioPublicoViviendaUsecaseDB,
    required this.techoViviendaUsecaseDB,
    required this.tipoCombustibleViviendaUsecaseDB,
    required this.tipoSanitarioViviendaUsecaseDB,
    required this.tratamientoAguaViviendaUsecaseDB,
    required this.presenciaAnimalViviendaUsecaseDB,
    required this.pisoViviendaUsecaseDB,
  }) : super(initObject()) {
    on<DimViviendaInit>((event, emit) {
      emit(initObject());
    });

    on<DimViviendaSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await dimViviendaUsecaseDB.saveDimViviendaUsecaseDB(state);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) async => await saveFactoresRiesgoVivienda(data));
    });

    on<GetDimVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await dimViviendaUsecaseDB.getDimViviendaUsecaseDB(
          event.afiliadoId, event.familiaId);
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
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await techoViviendaUsecaseDB
          .getTechosViviendaViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTecho: data));
        add(GetServiciosPublicosVivienda(event.datoViviendaId));
      });
    });

    on<GetServiciosPublicosVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await servicioPublicoViviendaUsecaseDB
          .getServiciosPublicosViviendaDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstServPublico: data));
        add(GetTratamientosAguaVivienda(event.datoViviendaId));
      });
    });

    on<GetTratamientosAguaVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await tratamientoAguaViviendaUsecaseDB
          .getTratamientosAguaViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTmtoAgua: data));
        add(GetTiposSanitarioVivienda(event.datoViviendaId));
      });
    });

    on<GetTiposSanitarioVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await tipoSanitarioViviendaUsecaseDB
          .getTiposSanitarioViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTipoSanitario: data));
        add(GetTiposCombustibleVivienda(event.datoViviendaId));
      });
    });

    on<GetTiposCombustibleVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await tipoCombustibleViviendaUsecaseDB
          .getTiposCombustibleViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstTipoCombustible: data));
        add(GetFactoresRiesgoVivienda(event.datoViviendaId));
      });
    });

    on<GetFactoresRiesgoVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await factorRiesgoViviendaUsecaseDB
          .getFactoresRiesgoViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstFactorRiesgo: data));
        add(GetPisosVivienda(event.datoViviendaId));
      });
    });

    on<GetPisosVivienda>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await pisoViviendaUsecaseDB
          .getPisosViviendaViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(lstPiso: data));
        add(GetPresenciaAnimales(event.datoViviendaId));
      });
    });

    on<GetPresenciaAnimales>((event, emit) async {
      emit(state.copyWith(formStatus: DimViviendaFormLoading()));
      final result = await presenciaAnimalViviendaUsecaseDB
          .getPresenciaAnimalesViviendaUsecaseDB(event.datoViviendaId);
      result.fold((failure) {
        emit(state.copyWith(
            formStatus: DimViviendaSubmissionFailed(failure.properties.first)));
      }, (data) {
        emit(state.copyWith(
            lstPresenciaAnimal: data, formStatus: DimViviendaFormLoaded()));
      });
    });

    on<DimViviendaFormSubmissionSuccess>((event, emit) {
      emit(state.copyWith(
          datoViviendaId: event.datoViviendaId,
          formStatus: DimViviendaSubmissionSuccess()));
    });
    on<DimViviendaAfiliadoChanged>((event, emit) {
      emit(state.copyWith(afiliadoId: event.afiliadoId));
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
      emit(state.copyWith(lstPiso: event.lstPiso));
    });
    on<TechosViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTecho: event.lstTecho));
    });
    on<VentilacionViviendaChanged>((event, emit) {
      emit(state.copyWith(ventilacionViviendaId: event.ventilacionViviendaId));
    });
    on<IluminacionViviendaChanged>((event, emit) {
      emit(state.copyWith(iluminacionViviendaId: event.iluminacionViviendaId));
    });
    on<NroCuartoViviendaChanged>((event, emit) {
      emit(state.copyWith(nroCuartosViviendaId: event.nroCuartosViviendaId));
    });
    on<ServiciosPublicosViviendaChanged>((event, emit) {
      emit(state.copyWith(lstServPublico: event.lstServPublico));
    });
    on<TratamientosAguaViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTmtoAgua: event.lstTmtoAgua));
    });
    on<TiposSanitarioViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTipoSanitario: event.lstTipoSanitario));
    });
    on<TiposCombustibleViviendaChanged>((event, emit) {
      emit(state.copyWith(lstTipoCombustible: event.lstTipoCombustible));
    });
    on<FactoresRiesgoViviendaChanged>((event, emit) {
      emit(state.copyWith(lstFactorRiesgo: event.lstFactorRiesgo));
    });
    on<PresenciaAnimalesViviendaChanged>((event, emit) {
      emit(state.copyWith(lstPresenciaAnimal: event.lstPresenciaAnimal));
    });
  }

  Future<void> saveFactoresRiesgoVivienda(int datoViviendaId) async {
    final result =
        await factorRiesgoViviendaUsecaseDB.saveFactoresRiesgoViviendaUsecaseDB(
            datoViviendaId, state.lstFactorRiesgo!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveServiciosPublicosVivienda(datoViviendaId));
  }

  Future<void> saveServiciosPublicosVivienda(int datoViviendaId) async {
    final result = await servicioPublicoViviendaUsecaseDB
        .saveServiciosPublicosViviendaUsecaseDB(
            datoViviendaId, state.lstServPublico!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTechosVivienda(datoViviendaId));
  }

  Future<void> saveTechosVivienda(int datoViviendaId) async {
    final result = await techoViviendaUsecaseDB.saveTechosViviendaUsecaseDB(
        datoViviendaId, state.lstTecho!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTiposCombustibleVivienda(datoViviendaId));
  }

  Future<void> saveTiposCombustibleVivienda(int datoViviendaId) async {
    final result = await tipoCombustibleViviendaUsecaseDB
        .saveTiposCombustibleViviendaUsecaseDB(
            datoViviendaId, state.lstTipoCombustible!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTiposSanitarioVivienda(datoViviendaId));
  }

  Future<void> saveTiposSanitarioVivienda(int datoViviendaId) async {
    final result = await tipoSanitarioViviendaUsecaseDB
        .saveTiposSanitarioViviendaUsecaseDB(
            datoViviendaId, state.lstTipoSanitario!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await saveTmtoAguasVivienda(datoViviendaId));
  }

  Future<void> saveTmtoAguasVivienda(int datoViviendaId) async {
    final result = await tratamientoAguaViviendaUsecaseDB
        .saveTmtoAguasViviendaUsecaseDB(datoViviendaId, state.lstTmtoAgua!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await savePresenciaAnimalesVivienda(datoViviendaId));
  }

  Future<void> savePresenciaAnimalesVivienda(int datoViviendaId) async {
    final result = await presenciaAnimalViviendaUsecaseDB
        .savePresenciaAnimalesViviendaUsecaseDB(
            datoViviendaId, state.lstPresenciaAnimal!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) async => await savePisosVivienda(datoViviendaId));
  }

  Future<void> savePisosVivienda(int datoViviendaId) async {
    final result = await pisoViviendaUsecaseDB.savePisosViviendaUsecaseDB(
        datoViviendaId, state.lstPiso!);
    result.fold((failure) {
      add(DimViviendaFormSubmissionFailed(failure.properties.first));
    }, (data) => add(DimViviendaFormSubmissionSuccess(datoViviendaId)));
  }
}
