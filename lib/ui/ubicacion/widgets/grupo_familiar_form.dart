import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';

class GrupoFamiliar extends StatelessWidget {
  const GrupoFamiliar({super.key});

  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context, listen: true);
    final grupoFamiliarBloc =
        BlocProvider.of<GrupoFamiliarBloc>(context, listen: true);

    final afiliadosLength = afiliadoBloc.state.afiliados?.length ?? 1;
    final grupoFamiliarLength =
        grupoFamiliarBloc.state.grupoFamiliar?.length ?? 1;

    final percentage = (afiliadosLength / grupoFamiliarLength) * 100;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 3),
              borderRadius: BorderRadius.circular(50)),
          child: Stack(
            children: [
              LayoutBuilder(
                  builder: (context, constraints) => Container(
                      width: constraints.maxWidth * percentage,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.greenAccent,
                              Colors.green,
                            ],
                          )))),
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Progreso',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.percent)
                  ],
                ),
              ))
            ],
          ),
        ),
        MaterialButton(
            elevation: 0,
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.pushNamed(context, 'search-afiliado');
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const Text(
                'Agregar afiliado',
                style: TextStyle(color: Colors.white),
              ),
            )),
        BlocBuilder<GrupoFamiliarBloc, GrupoFamiliarState>(
          builder: (context, state) {
            if (state is GrupoFamiliarLoaded) {
              final grupoFamiliar = state.grupoFamiliar!;
              return ListView.builder(
                itemCount: grupoFamiliar.length,
                itemBuilder: (BuildContext context, int index) {
                  final afiliado = grupoFamiliar[index];
                  return ListTile(
                    title: Text(afiliado.afiliadoId.toString()),
                    trailing: afiliado.isCompleted
                        ? IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'grupo-familiar');
                            },
                            icon: const Icon(Icons.arrow_right))
                        : Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                  );
                },
              );
            } else {
              return const Center(
                  child: Text('No hay afiliados en el grupo familiar'));
            }
          },
        ),
      ],
    );
  }
}
