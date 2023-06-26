import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'package:ifasoris/ui/blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import 'package:ifasoris/ui/blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';

import '../../domain/entities/grupo_familiar_entity.dart';

class SearchAfiliados extends SearchDelegate {
  final AfiliadoBloc afiliadoBloc;
  final prefs = SharedPreferencesService();

  final bool isGrupoFamiliar;

  SearchAfiliados({required this.afiliadoBloc, this.isGrupoFamiliar = false});

  @override
  String get searchFieldLabel => 'Buscar afiliado';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    if (isGrupoFamiliar) {
      return BlocBuilder<AfiliadoBloc, AfiliadosState>(
        builder: (context, state) {
          if (state is AfiliadosLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AfiliadosError) {
            return Center(child: Text(state.message));
          }
          if (state is AfiliadosLoaded) {
            if (state.afiliadosLoaded!.isEmpty) {
              return const Center(child: Text('No hay resultados'));
            } else {
              return ListView(
                  shrinkWrap: true,
                  children: state.afiliadosLoaded!.map((afiliado) {
                    return Column(
                      children: [
                        ListTile(
                            title: Text('${afiliado.documento}'),
                            subtitle: Text(
                                '${afiliado.nombre1 ?? ''} ${afiliado.nombre2 ?? ''} ${afiliado.apellido1 ?? ''} ${afiliado.apellido2 ?? ''}'),
                            onTap: () {
                              final newGrupoFamiliar = GrupoFamiliarEntity(
                                afiliadoId: afiliado.afiliadoId,
                                tipoDocumento: afiliado.tipoDocAfiliado,
                                documento: afiliado.documento,
                                nombre1: afiliado.nombre1,
                                nombre2: afiliado.nombre2,
                                apellido1: afiliado.apellido1,
                                apellido2: afiliado.apellido2,
                                genero: afiliado.codGeneroAfiliado,
                                fechaNac: afiliado.fecnac,
                              );

                              BlocProvider.of<AfiliadosGrupoFamiliarBloc>(
                                      context)
                                  .add(SaveAfiliadoGrupoFamiliar(
                                      newGrupoFamiliar));
                              Navigator.pop(context);
                            }),
                        const Divider()
                      ],
                    );
                  }).toList());
            }
          }
          return Container();
        },
      );
    } else {
      return BlocBuilder<AfiliadoBloc, AfiliadosState>(
        builder: (context, state) {
          if (state is AfiliadosLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AfiliadosError) {
            return Center(child: Text(state.message));
          }
          if (state is AfiliadosLoaded) {
            if (state.afiliadosLoaded!.isEmpty) {
              return const Center(child: Text('No hay resultados'));
            } else {
              return ListView(
                  children: state.afiliadosLoaded!.map((afiliado) {
                return Column(
                  children: [
                    ListTile(
                      title: Text('${afiliado.documento}'),
                      subtitle: Text(
                          '${afiliado.nombre1 ?? ''} ${afiliado.nombre2 ?? ''} ${afiliado.apellido1 ?? ''} ${afiliado.apellido2 ?? ''}'),
                      onTap: () async {
                        final afiliadoPrefsBloc =
                            BlocProvider.of<AfiliadoPrefsBloc>(context);

                        final afiliadoHasFicha = await afiliadoBloc
                            .afiliadoHasFicha(afiliado.afiliadoId!)
                            .whenComplete(() => close(context, null));
                        if (afiliadoHasFicha != null) {
                          afiliadoPrefsBloc.add(SaveAfiliado(afiliadoHasFicha));
                        } else {
                          afiliadoPrefsBloc.add(SaveAfiliado(afiliado));
                        }
                      },
                    ),
                    const Divider()
                  ],
                );
              }).toList());
            }
          }
          return Container();
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    afiliadoBloc.add(QueryChanged(query));
    super.showResults(context);
  }
}
