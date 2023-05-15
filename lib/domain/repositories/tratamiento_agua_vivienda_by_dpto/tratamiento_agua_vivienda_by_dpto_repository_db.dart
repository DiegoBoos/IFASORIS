import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda_entity.dart';

abstract class TratamientoAguaViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveTratamientoAguaViviendaByDptoRepositoryDB(
      TratamientoAguaViviendaEntity tratamientoAguaVivienda);

  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaByDptoRepositoryDB();
}
