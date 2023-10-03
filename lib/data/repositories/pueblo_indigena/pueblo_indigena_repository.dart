import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/pueblo_indigena_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/pueblo_indigena/pueblo_indigena_repository.dart';
import '../../datasources/remote/pueblo_indigena_remote_ds.dart';

class PuebloIndigenaRepositoryImpl implements PuebloIndigenaRepository {
  final PuebloIndigenaRemoteDataSource puebloIndigenaRemoteDataSource;

  PuebloIndigenaRepositoryImpl({required this.puebloIndigenaRemoteDataSource});

  @override
  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasRepository(int dtoId) async {
    try {
      final result =
          await puebloIndigenaRemoteDataSource.getPueblosIndigenas(dtoId);

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
