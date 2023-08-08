import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/verdura_entity.dart';
import '../../../domain/repositories/verdura/verdura_repository_db.dart';
import '../../datasources/local/verdura_local_ds.dart';

class VerduraRepositoryDBImpl implements VerduraRepositoryDB {
  final VerduraLocalDataSource verduraLocalDataSource;

  VerduraRepositoryDBImpl({required this.verduraLocalDataSource});

  @override
  Future<Either<Failure, List<VerduraEntity>>> getVerdurasRepositoryDB() async {
    try {
      final result = await verduraLocalDataSource.getVerduras();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVerduraRepositoryDB(
      VerduraEntity verdura) async {
    try {
      final result = await verduraLocalDataSource.saveVerdura(verdura);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionVerdurasRepositoryDB(
      int ubicacionId, List<LstVerdura> lstVerduras) async {
    try {
      final result = await verduraLocalDataSource.saveUbicacionVerduras(
          ubicacionId, lstVerduras);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstVerdura>>> getUbicacionVerdurasRepositoryDB(
      int? ubicacionId) async {
    try {
      final result =
          await verduraLocalDataSource.getUbicacionVerduras(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
