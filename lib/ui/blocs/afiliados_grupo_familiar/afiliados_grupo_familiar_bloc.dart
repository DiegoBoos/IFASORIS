import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/usecases/grupo_familiar/grupo_familiar_db_usecase.dart';

part 'afiliados_grupo_familiar_event.dart';
part 'afiliados_grupo_familiar_state.dart';

class AfiliadosGrupoFamiliarBloc
    extends Bloc<AfiliadosGrupoFamiliarEvent, AfiliadosGrupoFamiliarState> {
  final GrupoFamiliarUsecaseDB grupoFamiliarUsecaseDB;

  AfiliadosGrupoFamiliarBloc({required this.grupoFamiliarUsecaseDB})
      : super(AfiliadosGrupoFamiliarInitial()) {
    on<ExisteAfiliadoCabezaFamilia>((event, emit) async {
      emit(AfiliadosGrupoFamiliarLoading());
      final result = await grupoFamiliarUsecaseDB
          .existeAfiliadoCabezaFamiliaUsecaseDB(event.familiaId);
      result.fold((failure) {
        emit(const AfiliadosGrupoFamiliarError(
          'Excepción no controlada',
        ));
      }, (data) => emit(AfiliadoCabezaFamiliaLoaded(data)));
    });

    on<GetAfiliadosGrupoFamiliar>((event, emit) async {
      emit(AfiliadosGrupoFamiliarLoading());
      final result = await grupoFamiliarUsecaseDB
          .getGrupoFamiliarUsecaseDB(event.familiaId);
      result.fold((failure) {
        emit(const AfiliadosGrupoFamiliarError(
          'Excepción no controlada',
        ));
      }, (data) {
        if (data.isNotEmpty) {
          emit(
              AfiliadosGrupoFamiliarLoaded(afiliadosGrupoFamiliarLoaded: data));
        } else {
          emit(AfiliadosGrupoFamiliarInitial());
        }
      });
    });

    on<AddOrEditAfiliadoGrupoFamiliar>((event, emit) async {
      List<GrupoFamiliarEntity> currentAfiliados =
          state.afiliadosGrupoFamiliar ?? [];
      GrupoFamiliarEntity newAfiliado = event.newAfiliado;

      final result = await grupoFamiliarUsecaseDB
          .saveAfiliadoGrupoFamiliarUsecaseDB(event.newAfiliado);
      result.fold((failure) {
        emit(const AfiliadosGrupoFamiliarError(
          'Excepción no controlada',
        ));
      }, (data) {
        if (data['res'] > 0 && !data['existeRegistro']) {
          newAfiliado.grupoFamiliarId = data['res'];
          List<GrupoFamiliarEntity> newAfiliados = List.from(currentAfiliados)
            ..add(newAfiliado);
          emit(AfiliadosGrupoFamiliarLoaded(
              afiliadosGrupoFamiliarLoaded: newAfiliados,
              message: 'Afiliado agregado correctamente'));
        } else if (data['res'] > 0 && data['existeRegistro']) {
          currentAfiliados = currentAfiliados.map((afiliado) {
            if (afiliado.afiliadoId == newAfiliado.afiliadoId) {
              return newAfiliado;
            }
            return afiliado;
          }).toList();

          emit(AfiliadosGrupoFamiliarLoaded(
              afiliadosGrupoFamiliarLoaded: currentAfiliados,
              message: 'Afiliado editado correctamente'));
        }
      });
    });

    on<ErrorAfiliadosGrupoFamiliar>((event, emit) {
      emit(AfiliadosGrupoFamiliarError(event.message));
    });
  }
}
