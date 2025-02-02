import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/via_acceso/via_acceso_repository.dart';
import '../../datasources/remote/via_acceso_remote_ds.dart';
import '../../models/via_acceso.dart';

class ViaAccesoRepositoryImpl implements ViaAccesoRepository {
  final ViaAccesoRemoteDataSource viaAccesoRemoteDataSource;

  ViaAccesoRepositoryImpl({required this.viaAccesoRemoteDataSource});

  @override
  Future<Either<Failure, List<ViaAccesoModel>>> getViasAccesoRepository(
      int dtoId) async {
    try {
      final result = await viaAccesoRemoteDataSource.getViasAcceso(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
