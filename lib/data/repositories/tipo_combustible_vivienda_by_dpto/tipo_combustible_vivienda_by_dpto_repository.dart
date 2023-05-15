import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../domain/repositories/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/tipo_combustible_vivienda_by_dpto_remote_ds.dart';

class TipoCombustibleViviendaByDptoRepositoryImpl
    implements TipoCombustibleViviendaByDptoRepository {
  final TipoCombustibleViviendaByDptoRemoteDataSource
      tipoCombustibleViviendaByDptoRemoteDataSource;

  TipoCombustibleViviendaByDptoRepositoryImpl(
      {required this.tipoCombustibleViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await tipoCombustibleViviendaByDptoRemoteDataSource
          .getTiposCombustibleViviendaByDpto(dtoId);

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
