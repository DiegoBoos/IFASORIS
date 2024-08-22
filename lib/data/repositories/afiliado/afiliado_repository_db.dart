import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';

import '../../../core/error/failure.dart';
import '../../models/afiliado.dart';
import '../../models/ficha.dart';

class AfiliadoRepositoryDBImpl implements AfiliadoRepositoryDB {
  final AfiliadoLocalDataSource afiliadoLocalDataSource;

  AfiliadoRepositoryDBImpl({required this.afiliadoLocalDataSource});

  @override
  Future<Either<Failure, List<AfiliadoModel>>> getAfiliadosRepositoryDB(
      String query) async {
    try {
      final result = await afiliadoLocalDataSource.getAfiliados(query);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, void>> saveAfiliadoRepositoryDB(
      AfiliadoEntity afiliado) async {
    try {
      final result = await afiliadoLocalDataSource.saveAfiliado(afiliado);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, FichaModel?>> afiliadoTieneFichaRepositoryDB(
      int afiliadoId) async {
    try {
      final result =
          await afiliadoLocalDataSource.afiliadoTieneFicha(afiliadoId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
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
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
