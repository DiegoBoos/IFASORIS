import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ultima_vez_inst_salud_entity.dart';
import '../../../domain/repositories/ultima_vez_inst_salud/ultima_vez_inst_salud_repository_db.dart';
import '../../datasources/local/ultima_vez_inst_salud_local_ds.dart';

class UltimaVezInstSaludRepositoryDBImpl
    implements UltimaVezInstSaludRepositoryDB {
  final UltimaVezInstSaludLocalDataSource ultimaVezInstSaludLocalDataSource;

  UltimaVezInstSaludRepositoryDBImpl(
      {required this.ultimaVezInstSaludLocalDataSource});

  @override
  Future<Either<Failure, List<UltimaVezInstSaludEntity>>>
      getUltimasVecesInstSaludRepositoryDB() async {
    try {
      final result =
          await ultimaVezInstSaludLocalDataSource.getUltimasVecesInstSalud();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUltimaVezInstSaludRepositoryDB(
      UltimaVezInstSaludEntity ultimaVezInstSalud) async {
    try {
      final result = await ultimaVezInstSaludLocalDataSource
          .saveUltimaVezInstSalud(ultimaVezInstSalud);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
