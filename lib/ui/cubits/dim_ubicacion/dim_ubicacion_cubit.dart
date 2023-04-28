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

  Future<DimUbicacionEntity?> getDimUbicacion(int familiaId) async {
    final result =
        await dimUbicacionUsecaseDB.getDimUbicacionUsecaseDB(familiaId);
    return result.fold((failure) => null, (data) => data);
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

  void changePerteneceResguardo(String? value) {
    final perteneceResguardoChanged =
        state.dimUbicacion.copyWith(perteneceResguardo: int.parse(value!));
    emit(DimUbicacionChanged(perteneceResguardoChanged));
  }

  void changeViaAccesoId(String? value) {
    final viaAccesoIdChanged =
        state.dimUbicacion.copyWith(viaAccesoId: int.parse(value!));
    emit(DimUbicacionChanged(viaAccesoIdChanged));
  }

  void changeResguardoId(String? value) {
    final resguardoIdChanged =
        state.dimUbicacion.copyWith(resguardoId: int.parse(value!));
    emit(DimUbicacionChanged(resguardoIdChanged));
  }

  void changeAutoridadIndigenaId(String? value) {
    final autoridadIndigenaIdChanged =
        state.dimUbicacion.copyWith(autoridadIndigenaId: int.parse(value!));
    emit(DimUbicacionChanged(autoridadIndigenaIdChanged));
  }

  void changeEstadoViaId(String? value) {
    final estadoViaIdChanged =
        state.dimUbicacion.copyWith(estadoViaId: int.parse(value!));
    emit(DimUbicacionChanged(estadoViaIdChanged));
  }

  void changeMedioComunicacionId(String? value) {
    final medioComunicacionIdChanged =
        state.dimUbicacion.copyWith(medioComunicacionId: int.parse(value!));
    emit(DimUbicacionChanged(medioComunicacionIdChanged));
  }

  void changeTiempoTardaId(String? value) {
    final tiempoTardaIdChanged =
        state.dimUbicacion.copyWith(tiempoTardaId: int.parse(value!));
    emit(DimUbicacionChanged(tiempoTardaIdChanged));
  }

  void changeMedioUtilizaId(String? value) {
    final medioUtilizaIdChanged =
        state.dimUbicacion.copyWith(medioUtilizaId: int.parse(value!));
    emit(DimUbicacionChanged(medioUtilizaIdChanged));
  }

  void changeDificultaAccesoId(String? value) {
    final dificultaAccesoIdChanged =
        state.dimUbicacion.copyWith(dificultaAccesoId: int.parse(value!));
    emit(DimUbicacionChanged(dificultaAccesoIdChanged));
  }

  void changeCostoDesplazamientoId(String? value) {
    final costoDesplazamientoIdChanged =
        state.dimUbicacion.copyWith(costoDesplazamientoId: int.parse(value!));
    emit(DimUbicacionChanged(costoDesplazamientoIdChanged));
  }

  void changeExisteMedTradicionalComunidad(String? value) {
    final existeMedTradicionalComunidadChanged = state.dimUbicacion
        .copyWith(existeMedTradicionalComunidad: int.parse(value!));
    emit(DimUbicacionChanged(existeMedTradicionalComunidadChanged));
  }

  void changeEspecialidadMedTradId(String? value) {
    final especialidadMedTradIdChanged =
        state.dimUbicacion.copyWith(especialidadMedTradId: int.parse(value!));
    emit(DimUbicacionChanged(especialidadMedTradIdChanged));
  }

  void changeTiempoTardaMedTradId(String? value) {
    final tiempoTardaMedTradIdChanged =
        state.dimUbicacion.copyWith(tiempoTardaMedTradId: int.parse(value!));
    emit(DimUbicacionChanged(tiempoTardaMedTradIdChanged));
  }

  void changeMedioUtilizaMedTradId(String? value) {
    final medioUtilizaMedTradIdChanged =
        state.dimUbicacion.copyWith(medioUtilizaMedTradId: int.parse(value!));
    emit(DimUbicacionChanged(medioUtilizaMedTradIdChanged));
  }

  void changeDificultadAccesoMedTradId(String? value) {
    final dificultadAccesoMedTradIdChanged = state.dimUbicacion
        .copyWith(dificultadAccesoMedTradId: int.parse(value!));
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

  void changePoseeChagra(String? value) {
    final poseeChagraChanged =
        state.dimUbicacion.copyWith(poseeChagra: int.parse(value!));
    emit(DimUbicacionChanged(poseeChagraChanged));
  }

  void changeTuberculoPlatanoId(String? value) {
    final tuberculoPlatanoIdChanged =
        state.dimUbicacion.copyWith(tuberculoPlatanoId: int.parse(value!));
    emit(DimUbicacionChanged(tuberculoPlatanoIdChanged));
  }

  void changeLeguminosaId(String? value) {
    final leguminosaIdChanged =
        state.dimUbicacion.copyWith(leguminosaId: int.parse(value!));
    emit(DimUbicacionChanged(leguminosaIdChanged));
  }

  void changeHortalizaId(String? value) {
    final hortalizaIdChanged =
        state.dimUbicacion.copyWith(hortalizaId: int.parse(value!));
    emit(DimUbicacionChanged(hortalizaIdChanged));
  }

  void changeVerduraId(String? value) {
    final verduraIdChanged =
        state.dimUbicacion.copyWith(verduraId: int.parse(value!));
    emit(DimUbicacionChanged(verduraIdChanged));
  }

  void changeFrutoId(String? value) {
    final frutoIdChanged =
        state.dimUbicacion.copyWith(frutoId: int.parse(value!));
    emit(DimUbicacionChanged(frutoIdChanged));
  }

  void changeCerealId(String? value) {
    final cerealIdChanged =
        state.dimUbicacion.copyWith(cerealId: int.parse(value!));
    emit(DimUbicacionChanged(cerealIdChanged));
  }

  void changeEspecieAnimalCriaId(String? value) {
    final especieAnimalCriaIdChanged =
        state.dimUbicacion.copyWith(especieAnimalCriaId: int.parse(value!));
    emit(DimUbicacionChanged(especieAnimalCriaIdChanged));
  }

  void changeProduccionMinera(String? value) {
    final produccionMineraChanged =
        state.dimUbicacion.copyWith(produccionMinera: int.parse(value!));
    emit(DimUbicacionChanged(produccionMineraChanged));
  }

  void changeTipoCalendarioId(String? value) {
    final tipoCalendarioIdChanged =
        state.dimUbicacion.copyWith(tipoCalendarioId: int.parse(value!));
    emit(DimUbicacionChanged(tipoCalendarioIdChanged));
  }
}
