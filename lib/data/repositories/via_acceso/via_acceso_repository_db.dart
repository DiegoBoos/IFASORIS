import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/via_acceso.dart';
import '../../../domain/repositories/via_acceso/via_acceso_repository_db.dart';
import '../../datasources/local/via_acceso_local_ds.dart';
import '../../models/via_acceso.dart';

class ViaAccesoRepositoryDBImpl implements ViaAccesoRepositoryDB {
  final ViaAccesoLocalDataSource viaAccesoLocalDataSource;

  ViaAccesoRepositoryDBImpl({required this.viaAccesoLocalDataSource});

  @override
  Future<Either<Failure, List<ViaAccesoModel>>>
      getViasAccesoRepositoryDB() async {
    try {
      final result = await viaAccesoLocalDataSource.getViasAcceso();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveViaAccesoRepositoryDB(
      ViaAccesoEntity viaAcceso) async {
    try {
      final viaAccesoModel = ViaAccesoModel.fromEntity(viaAcceso);
      final result =
          await viaAccesoLocalDataSource.saveViaAcceso(viaAccesoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
