import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/consumo_alcohol_entity.dart';
import '../../../domain/usecases/consumo_alcohol/consumo_alcohol_db_usecase.dart';

part 'consumo_alcohol_state.dart';

class ConsumoAlcoholCubit extends Cubit<ConsumosAlcoholState> {
  final ConsumoAlcoholUsecaseDB consumoAlcoholUsecaseDB;

  ConsumoAlcoholCubit({required this.consumoAlcoholUsecaseDB})
      : super(ConsumosAlcoholInitial());

  void getConsumoAlcoholDB() async {
    final result = await consumoAlcoholUsecaseDB.getConsumosAlcoholUsecaseDB();
    result.fold(
        (failure) => emit(ConsumosAlcoholError(failure.properties.first)),
        (data) => emit(ConsumosAlcoholLoaded(data)));
  }
}
