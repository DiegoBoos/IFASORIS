import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/afiliado_entity.dart';
import '../../../domain/repositories/afiliado/afiliado_repository_db.dart';
import '../../datasources/local/afiliado_local_ds.dart';

class AfiliadoRepositoryDBImpl implements AfiliadoRepositoryDB {
  final AfiliadoLocalDataSource afiliadoLocalDataSource;

  AfiliadoRepositoryDBImpl({required this.afiliadoLocalDataSource});

  @override
  Future<Either<Failure, List<AfiliadoEntity>>> getAfiliadosRepositoryDB(
      int dtoId, int pagina, int registrosPorPagina) async {
    try {
      final afiliadoDB = await afiliadoLocalDataSource.getAfiliados(
          dtoId, pagina, registrosPorPagina);
      return Right(afiliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAfiliadoRepositoryDB(
      AfiliadoEntity afiliado) async {
    try {
      final afiliadoDB = await afiliadoLocalDataSource.saveAfiliado(afiliado);
      return Right(afiliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
