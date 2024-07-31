import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nivel_educativo.dart';
import '../../repositories/nivel_educativo/nivel_educativo_repository.dart';

class NivelEducativoUsecase {
  final NivelEducativoRepository repository;

  NivelEducativoUsecase(this.repository);

  Future<Either<Failure, List<NivelEducativoEntity>>>
      getNivelesEducativosUsecase() {
    return repository.getNivelesEducativosRepository();
  }
}
