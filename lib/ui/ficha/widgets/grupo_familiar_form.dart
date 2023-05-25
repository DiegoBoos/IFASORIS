import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/ficha/pages/grupo_familiar_page.dart';

import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';

class GrupoFamiliar extends StatefulWidget {
  const GrupoFamiliar({super.key});

  @override
  State<GrupoFamiliar> createState() => _GrupoFamiliarState();
}

class _GrupoFamiliarState extends State<GrupoFamiliar> {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AfiliadosGrupoFamiliarBloc,
        AfiliadosGrupoFamiliarState>(
      listener: (context, state) {
        if (state is AfiliadosGrupoFamiliarLoaded ||
            state is AfiliadosGrupoFamiliarError) {
          final grupoFamiliarCompleted = state.afiliadosGrupoFamiliar!
              .where((element) => element.isCompleted == true)
              .length;
          setState(() {
            percentage = (grupoFamiliarCompleted /
                    state.afiliadosGrupoFamiliar!.length) *
                100;
          });
        }
      },
      child: Column(
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
                        width: constraints.maxWidth * (percentage / 100),
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
                        style: TextStyle(color: Colors.black),
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
          BlocBuilder<AfiliadosGrupoFamiliarBloc, AfiliadosGrupoFamiliarState>(
            builder: (context, state) {
              if (state is AfiliadosGrupoFamiliarLoaded ||
                  state is AfiliadosGrupoFamiliarError) {
                final afiliadosGrupoFamiliar = state.afiliadosGrupoFamiliar!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: afiliadosGrupoFamiliar.length,
                  itemBuilder: (BuildContext context, int index) {
                    final afiliadoGrupoFamiliar = afiliadosGrupoFamiliar[index];
                    return ListTile(
                      title: Text(afiliadoGrupoFamiliar.afiliadoId.toString()),
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                GrupoFamiliarPage(
                                    afiliadoGrupoFamiliar:
                                        afiliadoGrupoFamiliar),
                          ),
                        );
                      },
                      trailing: !afiliadoGrupoFamiliar.isCompleted!
                          ? const SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.arrow_right,
                              ),
                            )
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
      ),
    );
  }
}
