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
        emit(GrupoFamiliarSubmissionFailed(failure.properties.first));
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
        emit(AfiliadosGrupoFamiliarSaved(
            afiliadosGrupoFamiliarSaved: newAfiliados,
            message: 'Afiliado agregado correctamente'));
      } else {
        currentAfiliados = currentAfiliados.map((afiliado) {
          if (afiliado.afiliadoId == newAfiliado.afiliadoId) {
            return newAfiliado;
          }
          return afiliado;
        }).toList();

        emit(AfiliadosGrupoFamiliarSaved(
            afiliadosGrupoFamiliarSaved: currentAfiliados,
            message: 'Afiliado editado correctamente'));
      }
    });

    on<ErrorMessage>((event, emit) {
      emit(AfiliadosGrupoFamiliarError(event.message));
    });
  }

  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId) async {
    final result = await grupoFamiliarUsecaseDB
        .deleteAfiliadoGrupoFamiliarUsecaseDB(afiliadoId);
    return result.fold((failure) => 0, (data) => data);
  }

  Future<int> existeAfiliadoGrupoFamiliar(int afiliadoId) async {
    final result = await grupoFamiliarUsecaseDB
        .existeAfiliadoGrupoFamiliarUsecaseDB(afiliadoId);
    return result.fold((failure) => 0, (data) => data);
  }
}
