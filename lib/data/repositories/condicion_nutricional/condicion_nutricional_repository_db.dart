import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/condicion_nutricional.dart';
import '../../../domain/repositories/condicion_nutricional/condicion_nutricional_repository_db.dart';
import '../../datasources/local/condicion_nutricional_local_ds.dart';
import '../../models/condicion_nutricional.dart';

class CondicionNutricionalRepositoryDBImpl
    implements CondicionNutricionalRepositoryDB {
  final CondicionNutricionalLocalDataSource condicionNutricionalLocalDataSource;

  CondicionNutricionalRepositoryDBImpl(
      {required this.condicionNutricionalLocalDataSource});

  @override
  Future<Either<Failure, List<CondicionNutricionalModel>>>
      getCondicionesNutricionalesRepositoryDB() async {
    try {
      final result = await condicionNutricionalLocalDataSource
          .getCondicionesNutricionales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveCondicionNutricionalRepositoryDB(
      CondicionNutricionalEntity condicionNutricional) async {
    try {
      final condicionNutricionalModel =
          CondicionNutricionalModel.fromEntity(condicionNutricional);
      final result = await condicionNutricionalLocalDataSource
          .saveCondicionNutricional(condicionNutricionalModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
