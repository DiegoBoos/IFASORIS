import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/afiliado.dart';
import '../../../domain/usecases/afiliado/afiliado_db_usecase.dart';
import '../../cubits/familia/familia_cubit.dart';
import '../../cubits/ficha/ficha_cubit.dart';
import '../afiliado_prefs/afiliado_prefs_bloc.dart';

part 'afiliados_event.dart';
part 'afiliados_state.dart';

class AfiliadosBloc extends Bloc<AfiliadosEvent, AfiliadosState> {
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  final AfiliadoPrefsBloc afiliadoPrefsBloc;
  final FamiliaCubit familiaCubit;
  final FichaCubit fichaCubit;

  AfiliadosBloc(
      {required this.afiliadoUsecaseDB,
      required this.afiliadoPrefsBloc,
      required this.familiaCubit,
      required this.fichaCubit})
      : super(AfiliadosInitial()) {
    on<QueryChanged>((event, emit) async {
      emit(AfiliadosLoading());
      await _searchAfiliados(event, emit);
    });
    on<ErrorMessage>((event, emit) async {
      emit(AfiliadosError(event.message));
    });
  }

  _searchAfiliados(QueryChanged event, Emitter<AfiliadosState> emit) async {
    final result = await afiliadoUsecaseDB.getAfiliadosUsecaseDB(event.query);

    result.fold((failure) => emit(AfiliadosError(failure.properties.first)),
        (data) => emit(AfiliadosLoaded(afiliadosLoaded: data)));
  }
}
