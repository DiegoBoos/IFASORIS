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

    on<SaveAfiliadosGrupoFamiliar>((event, emit) async {
      final result = await grupoFamiliarUsecaseDB
          .saveGrupoFamiliarUsecaseDB(event.afiliadosGrupoFamiliar);
      result.fold((failure) {
        emit(AfiliadosGrupoFamiliarError(failure.properties.first));
      }, (data) {
        emit(GrupoFamiliarSubmissionSuccess(
            afiliadosGrupoFamiliarSuccess: event.afiliadosGrupoFamiliar));
      });
    });

    on<CreateOrUpdateAfiliadoGrupoFamiliar>((event, emit) {
      List<GrupoFamiliarEntity> currentAfiliados =
          state.afiliadosGrupoFamiliar ?? [];
      GrupoFamiliarEntity newAfiliado = event.newAfiliado;

      bool isDuplicate = currentAfiliados
          .any((item) => item.afiliadoId == newAfiliado.afiliadoId);

      if (!isDuplicate) {
        List<GrupoFamiliarEntity> newAfiliados = List.from(currentAfiliados)
          ..add(newAfiliado);
        emit(AfiliadosGrupoFamiliarLoaded(
            afiliadosGrupoFamiliarLoaded: newAfiliados,
            message: 'Afiliado agregado correctamente'));
      } else {
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

    on<ErrorAfiliadosGrupoFamiliar>((event, emit) {
      emit(AfiliadosGrupoFamiliarError(event.message));
    });
  }

  Future<int> deleteAfiliadoGrupoFamiliar(
    int afiliadoId,
    int familiaId,
  ) async {
    final result = await grupoFamiliarUsecaseDB
        .deleteAfiliadoGrupoFamiliarUsecaseDB(afiliadoId, familiaId);
    return result.fold((failure) => 0, (data) => data);
  }

  Future<int> completeGrupoFamiliar(int familiaId) async {
    final result =
        await grupoFamiliarUsecaseDB.completeGrupoFamiliarUsecaseDB(familiaId);

    return result.fold((failure) => 0, (data) => data);
  }
}
