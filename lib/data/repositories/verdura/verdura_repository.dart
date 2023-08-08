import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/verdura_entity.dart';
import '../../../domain/repositories/verdura/verdura_repository.dart';
import '../../datasources/remote/verdura_remote_ds.dart';

class VerduraRepositoryImpl implements VerduraRepository {
  final VerduraRemoteDataSource verduraRemoteDataSource;

  VerduraRepositoryImpl({required this.verduraRemoteDataSource});

  @override
  Future<Either<Failure, List<VerduraEntity>>> getVerdurasRepository(
      int dtoId) async {
    try {
      final result = await verduraRemoteDataSource.getVerduras(dtoId);

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
