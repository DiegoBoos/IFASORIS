import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_repository.dart';
import '../../datasources/remote/tiempo_tarda_med_tradicional_remote_ds.dart';
import '../../models/tiempo_tarda_med_tradicional.dart';

class TiempoTardaMedTradicionalRepositoryImpl
    implements TiempoTardaMedTradicionalRepository {
  final TiempoTardaMedTradicionalRemoteDataSource
      tiempoTardaMedTradicionalRemoteDataSource;

  TiempoTardaMedTradicionalRepositoryImpl(
      {required this.tiempoTardaMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaMedTradicionalModel>>>
      getTiemposTardaMedTradicionalRepository() async {
    try {
      final result = await tiempoTardaMedTradicionalRemoteDataSource
          .getTiemposTardaMedTradicional();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
