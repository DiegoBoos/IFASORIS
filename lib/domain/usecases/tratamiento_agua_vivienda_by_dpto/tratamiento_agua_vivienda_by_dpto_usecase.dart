import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda_entity.dart';
import '../../repositories/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_repository.dart';

class TratamientoAguaViviendaByDptoUsecase {
  final TratamientoAguaViviendaByDptoRepository repository;

  TratamientoAguaViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaByDptoUsecase(int dtoId) {
    return repository.getTratamientosAguaViviendaByDptoRepository(dtoId);
  }
}
