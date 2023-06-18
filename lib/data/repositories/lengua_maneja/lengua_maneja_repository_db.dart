import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lengua_maneja_entity.dart';
import '../../../domain/repositories/lengua_maneja/lengua_maneja_repository_db.dart';
import '../../datasources/local/lengua_maneja_local_ds.dart';

class LenguaManejaRepositoryDBImpl implements LenguaManejaRepositoryDB {
  final LenguaManejaLocalDataSource lenguaManejaLocalDataSource;

  LenguaManejaRepositoryDBImpl({required this.lenguaManejaLocalDataSource});

  @override
  Future<Either<Failure, List<LenguaManejaEntity>>>
      getLenguasManejaRepositoryDB() async {
    try {
      final result = await lenguaManejaLocalDataSource.getLenguasManeja();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLenguaManejaRepositoryDB(
      LenguaManejaEntity lenguaManeja) async {
    try {
      final result =
          await lenguaManejaLocalDataSource.saveLenguaManeja(lenguaManeja);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
