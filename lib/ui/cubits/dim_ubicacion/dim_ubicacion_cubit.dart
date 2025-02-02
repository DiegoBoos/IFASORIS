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

  void getDimUbicacion(int afiliadoId, int familiaId) async {
    final result = await dimUbicacionUsecaseDB.getDimUbicacionUsecaseDB(
        afiliadoId, familiaId);
    result.fold(
        (failure) => emit(DimUbicacionError(failure.properties.first)),
        (data) => data != null
            ? emit(DimUbicacionLoaded(data))
            : emit(DimUbicacionInitial()));
  }
}
