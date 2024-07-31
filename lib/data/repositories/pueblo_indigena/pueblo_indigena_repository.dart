import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/pueblo_indigena/pueblo_indigena_repository.dart';
import '../../datasources/remote/pueblo_indigena_remote_ds.dart';
import '../../models/pueblo_indigena.dart';

class PuebloIndigenaRepositoryImpl implements PuebloIndigenaRepository {
  final PuebloIndigenaRemoteDataSource puebloIndigenaRemoteDataSource;

  PuebloIndigenaRepositoryImpl({required this.puebloIndigenaRemoteDataSource});

  @override
  Future<Either<Failure, List<PuebloIndigenaModel>>>
      getPueblosIndigenasRepository(int dtoId) async {
    try {
      final result =
          await puebloIndigenaRemoteDataSource.getPueblosIndigenas(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
