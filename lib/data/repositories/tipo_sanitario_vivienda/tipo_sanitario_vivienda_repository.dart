import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_sanitario_vivienda/tipo_sanitario_vivienda_repository.dart';
import '../../datasources/remote/tipo_sanitario_vivienda_remote_ds.dart';
import '../../models/tipo_sanitario_vivienda.dart';

class TipoSanitarioViviendaRepositoryImpl
    implements TipoSanitarioViviendaRepository {
  final TipoSanitarioViviendaRemoteDataSource
      tipoSanitarioViviendaRemoteDataSource;

  TipoSanitarioViviendaRepositoryImpl(
      {required this.tipoSanitarioViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoSanitarioViviendaModel>>>
      getTiposSanitarioViviendaRepository(int dtoId) async {
    try {
      final result = await tipoSanitarioViviendaRemoteDataSource
          .getTiposSanitarioVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
