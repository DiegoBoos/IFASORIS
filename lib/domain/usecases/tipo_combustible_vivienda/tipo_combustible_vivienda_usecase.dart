import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda.dart';
import '../../repositories/tipo_combustible_vivienda/tipo_combustible_vivienda_repository.dart';

class TipoCombustibleViviendaUsecase {
  final TipoCombustibleViviendaRepository repository;

  TipoCombustibleViviendaUsecase(this.repository);

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaUsecase(int dtoId) {
    return repository.getTiposCombustibleViviendaRepository(dtoId);
  }
}
