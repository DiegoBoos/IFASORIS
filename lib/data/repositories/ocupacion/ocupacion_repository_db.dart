import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ocupacion.dart';
import '../../../domain/repositories/ocupacion/ocupacion_repository_db.dart';
import '../../datasources/local/ocupacion_local_ds.dart';
import '../../models/ocupacion.dart';

class OcupacionRepositoryDBImpl implements OcupacionRepositoryDB {
  final OcupacionLocalDataSource ocupacionLocalDataSource;

  OcupacionRepositoryDBImpl({required this.ocupacionLocalDataSource});

  @override
  Future<Either<Failure, List<OcupacionModel>>>
      getOcupacionesRepositoryDB() async {
    try {
      final result = await ocupacionLocalDataSource.getOcupaciones();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveOcupacionRepositoryDB(
      OcupacionEntity ocupacion) async {
    try {
      final ocupacionModel = OcupacionModel.fromEntity(ocupacion);
      final result =
          await ocupacionLocalDataSource.saveOcupacion(ocupacionModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
