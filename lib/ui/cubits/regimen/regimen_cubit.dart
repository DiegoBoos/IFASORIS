import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/regimen_entity.dart';
import '../../../domain/usecases/regimen/regimen_db_usecase.dart';

part 'regimen_state.dart';

class RegimenCubit extends Cubit<RegimenesState> {
  final RegimenUsecaseDB regimenUsecaseDB;

  RegimenCubit({required this.regimenUsecaseDB}) : super(RegimenesInitial());

  void getRegimenesDB() async {
    final result = await regimenUsecaseDB.getRegimenesUsecaseDB();
    result.fold((failure) => emit(RegimenesError(failure.properties.first)),
        (data) => emit(RegimenesLoaded(data)));
  }
}
