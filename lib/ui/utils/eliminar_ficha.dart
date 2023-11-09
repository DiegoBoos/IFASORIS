import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/afiliado_entity.dart';
import '../blocs/afiliado/afiliado_bloc.dart';
import '../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../cubits/familia/familia_cubit.dart';
import '../cubits/ficha/ficha_cubit.dart';

Future<void> eliminarFicha(
    BuildContext context, AfiliadoEntity afiliado) async {
  final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
  final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);

  await afiliadoBloc
      .afiliadoTieneFicha(afiliado.afiliadoId!)
      .then((ficha) async {
    if (ficha != null) {
      final familiaCubit = BlocProvider.of<FamiliaCubit>(context);
      final fichaCubit = BlocProvider.of<FichaCubit>(context);

      //Elimina el afiliado de la familia
      final familiaFuture =
          familiaCubit.deleteAfiliadoFamilia(afiliado.afiliadoId!);

      //Elimina la ficha
      final fichaFuture = fichaCubit.deleteFicha(ficha.fichaId!);

      final futures = Future.wait([familiaFuture, fichaFuture]);

      futures.then((value) {
        int familiaId = value[0];
        int fichaId = value[1];

        if (familiaId != 0 && fichaId != 0) {
          afiliadoPrefsBloc
              .add(const DeleteAfiliado('Ficha eliminada correctamente'));
        }
      });
    } else {
      afiliadoBloc
          .add(const ErrorMessage('No se puede eliminar una ficha incompleta'));
    }
  });
}
