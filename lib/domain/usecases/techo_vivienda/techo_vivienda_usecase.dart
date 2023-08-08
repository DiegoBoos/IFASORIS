import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';
import '../../repositories/techo_vivienda/techo_vivienda_repository.dart';

class TechoViviendaUsecase {
  final TechoViviendaRepository repository;

  TechoViviendaUsecase(this.repository);

  Future<Either<Failure, List<TechoViviendaEntity>>> getTechosViviendaUsecase(
      int dtoId) {
    return repository.getTechosViviendaRepository(dtoId);
  }
}
