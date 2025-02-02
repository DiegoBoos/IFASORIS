import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_calendario/tipo_calendario_repository.dart';
import '../../datasources/remote/tipo_calendario_remote_ds.dart';
import '../../models/tipo_calendario.dart';

class TipoCalendarioRepositoryImpl implements TipoCalendarioRepository {
  final TipoCalendarioRemoteDataSource tipoCalendarioRemoteDataSource;

  TipoCalendarioRepositoryImpl({required this.tipoCalendarioRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoCalendarioModel>>>
      getTiposCalendarioRepository() async {
    try {
      final result = await tipoCalendarioRemoteDataSource.getTiposCalendario();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
