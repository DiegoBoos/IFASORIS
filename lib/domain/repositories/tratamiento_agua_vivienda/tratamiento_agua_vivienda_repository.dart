import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda.dart';

abstract class TratamientoAguaViviendaRepository {
  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaRepository(int dtoId);
}
