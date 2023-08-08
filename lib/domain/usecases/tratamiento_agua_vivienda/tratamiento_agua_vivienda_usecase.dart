import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tratamiento_agua_vivienda_entity.dart';
import '../../repositories/tratamiento_agua_vivienda/tratamiento_agua_vivienda_repository.dart';

class TratamientoAguaViviendaUsecase {
  final TratamientoAguaViviendaRepository repository;

  TratamientoAguaViviendaUsecase(this.repository);

  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaUsecase(int dtoId) {
    return repository.getTratamientosAguaViviendaRepository(dtoId);
  }
}
