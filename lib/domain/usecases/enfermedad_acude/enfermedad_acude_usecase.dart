import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_acude_entity.dart';
import '../../repositories/enfermedad_acude/enfermedad_acude_repository.dart';

class EnfermedadAcudeUsecase {
  final EnfermedadAcudeRepository repository;

  EnfermedadAcudeUsecase(this.repository);

  Future<Either<Failure, List<EnfermedadAcudeEntity>>>
      getEnfermedadesAcudeUsecase() {
    return repository.getEnfermedadesAcudeRepository();
  }
}
