import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/search/search_afiliados.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../widgets/grupo_familiar_form.dart';

class GrupoFamiliarPage extends StatefulWidget {
  const GrupoFamiliarPage(
      {super.key, required this.percentage, required this.registraAfiliados});

  final double percentage;
  final int registraAfiliados;

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarState();
}

class _GrupoFamiliarState extends State<GrupoFamiliarPage> {
  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    if (widget.registraAfiliados == 0) {
      return Column(
        children: [
          const SizedBox(height: 20),
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
                        width: constraints.maxWidth * (widget.percentage / 100),
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
          const SizedBox(height: 20),
          MaterialButton(
              elevation: 0,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => showSearch(
                  context: context,
                  delegate: SearchAfiliados(
                      afiliadoBloc: afiliadoBloc, isGrupoFamiliar: true)),
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
                      title: Text(
                          '${afiliadoGrupoFamiliar.nombre1 ?? ''} ${afiliadoGrupoFamiliar.nombre2 ?? ''} ${afiliadoGrupoFamiliar.apellido1 ?? ''} ${afiliadoGrupoFamiliar.apellido2 ?? ''}'),
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                GrupoFamiliarForm(
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
      );
    } else {
      return Container();
    }
  }
}
