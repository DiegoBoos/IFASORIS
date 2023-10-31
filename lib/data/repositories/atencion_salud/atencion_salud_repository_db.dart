import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/repositories/atencion_salud/atencion_salud_repository_db.dart';
import '../../datasources/local/atencion_salud_local_ds.dart';

class AtencionSaludRepositoryDBImpl implements AtencionSaludRepositoryDB {
  final AtencionSaludLocalDataSource atencionSaludLocalDataSource;

  AtencionSaludRepositoryDBImpl({required this.atencionSaludLocalDataSource});

  @override
  Future<Either<Failure, int>> saveAtencionSaludRepositoryDB(
      AtencionSaludEntity atencionSalud) async {
    try {
      final result =
          await atencionSaludLocalDataSource.saveAtencionSalud(atencionSalud);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, AtencionSaludEntity?>> getAtencionSaludRepositoryDB(
      int afiliadoId) async {
    try {
      final result =
          await atencionSaludLocalDataSource.getAtencionSalud(afiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
