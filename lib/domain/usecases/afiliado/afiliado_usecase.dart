import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/afiliado.dart';
import '../../repositories/afiliado/afiliado_repository.dart';

class AfiliadoUsecase {
  final AfiliadoRepository repository;

  AfiliadoUsecase(this.repository);

  Future<Either<Failure, AfiliadoResponseModel>> getAfiliadosUsecase(
      int dtoId) {
    return repository.getAfiliadosRepository(dtoId);
  }
}
