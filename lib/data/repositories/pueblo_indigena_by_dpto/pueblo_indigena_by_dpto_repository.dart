import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/pueblo_indigena_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_repository.dart';
import '../../datasources/remote/pueblo_indigena_by_dpto_remote_ds.dart';

class PuebloIndigenaByDptoRepositoryImpl
    implements PuebloIndigenaByDptoRepository {
  final PuebloIndigenaByDptoRemoteDataSource
      puebloIndigenaByDptoRemoteDataSource;

  PuebloIndigenaByDptoRepositoryImpl(
      {required this.puebloIndigenaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasByDptoRepository(int dtoId) async {
    try {
      final result = await puebloIndigenaByDptoRemoteDataSource
          .getPueblosIndigenasByDpto(dtoId);

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
