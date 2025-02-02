import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../../domain/entities/afiliado.dart';
import '../../domain/entities/familia.dart';
import '../../domain/entities/ficha.dart';
import '../../domain/entities/grupo_familiar.dart';
import '../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../blocs/afiliados/afiliados_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../cubits/afiliado/afiliado_cubit.dart';
import '../cubits/familia/familia_cubit.dart';
import '../cubits/ficha/ficha_cubit.dart';
import '../ficha/widgets/grupo_familiar_form.dart';

class SearchAfiliados extends SearchDelegate {
  final AfiliadosBloc afiliadosBloc;
  final AfiliadoCubit afiliadoCubit;
  final GrupoFamiliarBloc grupoFamiliarBloc;

  final prefs = SharedPreferencesService();

  final bool isGrupoFamiliar;

  SearchAfiliados(
      {required this.afiliadosBloc,
      required this.afiliadoCubit,
      required this.grupoFamiliarBloc,
      this.isGrupoFamiliar = false});

  @override
  String get searchFieldLabel => 'Buscar afiliados';

  @override
  List<Widget> buildActions(BuildContext context) {
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
      return _showGrupoFamiliar();
    } else {
      return _showAfiliados();
    }
  }

  Widget _showGrupoFamiliar() {
    return BlocListener<GrupoFamiliarBloc, GrupoFamiliarEntity>(
      listener: (context, state) {
        if (state.formStatus is GrupoFamiliarError) {
          final msg = (state.formStatus as GrupoFamiliarError).message;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg),
            duration: const Duration(seconds: 2),
          ));
        }
        if (state.formStatus is NuevoGrupoFamiliar) {
          Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    GrupoFamiliarForm(afiliadoGrupoFamiliar: state),
              ));
        }
      },
      child: BlocBuilder<AfiliadosBloc, AfiliadosState>(
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
                                '${afiliado.nombre1} ${afiliado.nombre2} ${afiliado.apellido1} ${afiliado.apellido2}'),
                            onTap: () {
                              grupoFamiliarBloc
                                  .add(CheckFichaAfiliado(afiliado));
                            }),
                        const Divider()
                      ],
                    );
                  }).toList());
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _showAfiliados() {
    return MultiBlocListener(
      listeners: [
        BlocListener<AfiliadoCubit, AfiliadoState>(listener: (context, state) {
          if (state is AfiliadoError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 2),
            ));
          }
          if (state is AfiliadoLoaded) {
            if (state.ficha != null) {
              cargarFicha(context, state.ficha!, state.afiliadoLoaded);
            } else {
              createFicha(context);
            }
          }
        }),
        BlocListener<AfiliadoPrefsBloc, AfiliadoPrefsState>(
            listener: (context, state) {
          if (state is AfiliadoPrefsError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message),
            ));
          }
          if (state is AfiliadoPrefsLoaded) {
            close(context, null);
          }
        }),
        BlocListener<FichaCubit, FichaState>(
          listener: (context, state) {
            if (state is FichaError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ));
            }
            if (state is FichaCreated) {
              final afiliadoCubit = context.read<AfiliadoCubit>();
              final familiaCubit = context.read<FamiliaCubit>();
              final afiliado = afiliadoCubit.state.afiliado!;

              final newFamilia = FamiliaEntity(
                  fichaId: state.fichaCreated.fichaId!,
                  apellidosFlia: '${afiliado.apellido1}  ${afiliado.apellido2}',
                  fkAfiliadoId: afiliado.afiliadoId!);

              familiaCubit.createFamiliaDB(newFamilia);
            }
          },
        ),
        BlocListener<FamiliaCubit, FamiliaState>(
          listener: (context, state) {
            if (state is FamiliaError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ));
            }
            if (state is FamiliaCreated) {
              final afiliadoPrefsBloc = context.read<AfiliadoPrefsBloc>();
              final afiliadoCubit = context.read<AfiliadoCubit>();
              final afiliado = afiliadoCubit.state.afiliado!;
              afiliadoPrefsBloc.add(SaveAfiliado(afiliado.copyWith(
                  familiaId: state.familiaCreated.familiaId)));
            }
          },
        )
      ],
      child: BlocBuilder<AfiliadosBloc, AfiliadosState>(
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
                            '${afiliado.nombre1} ${afiliado.nombre2} ${afiliado.apellido1} ${afiliado.apellido2}'),
                        onTap: () {
                          afiliadoCubit.checkAfiliadoEdad(afiliado);
                        }),
                    const Divider()
                  ],
                );
              }).toList());
            }
          }
          return Container();
        },
      ),
    );
  }

  createFicha(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final fichaCubit = context.read<FichaCubit>();

    final newFicha = FichaEntity(
        fechaCreacion: DateTime.now(),
        numFicha: '',
        userNameCreacion: authBloc.state.usuario!.userName,
        ultimaActualizacion: DateTime.now());

    fichaCubit.createFichaDB(newFicha);
  }

  cargarFicha(
      BuildContext context, FichaEntity ficha, AfiliadoEntity afiliado) {
    final afiliadoPrefsBloc = context.read<AfiliadoPrefsBloc>();
    afiliadoPrefsBloc.add(
        SaveAfiliado(afiliado.copyWith(familiaId: ficha.familia!.familiaId)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    afiliadosBloc.add(QueryChanged(query));
    super.showResults(context);
  }
}
