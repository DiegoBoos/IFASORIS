import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/opcion_si_no_entity.dart';
import '../../repositories/opcion_si_no/opcion_si_no_repository.dart';

class OpcionSiNoUsecase {
  final OpcionSiNoRepository repository;

  OpcionSiNoUsecase(this.repository);

  Future<Either<Failure, List<OpcionSiNoEntity>>> getOpcionesSiNoUsecase() {
    return repository.getOpcionesSiNoRepository();
  }
}
