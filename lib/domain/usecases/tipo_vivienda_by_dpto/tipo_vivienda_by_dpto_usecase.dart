import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda_entity.dart';
import '../../repositories/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_repository.dart';

class TipoViviendaByDptoUsecase {
  final TipoViviendaByDptoRepository repository;

  TipoViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaByDptoUsecase(int dtoId) {
    return repository.getTiposViviendaByDptoRepository(dtoId);
  }
}
