import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/familia.dart';
import '../../../domain/repositories/familia/familia_repository_db.dart';
import '../../datasources/local/familia_local_ds.dart';
import '../../models/familia.dart';

class FamiliaRepositoryDBImpl implements FamiliaRepositoryDB {
  final FamiliaLocalDataSource familiaLocalDataSource;

  FamiliaRepositoryDBImpl({required this.familiaLocalDataSource});

  @override
  Future<Either<Failure, FamiliaModel?>> createFamiliaRepositoryDB(
      FamiliaEntity familia) async {
    try {
      final familiaModel = FamiliaModel.fromEntity(familia);
      final result = await familiaLocalDataSource.createFamilia(familiaModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<FamiliaModel>>> loadFamiliasRepositoryDB() async {
    try {
      final result = await familiaLocalDataSource.loadFamilias();

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> deleteAfiliadoFamiliaRepositoryDB(
      int fkAfiliadoId) async {
    try {
      final result =
          await familiaLocalDataSource.deleteAfiliadoFamilia(fkAfiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
