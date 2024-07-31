import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/actividad_fisica.dart';
import '../../repositories/actividad_fisica/actividad_fisica_repository.dart';

class ActividadFisicaUsecase {
  final ActividadFisicaRepository repository;

  ActividadFisicaUsecase(this.repository);

  Future<Either<Failure, List<ActividadFisicaEntity>>>
      getActividadesFisicasUsecase() {
    return repository.getActividadesFisicasRepository();
  }
}
