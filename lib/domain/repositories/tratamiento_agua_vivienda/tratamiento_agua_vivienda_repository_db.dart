import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tratamiento_agua_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda_entity.dart';

abstract class TratamientoAguaViviendaRepositoryDB {
  Future<Either<Failure, int>> saveTratamientoAguaViviendaRepositoryDB(
      TratamientoAguaViviendaEntity tratamientoAguaVivienda);

  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaRepositoryDB();

  Future<Either<Failure, int>> saveTmtoAguasViviendaRepositoryDB(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAguas);

  Future<Either<Failure, List<LstTmtoAgua>>>
      getTratamientosAguaViviendaRepositoryDB(int? datoViviendaId);
}
