import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lengua_maneja_entity.dart';
import '../../../domain/repositories/lengua_maneja/lengua_maneja_repository.dart';
import '../../datasources/remote/lengua_maneja_remote_ds.dart';

class LenguaManejaRepositoryImpl implements LenguaManejaRepository {
  final LenguaManejaRemoteDataSource lenguaManejaRemoteDataSource;

  LenguaManejaRepositoryImpl({required this.lenguaManejaRemoteDataSource});

  @override
  Future<Either<Failure, List<LenguaManejaEntity>>>
      getLenguasManejaRepository() async {
    try {
      final result = await lenguaManejaRemoteDataSource.getLenguasManeja();

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
