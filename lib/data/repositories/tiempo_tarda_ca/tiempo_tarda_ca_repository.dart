import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tiempo_tarda_ca/tiempo_tarda_ca_repository.dart';
import '../../datasources/remote/tiempo_tarda_ca_remote_ds.dart';
import '../../models/tiempo_tarda_ca.dart';

class TiempoTardaCARepositoryImpl implements TiempoTardaCARepository {
  final TiempoTardaCARemoteDataSource tiempoTardaCARemoteDataSource;

  TiempoTardaCARepositoryImpl({required this.tiempoTardaCARemoteDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaCAModel>>>
      getTiemposTardaCARepository() async {
    try {
      final result = await tiempoTardaCARemoteDataSource.getTiemposTardaCA();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
