import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/etnia_entity.dart';
import '../../../domain/usecases/etnia/etnia_db_usecase.dart';

part 'etnia_state.dart';

class EtniaCubit extends Cubit<EtniasState> {
  final EtniaUsecaseDB etniaUsecaseDB;

  EtniaCubit({required this.etniaUsecaseDB}) : super(EtniasInitial());

  void getEtniasDB() async {
    final result = await etniaUsecaseDB.getEtniasUsecaseDB();
    result.fold((failure) => emit(EtniasError(failure.properties.first)),
        (data) => emit(EtniasLoaded(data)));
  }
}
