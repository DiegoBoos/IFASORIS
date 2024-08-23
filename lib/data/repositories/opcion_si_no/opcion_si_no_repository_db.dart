import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/opcion_si_no.dart';
import '../../../domain/repositories/opcion_si_no/opcion_si_no_repository_db.dart';
import '../../datasources/local/opcion_si_no_local_ds.dart';
import '../../models/opcion_si_no.dart';

class OpcionSiNoRepositoryDBImpl implements OpcionSiNoRepositoryDB {
  final OpcionSiNoLocalDataSource opcionSiNoLocalDataSource;

  OpcionSiNoRepositoryDBImpl({required this.opcionSiNoLocalDataSource});

  @override
  Future<Either<Failure, List<OpcionSiNoModel>>>
      getOpcionesSiNoRepositoryDB() async {
    try {
      final result = await opcionSiNoLocalDataSource.getOpcionesSiNo();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveOpcionSiNoRepositoryDB(
      OpcionSiNoEntity opcionSiNo) async {
    try {
      final opcionSiNoModel = OpcionSiNoModel.fromEntity(opcionSiNo);
      final result =
          await opcionSiNoLocalDataSource.saveOpcionSiNo(opcionSiNoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
