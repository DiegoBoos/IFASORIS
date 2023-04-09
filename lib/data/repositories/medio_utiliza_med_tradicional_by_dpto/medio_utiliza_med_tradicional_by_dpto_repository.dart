import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_med_tradicional_by_dpto_entity.dart';
import '../../../domain/repositories/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_repository.dart';
import '../../datasources/remote/medio_utiliza_med_tradicional_by_dpto_remote_ds.dart';

class MedioUtilizaMedTradicionalByDptoRepositoryImpl
    implements MedioUtilizaMedTradicionalByDptoRepository {
  final MedioUtilizaMedTradicionalByDptoRemoteDataSource
      medioUtilizaMedTradicionalByDptoRemoteDataSource;

  MedioUtilizaMedTradicionalByDptoRepositoryImpl(
      {required this.medioUtilizaMedTradicionalByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaMedTradicionalByDptoEntity>>>
      getMediosUtilizaMedTradicionalByDptoRepository(int dtoId) async {
    try {
      final result = await medioUtilizaMedTradicionalByDptoRemoteDataSource
          .getMediosUtilizaMedTradicionalByDpto(dtoId);

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
