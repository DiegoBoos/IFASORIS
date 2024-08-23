import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_lengua_materna.dart';
import '../../../domain/repositories/nombre_lengua_materna/nombre_lengua_materna_repository_db.dart';
import '../../datasources/local/nombre_lengua_materna_local_ds.dart';
import '../../models/nombre_lengua_materna.dart';

class NombreLenguaMaternaRepositoryDBImpl
    implements NombreLenguaMaternaRepositoryDB {
  final NombreLenguaMaternaLocalDataSource nombreLenguaMaternaLocalDataSource;

  NombreLenguaMaternaRepositoryDBImpl(
      {required this.nombreLenguaMaternaLocalDataSource});

  @override
  Future<Either<Failure, List<NombreLenguaMaternaModel>>>
      getNombresLenguasMaternaRepositoryDB() async {
    try {
      final result =
          await nombreLenguaMaternaLocalDataSource.getNombresLenguasMaterna();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveNombreLenguaMaternaRepositoryDB(
      NombreLenguaMaternaEntity nombreLenguaMaterna) async {
    try {
      final nombreLenguaMaternaModel =
          NombreLenguaMaternaModel.fromEntity(nombreLenguaMaterna);
      final result = await nombreLenguaMaternaLocalDataSource
          .saveNombreLenguaMaterna(nombreLenguaMaternaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
