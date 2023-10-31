import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cigarrillo_dia_entity.dart';
import '../../../domain/repositories/cigarrillo_dia/cigarrillo_dia_repository_db.dart';
import '../../datasources/local/cigarrillo_dia_local_ds.dart';

class CigarrilloDiaRepositoryDBImpl implements CigarrilloDiaRepositoryDB {
  final CigarrilloDiaLocalDataSource cigarrilloDiaLocalDataSource;

  CigarrilloDiaRepositoryDBImpl({required this.cigarrilloDiaLocalDataSource});

  @override
  Future<Either<Failure, List<CigarrilloDiaEntity>>>
      getCigarrillosDiaRepositoryDB() async {
    try {
      final result = await cigarrilloDiaLocalDataSource.getCigarrillosDia();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCigarrilloDiaRepositoryDB(
      CigarrilloDiaEntity cigarrilloDia) async {
    try {
      final result =
          await cigarrilloDiaLocalDataSource.saveCigarrilloDia(cigarrilloDia);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
