import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/tipo_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/tipo_vivienda_by_dpto_remote_ds.dart';

class TipoViviendaByDptoRepositoryImpl implements TipoViviendaByDptoRepository {
  final TipoViviendaByDptoRemoteDataSource tipoViviendaByDptoRemoteDataSource;

  TipoViviendaByDptoRepositoryImpl(
      {required this.tipoViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await tipoViviendaByDptoRemoteDataSource
          .getTiposViviendaByDpto(dtoId);

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
