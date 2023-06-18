import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/parentesco_entity.dart';
import '../../../domain/repositories/parentesco/parentesco_repository.dart';
import '../../datasources/remote/parentesco_remote_ds.dart';

class ParentescoRepositoryImpl implements ParentescoRepository {
  final ParentescoRemoteDataSource parentescoRemoteDataSource;

  ParentescoRepositoryImpl({required this.parentescoRemoteDataSource});

  @override
  Future<Either<Failure, List<ParentescoEntity>>>
      getParentescosRepository() async {
    try {
      final result = await parentescoRemoteDataSource.getParentescos();

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
