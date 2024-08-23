import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cigarrillo_dia.dart';
import '../../../domain/repositories/cigarrillo_dia/cigarrillo_dia_repository_db.dart';
import '../../datasources/local/cigarrillo_dia_local_ds.dart';
import '../../models/cigarrillo_dia.dart';

class CigarrilloDiaRepositoryDBImpl implements CigarrilloDiaRepositoryDB {
  final CigarrilloDiaLocalDataSource cigarrilloDiaLocalDataSource;

  CigarrilloDiaRepositoryDBImpl({required this.cigarrilloDiaLocalDataSource});

  @override
  Future<Either<Failure, List<CigarrilloDiaModel>>>
      getCigarrillosDiaRepositoryDB() async {
    try {
      final result = await cigarrilloDiaLocalDataSource.getCigarrillosDia();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveCigarrilloDiaRepositoryDB(
      CigarrilloDiaEntity cigarrilloDia) async {
    try {
      final cigarrilloDiaModel = CigarrilloDiaModel.fromEntity(cigarrilloDia);
      final result = await cigarrilloDiaLocalDataSource
          .saveCigarrilloDia(cigarrilloDiaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
