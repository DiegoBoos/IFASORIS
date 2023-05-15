import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda_entity.dart';
import '../../repositories/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_repository_db.dart';

class TratamientoAguaViviendaByDptoUsecaseDB {
  final TratamientoAguaViviendaByDptoRepositoryDB repositoryDB;

  TratamientoAguaViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTratamientoAguaViviendaByDptoUsecaseDB(
      TratamientoAguaViviendaEntity tratamientoAguaViviendaByDpto) {
    return repositoryDB.saveTratamientoAguaViviendaByDptoRepositoryDB(
        tratamientoAguaViviendaByDpto);
  }

  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaByDptoUsecaseDB() {
    return repositoryDB.getTratamientosAguaViviendaByDptoRepositoryDB();
  }
}
