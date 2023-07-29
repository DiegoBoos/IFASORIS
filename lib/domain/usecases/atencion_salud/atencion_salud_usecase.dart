import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/atencion_salud_entity.dart';
import '../../repositories/atencion_salud/atencion_salud_repository.dart';

class AtencionSaludUsecase {
  final AtencionSaludRepository repository;

  AtencionSaludUsecase(this.repository);

  Future<Either<Failure, AtencionSaludEntity>> uploadAtencionSaludUsecase() {
    return repository.uploadAtencionSaludRepository();
  }
}
