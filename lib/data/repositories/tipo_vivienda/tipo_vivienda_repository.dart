import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/tipo_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_vivienda/tipo_vivienda_repository.dart';
import '../../datasources/remote/tipo_vivienda_remote_ds.dart';

class TipoViviendaRepositoryImpl implements TipoViviendaRepository {
  final TipoViviendaRemoteDataSource tipoViviendaRemoteDataSource;

  TipoViviendaRepositoryImpl({required this.tipoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoViviendaEntity>>> getTiposViviendaRepository(
      int dtoId) async {
    try {
      final result = await tipoViviendaRemoteDataSource.getTiposVivienda(dtoId);

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
