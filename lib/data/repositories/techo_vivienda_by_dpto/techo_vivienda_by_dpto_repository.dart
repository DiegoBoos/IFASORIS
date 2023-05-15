import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/techo_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/techo_vivienda_by_dpto/techo_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/techo_vivienda_by_dpto_remote_ds.dart';

class TechoViviendaByDptoRepositoryImpl
    implements TechoViviendaByDptoRepository {
  final TechoViviendaByDptoRemoteDataSource techoViviendaByDptoRemoteDataSource;

  TechoViviendaByDptoRepositoryImpl(
      {required this.techoViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await techoViviendaByDptoRemoteDataSource
          .getTechosViviendaByDpto(dtoId);

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
