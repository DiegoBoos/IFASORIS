import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../../domain/entities/verdura_entity.dart';
import '../../../domain/usecases/verdura/verdura_db_usecase.dart';

part 'verdura_state.dart';

class VerduraCubit extends Cubit<VerdurasState> {
  final VerduraUsecaseDB verduraUsecaseDB;

  VerduraCubit({required this.verduraUsecaseDB}) : super(VerdurasInitial());

  void getVerdurasDB() async {
    final result = await verduraUsecaseDB.getVerdurasUsecaseDB();
    result.fold((failure) => emit(VerdurasError(failure.properties.first)),
        (data) => emit(VerdurasLoaded(data)));
  }

  Future<List<LstVerdura>> getUbicacionVerdurasDB(int? ubicacionId) async {
    final result =
        await verduraUsecaseDB.getUbicacionVerdurasUsecaseDB(ubicacionId);
    return result.fold((failure) => [], (data) => data);
  }
}
