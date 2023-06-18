import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_lengua_maneja_entity.dart';
import '../../../domain/repositories/nombre_lengua_maneja/nombre_lengua_maneja_repository_db.dart';
import '../../datasources/local/nombre_lengua_maneja_local_ds.dart';

class NombreLenguaManejaRepositoryDBImpl
    implements NombreLenguaManejaRepositoryDB {
  final NombreLenguaManejaLocalDataSource nombreLenguaManejaLocalDataSource;

  NombreLenguaManejaRepositoryDBImpl(
      {required this.nombreLenguaManejaLocalDataSource});

  @override
  Future<Either<Failure, List<NombreLenguaManejaEntity>>>
      getNombresLenguasManejaRepositoryDB() async {
    try {
      final result =
          await nombreLenguaManejaLocalDataSource.getNombresLenguasManeja();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNombreLenguaManejaRepositoryDB(
      NombreLenguaManejaEntity nombreLenguaManeja) async {
    try {
      final result = await nombreLenguaManejaLocalDataSource
          .saveNombreLenguaManeja(nombreLenguaManeja);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
