import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/parentesco/parentesco_repository.dart';
import '../../datasources/remote/parentesco_remote_ds.dart';
import '../../models/parentesco.dart';

class ParentescoRepositoryImpl implements ParentescoRepository {
  final ParentescoRemoteDataSource parentescoRemoteDataSource;

  ParentescoRepositoryImpl({required this.parentescoRemoteDataSource});

  @override
  Future<Either<Failure, List<ParentescoModel>>>
      getParentescosRepository() async {
    try {
      final result = await parentescoRemoteDataSource.getParentescos();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
