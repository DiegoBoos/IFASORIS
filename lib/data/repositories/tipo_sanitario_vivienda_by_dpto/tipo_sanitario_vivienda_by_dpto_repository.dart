import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../domain/repositories/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/tipo_sanitario_vivienda_by_dpto_remote_ds.dart';

class TipoSanitarioViviendaByDptoRepositoryImpl
    implements TipoSanitarioViviendaByDptoRepository {
  final TipoSanitarioViviendaByDptoRemoteDataSource
      tipoSanitarioViviendaByDptoRemoteDataSource;

  TipoSanitarioViviendaByDptoRepositoryImpl(
      {required this.tipoSanitarioViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await tipoSanitarioViviendaByDptoRemoteDataSource
          .getTiposSanitarioViviendaByDpto(dtoId);

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
