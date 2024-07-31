import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_vivienda/tipo_vivienda_repository.dart';
import '../../datasources/remote/tipo_vivienda_remote_ds.dart';
import '../../models/tipo_vivienda.dart';

class TipoViviendaRepositoryImpl implements TipoViviendaRepository {
  final TipoViviendaRemoteDataSource tipoViviendaRemoteDataSource;

  TipoViviendaRepositoryImpl({required this.tipoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoViviendaModel>>> getTiposViviendaRepository(
      int dtoId) async {
    try {
      final result = await tipoViviendaRemoteDataSource.getTiposVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
