import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ocupacion_entity.dart';
import '../../../domain/repositories/ocupacion/ocupacion_repository_db.dart';
import '../../datasources/local/ocupacion_local_ds.dart';

class OcupacionRepositoryDBImpl implements OcupacionRepositoryDB {
  final OcupacionLocalDataSource ocupacionLocalDataSource;

  OcupacionRepositoryDBImpl({required this.ocupacionLocalDataSource});

  @override
  Future<Either<Failure, List<OcupacionEntity>>>
      getOcupacionesRepositoryDB() async {
    try {
      final result = await ocupacionLocalDataSource.getOcupaciones();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveOcupacionRepositoryDB(
      OcupacionEntity ocupacion) async {
    try {
      final result = await ocupacionLocalDataSource.saveOcupacion(ocupacion);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
