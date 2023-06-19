import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_lengua_materna_entity.dart';
import '../../../domain/repositories/nombre_lengua_materna/nombre_lengua_materna_repository_db.dart';
import '../../datasources/local/nombre_lengua_materna_local_ds.dart';

class NombreLenguaMaternaRepositoryDBImpl
    implements NombreLenguaMaternaRepositoryDB {
  final NombreLenguaMaternaLocalDataSource nombreLenguaMaternaLocalDataSource;

  NombreLenguaMaternaRepositoryDBImpl(
      {required this.nombreLenguaMaternaLocalDataSource});

  @override
  Future<Either<Failure, List<NombreLenguaMaternaEntity>>>
      getNombresLenguasMaternaRepositoryDB() async {
    try {
      final result =
          await nombreLenguaMaternaLocalDataSource.getNombresLenguasMaterna();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNombreLenguaMaternaRepositoryDB(
      NombreLenguaMaternaEntity nombreLenguaMaterna) async {
    try {
      final result = await nombreLenguaMaternaLocalDataSource
          .saveNombreLenguaMaterna(nombreLenguaMaterna);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
