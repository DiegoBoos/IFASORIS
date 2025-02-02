import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion.dart';
import '../../repositories/medio_comunicacion/medio_comunicacion_repository.dart';

class MedioComunicacionUsecase {
  final MedioComunicacionRepository repository;

  MedioComunicacionUsecase(this.repository);

  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionUsecase(int dtoId) {
    return repository.getMediosComunicacionRepository(dtoId);
  }
}
