import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda_entity.dart';

abstract class TratamientoAguaViviendaByDptoRepository {
  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaByDptoRepository(int dtoId);
}
