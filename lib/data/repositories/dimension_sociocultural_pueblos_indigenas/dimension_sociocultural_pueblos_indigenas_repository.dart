import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository.dart';
import '../../datasources/remote/dimension_sociocultural_pueblos_indigenas_remote_ds.dart';

class DimensionSocioculturalPueblosIndigenasRepositoryImpl
    implements DimensionSocioculturalPueblosIndigenasRepository {
  final DimensionSocioculturalPueblosIndigenasRemoteDataSource
      dimensionSocioculturalPueblosIndigenasRemoteDataSource;

  DimensionSocioculturalPueblosIndigenasRepositoryImpl(
      {required this.dimensionSocioculturalPueblosIndigenasRemoteDataSource});

  @override
  Future<Either<Failure, DimensionSocioculturalPueblosIndigenasEntity>>
      uploadDimensionSocioculturalPueblosIndigenasRepository() async {
    try {
      final result =
          await dimensionSocioculturalPueblosIndigenasRemoteDataSource
              .uploadDimensionSocioculturalPueblosIndigenas();

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
