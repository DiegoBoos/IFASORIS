import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/condicion_nutricional_entity.dart';
import '../../../domain/repositories/condicion_nutricional/condicion_nutricional_repository_db.dart';
import '../../datasources/local/condicion_nutricional_local_ds.dart';

class CondicionNutricionalRepositoryDBImpl
    implements CondicionNutricionalRepositoryDB {
  final CondicionNutricionalLocalDataSource condicionNutricionalLocalDataSource;

  CondicionNutricionalRepositoryDBImpl(
      {required this.condicionNutricionalLocalDataSource});

  @override
  Future<Either<Failure, List<CondicionNutricionalEntity>>>
      getCondicionesNutricionalesRepositoryDB() async {
    try {
      final result = await condicionNutricionalLocalDataSource
          .getCondicionesNutricionales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCondicionNutricionalRepositoryDB(
      CondicionNutricionalEntity condicionNutricional) async {
    try {
      final result = await condicionNutricionalLocalDataSource
          .saveCondicionNutricional(condicionNutricional);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
