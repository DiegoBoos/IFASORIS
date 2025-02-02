import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda.dart';
import '../../repositories/tipo_vivienda/tipo_vivienda_repository.dart';

class TipoViviendaUsecase {
  final TipoViviendaRepository repository;

  TipoViviendaUsecase(this.repository);

  Future<Either<Failure, List<TipoViviendaEntity>>> getTiposViviendaUsecase(
      int dtoId) {
    return repository.getTiposViviendaRepository(dtoId);
  }
}
