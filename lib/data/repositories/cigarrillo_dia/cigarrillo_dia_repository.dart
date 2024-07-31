import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/cigarrillo_dia/cigarrillo_dia_repository.dart';
import '../../datasources/remote/cigarrillo_dia_remote_ds.dart';
import '../../models/cigarrillo_dia.dart';

class CigarrilloDiaRepositoryImpl implements CigarrilloDiaRepository {
  final CigarrilloDiaRemoteDataSource cigarrilloDiaRemoteDataSource;

  CigarrilloDiaRepositoryImpl({required this.cigarrilloDiaRemoteDataSource});

  @override
  Future<Either<Failure, List<CigarrilloDiaModel>>>
      getCigarrillosDiaRepository() async {
    try {
      final result = await cigarrilloDiaRemoteDataSource.getCigarrillosDia();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
