import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/entities/grupo_familiar_entity.dart';

import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';

class GrupoFamiliarPage extends StatelessWidget {
  const GrupoFamiliarPage({super.key, this.afiliadoGrupoFamiliar});

  final GrupoFamiliarEntity? afiliadoGrupoFamiliar;

  @override
  Widget build(BuildContext context) {
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupo familiar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(afiliadoGrupoFamiliar!.afiliadoId.toString())),
          Center(
              child: TextButton(
                  onPressed: () {
                    afiliadosGrupoFamiliarBloc.add(UpdateAfiliadoGrupoFamiliar(
                        afiliadoGrupoFamiliar!.copyWith(isCompleted: true)));
                  },
                  child: const Text('Completar'))),
          Center(
              child: TextButton(
                  onPressed: () {
                    afiliadoGrupoFamiliar!.isCompleted = false;
                    afiliadosGrupoFamiliarBloc.add(UpdateAfiliadoGrupoFamiliar(
                        afiliadoGrupoFamiliar!.copyWith(isCompleted: false)));
                  },
                  child: const Text('Desactivar')))
        ],
      ),
    );
  }
}
