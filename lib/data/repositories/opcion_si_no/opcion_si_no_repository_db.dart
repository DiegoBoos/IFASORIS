import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/opcion_si_no_entity.dart';
import '../../../domain/repositories/opcion_si_no/opcion_si_no_repository_db.dart';
import '../../datasources/local/opcion_si_no_local_ds.dart';

class OpcionSiNoRepositoryDBImpl implements OpcionSiNoRepositoryDB {
  final OpcionSiNoLocalDataSource opcionSiNoLocalDataSource;

  OpcionSiNoRepositoryDBImpl({required this.opcionSiNoLocalDataSource});

  @override
  Future<Either<Failure, List<OpcionSiNoEntity>>>
      getOpcionesSiNoRepositoryDB() async {
    try {
      final result = await opcionSiNoLocalDataSource.getOpcionesSiNo();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveOpcionSiNoRepositoryDB(
      OpcionSiNoEntity opcionSiNo) async {
    try {
      final result = await opcionSiNoLocalDataSource.saveOpcionSiNo(opcionSiNo);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
