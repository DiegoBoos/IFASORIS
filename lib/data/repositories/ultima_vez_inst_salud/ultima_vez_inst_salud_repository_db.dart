import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ultima_vez_inst_salud.dart';
import '../../../domain/repositories/ultima_vez_inst_salud/ultima_vez_inst_salud_repository_db.dart';
import '../../datasources/local/ultima_vez_inst_salud_local_ds.dart';
import '../../models/ultima_vez_inst_salud.dart';

class UltimaVezInstSaludRepositoryDBImpl
    implements UltimaVezInstSaludRepositoryDB {
  final UltimaVezInstSaludLocalDataSource ultimaVezInstSaludLocalDataSource;

  UltimaVezInstSaludRepositoryDBImpl(
      {required this.ultimaVezInstSaludLocalDataSource});

  @override
  Future<Either<Failure, List<UltimaVezInstSaludModel>>>
      getUltimasVecesInstSaludRepositoryDB() async {
    try {
      final result =
          await ultimaVezInstSaludLocalDataSource.getUltimasVecesInstSalud();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUltimaVezInstSaludRepositoryDB(
      UltimaVezInstSaludEntity ultimaVezInstSalud) async {
    try {
      final ultimaVezInstSaludModel =
          UltimaVezInstSaludModel.fromEntity(ultimaVezInstSalud);
      final result = await ultimaVezInstSaludLocalDataSource
          .saveUltimaVezInstSalud(ultimaVezInstSaludModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
