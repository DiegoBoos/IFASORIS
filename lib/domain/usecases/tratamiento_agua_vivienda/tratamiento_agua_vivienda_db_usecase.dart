import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tratamiento_agua_vivienda.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda.dart';
import '../../repositories/tratamiento_agua_vivienda/tratamiento_agua_vivienda_repository_db.dart';

class TratamientoAguaViviendaUsecaseDB {
  final TratamientoAguaViviendaRepositoryDB repositoryDB;

  TratamientoAguaViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTratamientoAguaViviendaUsecaseDB(
      TratamientoAguaViviendaEntity tratamientoAguaVivienda) {
    return repositoryDB
        .saveTratamientoAguaViviendaRepositoryDB(tratamientoAguaVivienda);
  }

  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaUsecaseDB() {
    return repositoryDB.getTratamientosAguaRepositoryDB();
  }

  Future<Either<Failure, int>> saveTmtoAguasViviendaUsecaseDB(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua) {
    return repositoryDB.saveTmtoAguasViviendaRepositoryDB(
        datoViviendaId, lstTmtoAgua);
  }

  Future<Either<Failure, List<LstTmtoAgua>>>
      getTratamientosAguaViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB.getTratamientosAguaViviendaRepositoryDB(datoViviendaId);
  }
}
