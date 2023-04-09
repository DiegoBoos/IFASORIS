import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/afiliado_response_model.dart';
import '../../repositories/afiliado/afiliado_repository.dart';

class AfiliadoUsecase {
  final AfiliadoRepository repository;

  AfiliadoUsecase(this.repository);

  Future<Either<Failure, AfiliadoResponseModel>> getAfiliadosUsecase(
      int dtoId, int pagina, int registrosPorPagina) {
    return repository.getAfiliadosRepository(dtoId, pagina, registrosPorPagina);
  }
}
