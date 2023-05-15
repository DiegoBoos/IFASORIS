import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';
import '../../repositories/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_repository.dart';

class TipoCombustibleViviendaByDptoUsecase {
  final TipoCombustibleViviendaByDptoRepository repository;

  TipoCombustibleViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoUsecase(int dtoId) {
    return repository.getTiposCombustibleViviendaByDptoRepository(dtoId);
  }
}
