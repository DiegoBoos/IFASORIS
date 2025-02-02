import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/entities/ficha.dart';

import '../../../domain/entities/afiliado.dart';
import '../../../domain/usecases/afiliado/afiliado_db_usecase.dart';

part 'afiliado_state.dart';

class AfiliadoCubit extends Cubit<AfiliadoState> {
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  AfiliadoCubit({required this.afiliadoUsecaseDB}) : super(AfiliadoInitial());

  checkAfiliadoEdad(AfiliadoEntity afiliado) {
    if (afiliado.edad! >= 14) {
      checkFichaAfiliado(afiliado);
    } else {
      emit(AfiliadoError('Este afiliados es menor de 14 años'));
    }
  }

  checkFichaAfiliado(AfiliadoEntity afiliado) async {
    final result = await afiliadoUsecaseDB
        .afiliadoTieneFichaRepositoryDB(afiliado.afiliadoId!);

    result.fold((failure) => emit(AfiliadoError(failure.properties.first)),
        (data) {
      if (data != null) {
        if (data.numFicha == null || data.numFicha!.isEmpty) {
          final newAfiliado =
              afiliado.copyWith(afiliadoId: data.familia!.fkAfiliadoId);

          emit(AfiliadoLoaded(newAfiliado, fichaLoaded: data));
        } else {
          emit(AfiliadoError(
              'El afiliado se encuentra registrado en la ficha No. ${data.numFicha}'));
        }
      } else {
        emit(AfiliadoLoaded(afiliado));
      }
    });
  }

  eliminarFicha(int afiliadoId) async {
    final result = await afiliadoUsecaseDB
        .afiliadoTieneFichaReportadaRepositoryDB(afiliadoId);

    result.fold((failure) => emit(AfiliadoError(failure.properties.first)),
        (data) => emit(AfiliadoFichaReportada(data)));
  }
}
