import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/verdura.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/verdura.dart';
import '../../../domain/repositories/verdura/verdura_repository_db.dart';
import '../../datasources/local/verdura_local_ds.dart';

class VerduraRepositoryDBImpl implements VerduraRepositoryDB {
  final VerduraLocalDataSource verduraLocalDataSource;

  VerduraRepositoryDBImpl({required this.verduraLocalDataSource});

  @override
  Future<Either<Failure, List<VerduraModel>>> getVerdurasRepositoryDB() async {
    try {
      final result = await verduraLocalDataSource.getVerduras();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveVerduraRepositoryDB(
      VerduraEntity verdura) async {
    try {
      final verduraModel = VerduraModel.fromEntity(verdura);
      final result = await verduraLocalDataSource.saveVerdura(verduraModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionVerdurasRepositoryDB(
      int ubicacionId, List<LstVerdura> lstVerduras) async {
    try {
      final result = await verduraLocalDataSource.saveUbicacionVerduras(
          ubicacionId, lstVerduras);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstVerdura>>> getUbicacionVerdurasRepositoryDB(
      int? ubicacionId) async {
    try {
      final result =
          await verduraLocalDataSource.getUbicacionVerduras(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
