import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../domain/repositories/tipo_combustible_vivienda/tipo_combustible_vivienda_repository.dart';
import '../../datasources/remote/tipo_combustible_vivienda_remote_ds.dart';

class TipoCombustibleViviendaRepositoryImpl
    implements TipoCombustibleViviendaRepository {
  final TipoCombustibleViviendaRemoteDataSource
      tipoCombustibleViviendaRemoteDataSource;

  TipoCombustibleViviendaRepositoryImpl(
      {required this.tipoCombustibleViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaRepository(int dtoId) async {
    try {
      final result = await tipoCombustibleViviendaRemoteDataSource
          .getTiposCombustibleVivienda(dtoId);

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
