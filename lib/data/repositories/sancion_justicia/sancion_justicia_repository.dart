import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/sancion_justicia_entity.dart';
import '../../../domain/repositories/sancion_justicia/sancion_justicia_repository.dart';
import '../../datasources/remote/sancion_justicia_remote_ds.dart';

class SancionJusticiaRepositoryImpl implements SancionJusticiaRepository {
  final SancionJusticiaRemoteDataSource sancionJusticiaRemoteDataSource;

  SancionJusticiaRepositoryImpl(
      {required this.sancionJusticiaRemoteDataSource});

  @override
  Future<Either<Failure, List<SancionJusticiaEntity>>>
      getSancionesJusticiaRepository() async {
    try {
      final result =
          await sancionJusticiaRemoteDataSource.getSancionesJusticia();

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
