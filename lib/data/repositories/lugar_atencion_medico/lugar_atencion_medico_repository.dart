import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_atencion_medico_entity.dart';
import '../../../domain/repositories/lugar_atencion_medico/lugar_atencion_medico_repository.dart';
import '../../datasources/remote/lugar_atencion_medico_remote_ds.dart';

class LugarAtencionMedicoRepositoryImpl
    implements LugarAtencionMedicoRepository {
  final LugarAtencionMedicoRemoteDataSource lugarAtencionMedicoRemoteDataSource;

  LugarAtencionMedicoRepositoryImpl(
      {required this.lugarAtencionMedicoRemoteDataSource});

  @override
  Future<Either<Failure, List<LugarAtencionMedicoEntity>>>
      getLugaresAtencionMedicoRepository() async {
    try {
      final result =
          await lugarAtencionMedicoRemoteDataSource.getLugaresAtencionMedico();

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
