import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/afiliado_entity.dart';
import '../../repositories/afiliado/afiliado_repository_db.dart';

class AfiliadoUsecaseDB {
  final AfiliadoRepositoryDB repositoryDB;

  AfiliadoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveAfiliadoUsecaseDB(AfiliadoEntity afiliado) {
    return repositoryDB.saveAfiliadoRepositoryDB(afiliado);
  }

  Future<Either<Failure, List<AfiliadoEntity>>> getAfiliadosUsecaseDB(
      int dtoId, int pagina, int registrosPorPagina) {
    return repositoryDB.getAfiliadosRepositoryDB(
        dtoId, pagina, registrosPorPagina);
  }
}
