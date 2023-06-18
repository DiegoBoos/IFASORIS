import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/regimen_entity.dart';
import '../../../domain/repositories/regimen/regimen_repository.dart';
import '../../datasources/remote/regimen_remote_ds.dart';

class RegimenRepositoryImpl implements RegimenRepository {
  final RegimenRemoteDataSource regimenRemoteDataSource;

  RegimenRepositoryImpl({required this.regimenRemoteDataSource});

  @override
  Future<Either<Failure, List<RegimenEntity>>> getRegimenesRepository() async {
    try {
      final result = await regimenRemoteDataSource.getRegimenes();

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
