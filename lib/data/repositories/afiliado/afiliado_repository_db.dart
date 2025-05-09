import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/afiliado_entity.dart';
import '../../../domain/entities/ficha_entity.dart';
import '../../../domain/repositories/afiliado/afiliado_repository_db.dart';
import '../../datasources/local/afiliado_local_ds.dart';

class AfiliadoRepositoryDBImpl implements AfiliadoRepositoryDB {
  final AfiliadoLocalDataSource afiliadoLocalDataSource;

  AfiliadoRepositoryDBImpl({required this.afiliadoLocalDataSource});

  @override
  Future<Either<Failure, List<AfiliadoEntity>>> getAfiliadosRepositoryDB(
      String query) async {
    try {
      final result = await afiliadoLocalDataSource.getAfiliados(query);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, FichaEntity?>> afiliadoTieneFichaRepositoryDB(
      int afiliadoId) async {
    try {
      final result =
          await afiliadoLocalDataSource.afiliadoTieneFicha(afiliadoId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, String>> afiliadoTieneFichaReportadaRepositoryDB(
      int afiliadoId) async {
    try {
      final result =
          await afiliadoLocalDataSource.afiliadoTieneFichaReportada(afiliadoId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
