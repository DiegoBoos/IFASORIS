import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/pueblo_indigena_entity.dart';
import '../../../domain/usecases/pueblo_indigena/pueblo_indigena_db_usecase.dart';

part 'pueblo_indigena_state.dart';

class PuebloIndigenaCubit extends Cubit<PueblosIndigenasState> {
  final PuebloIndigenaUsecaseDB puebloIndigenaUsecaseDB;

  PuebloIndigenaCubit({required this.puebloIndigenaUsecaseDB})
      : super(PueblosIndigenasInitial());

  void getPueblosIndigenasDB() async {
    final result = await puebloIndigenaUsecaseDB.getPueblosIndigenasUsecaseDB();
    result.fold(
        (failure) => emit(PueblosIndigenasError(failure.properties.first)),
        (data) => emit(PueblosIndigenasLoaded(data)));
  }
}
