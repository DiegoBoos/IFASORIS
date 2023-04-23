import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ifasoris/ui/ubicacion/pages/grupo_familiar_page.dart';

part 'grupo_familiar_event.dart';
part 'grupo_familiar_state.dart';

class GrupoFamiliarBloc extends Bloc<GrupoFamiliarEvent, GrupoFamiliarState> {
  GrupoFamiliarBloc() : super(GrupoFamiliarInitial()) {
    on<SaveGrupoFamiliar>((event, emit) {
      List<GrupoFamiliarEntity> newItems = List.from(state.grupoFamiliar ?? [])
        ..add(event.grupofamiliar);
      emit(GrupoFamiliarLoaded(grupoFamiliarLoaded: newItems));
    });
  }
}
