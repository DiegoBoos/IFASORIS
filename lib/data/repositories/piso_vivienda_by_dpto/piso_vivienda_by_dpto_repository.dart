import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/piso_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/piso_vivienda_by_dpto/piso_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/piso_vivienda_by_dpto_remote_ds.dart';

class PisoViviendaByDptoRepositoryImpl implements PisoViviendaByDptoRepository {
  final PisoViviendaByDptoRemoteDataSource pisoViviendaByDptoRemoteDataSource;

  PisoViviendaByDptoRepositoryImpl(
      {required this.pisoViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await pisoViviendaByDptoRemoteDataSource
          .getPisosViviendaByDpto(dtoId);

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
