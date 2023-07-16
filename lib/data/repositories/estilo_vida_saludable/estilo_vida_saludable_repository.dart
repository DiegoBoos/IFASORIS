import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/estilo_vida_saludable_entity.dart';
import '../../../domain/repositories/estilo_vida_saludable/estilo_vida_saludable_repository.dart';
import '../../datasources/remote/estilo_vida_saludable_remote_ds.dart';

class EstiloVidaSaludableRepositoryImpl
    implements EstiloVidaSaludableRepository {
  final EstiloVidaSaludableRemoteDataSource estiloVidaSaludableRemoteDataSource;

  EstiloVidaSaludableRepositoryImpl(
      {required this.estiloVidaSaludableRemoteDataSource});

  @override
  Future<Either<Failure, EstiloVidaSaludableEntity>>
      uploadEstiloVidaSaludableRepository() async {
    try {
      final result =
          await estiloVidaSaludableRemoteDataSource.uploadEstiloVidaSaludable();

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
