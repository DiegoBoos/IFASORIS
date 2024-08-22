import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_regimen/tipo_regimen_repository.dart';
import '../../datasources/remote/tipo_regimen_remote_ds.dart';
import '../../models/tipo_regimen.dart';

class TipoRegimenRepositoryImpl implements TipoRegimenRepository {
  final TipoRegimenRemoteDataSource tipoRegimenRemoteDataSource;

  TipoRegimenRepositoryImpl({required this.tipoRegimenRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoRegimenModel>>>
      getTipoRegimenesRepository() async {
    try {
      final result = await tipoRegimenRemoteDataSource.getTipoRegimenes();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
