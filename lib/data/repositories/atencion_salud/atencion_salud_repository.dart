import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/repositories/atencion_salud/atencion_salud_repository.dart';
import '../../datasources/remote/atencion_salud_remote_ds.dart';

class AtencionSaludRepositoryImpl implements AtencionSaludRepository {
  final AtencionSaludRemoteDataSource atencionSaludRemoteDataSource;

  AtencionSaludRepositoryImpl({required this.atencionSaludRemoteDataSource});

  @override
  Future<Either<Failure, AtencionSaludEntity>>
      uploadAtencionSaludRepository() async {
    try {
      final result = await atencionSaludRemoteDataSource.uploadAtencionSalud();

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
