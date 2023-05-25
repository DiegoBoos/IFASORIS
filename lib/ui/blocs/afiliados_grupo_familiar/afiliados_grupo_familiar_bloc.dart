import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';

part 'afiliados_grupo_familiar_event.dart';
part 'afiliados_grupo_familiar_state.dart';

class AfiliadosGrupoFamiliarBloc
    extends Bloc<AfiliadosGrupoFamiliarEvent, AfiliadosGrupoFamiliarState> {
  AfiliadosGrupoFamiliarBloc() : super(AfiliadosGrupoFamiliarInitial()) {
    on<SaveAfiliadoGrupoFamiliar>((event, emit) {
      List<GrupoFamiliarEntity> currentAfiliados =
          state.afiliadosGrupoFamiliar ?? [];
      GrupoFamiliarEntity newAfiliado = event.newAfiliado;

      // Check if the item already exists in the list
      bool isDuplicate = currentAfiliados
          .any((item) => item.afiliadoId == newAfiliado.afiliadoId);

      if (!isDuplicate) {
        // Item is not a duplicate, add it to the list
        List<GrupoFamiliarEntity> newAfiliados = List.from(currentAfiliados)
          ..add(newAfiliado);
        emit(AfiliadosGrupoFamiliarLoaded(
            afiliadosGrupoFamiliarLoaded: newAfiliados));
      } else {
        // Item is a duplicate, emit an appropriate state (e.g., show an error)
        emit(AfiliadosGrupoFamiliarError('Duplicate item',
            currentAfiliadosGrupoFamiliar: currentAfiliados));
      }
    });

    on<UpdateAfiliadoGrupoFamiliar>((event, emit) {
      List<GrupoFamiliarEntity> currentAfiliados =
          state.afiliadosGrupoFamiliar ?? [];
      GrupoFamiliarEntity newAfiliado = event.newAfiliado;

      currentAfiliados = currentAfiliados.map((afiliado) {
        if (afiliado.afiliadoId == newAfiliado.afiliadoId) {
          return newAfiliado;
        }
        return afiliado;
      }).toList();

      emit(AfiliadosGrupoFamiliarLoaded(
          afiliadosGrupoFamiliarLoaded: currentAfiliados));
    });
  }
}
