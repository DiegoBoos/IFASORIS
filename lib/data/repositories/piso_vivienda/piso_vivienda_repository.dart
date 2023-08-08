import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/piso_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/piso_vivienda/piso_vivienda_repository.dart';
import '../../datasources/remote/piso_vivienda_remote_ds.dart';

class PisoViviendaRepositoryImpl implements PisoViviendaRepository {
  final PisoViviendaRemoteDataSource pisoViviendaRemoteDataSource;

  PisoViviendaRepositoryImpl({required this.pisoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<PisoViviendaEntity>>> getPisosViviendaRepository(
      int dtoId) async {
    try {
      final result = await pisoViviendaRemoteDataSource.getPisosVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
