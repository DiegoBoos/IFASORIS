part of 'dim_ubicacion_state.dart';

class DimUbicacionCubit extends Cubit<DimUbicacionState> {
  final DimUbicacionUsecaseDB dimUbicacionUsecaseDB;
  DimUbicacionCubit({required this.dimUbicacionUsecaseDB})
      : super(DimUbicacionInitial());

  void initState() => emit(DimUbicacionInitial());

  void saveDimUbicacionDB(
      DimUbicacionEntity dimUbicacion, int familiaId) async {
    final result =
        await dimUbicacionUsecaseDB.saveDimUbicacionUsecaseDB(dimUbicacion);
    result.fold((failure) => emit(DimUbicacionError(failure.properties.first)),
        (data) => emit(DimUbicacionSaved(dimUbicacion: dimUbicacion)));
  }

  void getDimUbicacion(int familiaId) async {
    final result =
        await dimUbicacionUsecaseDB.getDimUbicacionUsecaseDB(familiaId);
    result.fold((failure) => emit(DimUbicacionError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(DimUbicacionLoaded(data));
      }
    });
  }

  void changeUbicacionId(int? value) {
    final ubicacionIdChanged = state.dimUbicacion.copyWith(ubicacionId: value);
    emit(DimUbicacionChanged(ubicacionIdChanged));
  }

  void changeFamiliaId(int? value) {
    final familiaIdChanged = state.dimUbicacion.copyWith(familiaId: value);
    emit(DimUbicacionChanged(familiaIdChanged));
  }

  void changeNombreRecibeVisita(String? value) {
    final nombreRecibeVisitaChanged =
        state.dimUbicacion.copyWith(nombreRecibeVisita: value!);
    emit(DimUbicacionChanged(nombreRecibeVisitaChanged));
  }

  void changeTipoDocRecibeVisita(String? value) {
    final tipoDocRecibeVisitaChanged =
        state.dimUbicacion.copyWith(tipoDocRecibeVisita: value!);
    emit(DimUbicacionChanged(tipoDocRecibeVisitaChanged));
  }

  void changeDocumentoRecibeVisita(String? value) {
    final documentoRecibeVisitaChanged =
        state.dimUbicacion.copyWith(documentoRecibeVisita: value);
    emit(DimUbicacionChanged(documentoRecibeVisitaChanged));
  }

  void changePerteneceResguardo(int? value) {
    final perteneceResguardoChanged =
        state.dimUbicacion.copyWith(perteneceResguardo: value);
    emit(DimUbicacionChanged(perteneceResguardoChanged));
  }

  void changeViaAccesoId(int? value) {
    final viaAccesoIdChanged = state.dimUbicacion.copyWith(viaAccesoId: value);
    emit(DimUbicacionChanged(viaAccesoIdChanged));
  }

  void changeResguardoId(int? value) {
    final resguardoIdChanged = state.dimUbicacion.copyWith(resguardoId: value);
    emit(DimUbicacionChanged(resguardoIdChanged));
  }

  void changeAutoridadIndigenaId(int? value) {
    final autoridadIndigenaIdChanged =
        state.dimUbicacion.copyWith(autoridadIndigenaId: value);
    emit(DimUbicacionChanged(autoridadIndigenaIdChanged));
  }

  void changeEstadoViaId(int? value) {
    final estadoViaIdChanged = state.dimUbicacion.copyWith(estadoViaId: value);
    emit(DimUbicacionChanged(estadoViaIdChanged));
  }

  void changeMedioComunicacionId(int? value) {
    final medioComunicacionIdChanged =
        state.dimUbicacion.copyWith(medioComunicacionId: value);
    emit(DimUbicacionChanged(medioComunicacionIdChanged));
  }

  void changeTiempoTardaId(int? value) {
    final tiempoTardaIdChanged =
        state.dimUbicacion.copyWith(tiempoTardaId: value);
    emit(DimUbicacionChanged(tiempoTardaIdChanged));
  }

  void changeMedioUtilizaId(int? value) {
    final medioUtilizaIdChanged =
        state.dimUbicacion.copyWith(medioUtilizaId: value);
    emit(DimUbicacionChanged(medioUtilizaIdChanged));
  }

  void changeDificultaAccesoId(int? value) {
    final dificultaAccesoIdChanged =
        state.dimUbicacion.copyWith(dificultaAccesoId: value);
    emit(DimUbicacionChanged(dificultaAccesoIdChanged));
  }

  void changeCostoDesplazamientoId(int? value) {
    final costoDesplazamientoIdChanged =
        state.dimUbicacion.copyWith(costoDesplazamientoId: value);
    emit(DimUbicacionChanged(costoDesplazamientoIdChanged));
  }

  void changeExisteMedTradicionalComunidad(int? value) {
    final existeMedTradicionalComunidadChanged =
        state.dimUbicacion.copyWith(existeMedTradicionalComunidad: value);
    emit(DimUbicacionChanged(existeMedTradicionalComunidadChanged));
  }

  void changeEspecialidadMedTradId(int? value) {
    final especialidadMedTradIdChanged =
        state.dimUbicacion.copyWith(especialidadMedTradId: value);
    emit(DimUbicacionChanged(especialidadMedTradIdChanged));
  }

  void changeTiempoTardaMedTradId(int? value) {
    final tiempoTardaMedTradIdChanged =
        state.dimUbicacion.copyWith(tiempoTardaMedTradId: value);
    emit(DimUbicacionChanged(tiempoTardaMedTradIdChanged));
  }

  void changeMedioUtilizaMedTradId(int? value) {
    final medioUtilizaMedTradIdChanged =
        state.dimUbicacion.copyWith(medioUtilizaMedTradId: value);
    emit(DimUbicacionChanged(medioUtilizaMedTradIdChanged));
  }

  void changeDificultadAccesoMedTradicional(int? value) {
    final dificultadAccesoMedTradIdChanged =
        state.dimUbicacion.copyWith(dificultadAccesoMedTradId: value);
    emit(DimUbicacionChanged(dificultadAccesoMedTradIdChanged));
  }

  void changeCostoDesplazamientoMedTradicional(String? value) {
    final costoDesplazamientoMedTradicionalChanged = state.dimUbicacion
        .copyWith(costoDesplazamientoMedTradicional: int.parse(value!));
    emit(DimUbicacionChanged(costoDesplazamientoMedTradicionalChanged));
  }

  void changeNombreMedTradicional(String? value) {
    final nombreMedTradicionalChanged =
        state.dimUbicacion.copyWith(nombreMedTradicional: value);
    emit(DimUbicacionChanged(nombreMedTradicionalChanged));
  }

  void changePoseeChagra(int? value) {
    final poseeChagraChanged = state.dimUbicacion.copyWith(poseeChagra: value);
    emit(DimUbicacionChanged(poseeChagraChanged));
  }

  void changeTuberculoPlatanoId(int? value) {
    final tuberculoPlatanoIdChanged =
        state.dimUbicacion.copyWith(tuberculoPlatanoId: value);
    emit(DimUbicacionChanged(tuberculoPlatanoIdChanged));
  }

  void changeLeguminosaId(int? value) {
    final leguminosaIdChanged =
        state.dimUbicacion.copyWith(leguminosaId: value);
    emit(DimUbicacionChanged(leguminosaIdChanged));
  }

  void changeHortalizaId(int? value) {
    final hortalizaIdChanged = state.dimUbicacion.copyWith(hortalizaId: value);
    emit(DimUbicacionChanged(hortalizaIdChanged));
  }

  void changeVerduraId(int? value) {
    final verduraIdChanged = state.dimUbicacion.copyWith(verduraId: value);
    emit(DimUbicacionChanged(verduraIdChanged));
  }

  void changeFrutoId(int? value) {
    final frutoIdChanged = state.dimUbicacion.copyWith(frutoId: value);
    emit(DimUbicacionChanged(frutoIdChanged));
  }

  void changeCerealId(int? value) {
    final cerealIdChanged = state.dimUbicacion.copyWith(cerealId: value);
    emit(DimUbicacionChanged(cerealIdChanged));
  }

  void changeEspecieAnimalCriaId(int? value) {
    final especieAnimalCriaIdChanged =
        state.dimUbicacion.copyWith(especieAnimalCriaId: value);
    emit(DimUbicacionChanged(especieAnimalCriaIdChanged));
  }

  void changeProduccionMinera(int? value) {
    final produccionMineraChanged =
        state.dimUbicacion.copyWith(produccionMinera: value);
    emit(DimUbicacionChanged(produccionMineraChanged));
  }

  void changeTipoCalendarioId(int? value) {
    final tipoCalendarioIdChanged =
        state.dimUbicacion.copyWith(tipoCalendarioId: value);
    emit(DimUbicacionChanged(tipoCalendarioIdChanged));
  }
}
