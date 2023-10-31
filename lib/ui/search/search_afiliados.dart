import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../../domain/entities/afiliado_entity.dart';
import '../../domain/entities/familia_entity.dart';
import '../../domain/entities/ficha_entity.dart';
import '../../domain/entities/grupo_familiar_entity.dart';
import '../blocs/afiliado/afiliado_bloc.dart';
import '../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../cubits/familia/familia_cubit.dart';
import '../cubits/ficha/ficha_cubit.dart';
import '../ficha/widgets/grupo_familiar_form.dart';
import '../utils/custom_snack_bar.dart';

class SearchAfiliados extends SearchDelegate {
  final AfiliadoBloc afiliadoBloc;
  final prefs = SharedPreferencesService();

  final bool isGrupoFamiliar;

  SearchAfiliados({required this.afiliadoBloc, this.isGrupoFamiliar = false});

  @override
  String get searchFieldLabel => 'Buscar afiliado';

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
                            onTap: () async {
                              await afiliadoBloc
                                  .afiliadoTieneFicha(afiliado.afiliadoId!)
                                  .then((afiliadoFicha) async {
                                if (afiliadoFicha != null) {
                                  CustomSnackBar.showCustomDialog(
                                      context,
                                      "Error al agregar al grupo familiar",
                                      "Esta persona ya se encuentra dentro de la ficha de un núcleo familiar",
                                      () => Navigator.pop(context),
                                      false);
                                } else {
                                  final newGrupoFamiliar = GrupoFamiliarEntity(
                                    afiliadoId: afiliado.afiliadoId,
                                    documento: afiliado.documento,
                                    edad: afiliado.edad,
                                    fechaNacimiento: afiliado.fecnac,
                                    nombre1: afiliado.nombre1,
                                    nombre2: afiliado.nombre2,
                                    apellido1: afiliado.apellido1,
                                    apellido2: afiliado.apellido2,
                                    tipoDocAfiliado: afiliado.tipoDocAfiliado,
                                    codGeneroAfiliado:
                                        afiliado.codGeneroAfiliado,
                                    codRegimenAfiliado:
                                        afiliado.codRegimenAfiliado,
                                  );

                                  Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            GrupoFamiliarForm(
                                                afiliadoGrupoFamiliar:
                                                    newGrupoFamiliar),
                                      ));
                                }
                              });
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
                          if (afiliado.edad! >= 14) {
                            await afiliadoBloc
                                .afiliadoTieneFicha(afiliado.afiliadoId!)
                                .then((ficha) {
                              if (ficha != null) {
                                if (ficha.numFicha == null ||
                                    ficha.numFicha == '') {
                                  afiliado.afiliadoId =
                                      ficha.familia!.fkAfiliadoId;

                                  cargarFicha(context, ficha, afiliado);
                                  //   final futures = Future.wait(
                                  //       [familiaFuture, fichaFuture]);

                                  //   futures.then((value) {
                                  //     int familiaId = value[0];
                                  //     int fichaId = value[1];

                                  // CustomSnackBar.showCustomDialog(
                                  //     context,
                                  //     "Esta persona ya se encuentra dentro de la ficha de un núcleo familiar",
                                  //     "¿Desea crear una nueva ficha con esta persona como un nuevo núcleo de familia?",
                                  //     () async {
                                  //   final familiaCubit =
                                  //       BlocProvider.of<FamiliaCubit>(context);
                                  //   final fichaCubit =
                                  //       BlocProvider.of<FichaCubit>(context);

                                  //   //Elimina el afiliado de la familia
                                  //   final familiaFuture =
                                  //       familiaCubit.deleteAfiliadoFamilia(
                                  //           afiliado.afiliadoId!);

                                  //   //Elimina la ficha
                                  //   final fichaFuture =
                                  //       fichaCubit.deleteFicha(ficha.fichaId!);

                                  //   final futures = Future.wait(
                                  //       [familiaFuture, fichaFuture]);

                                  //   futures.then((value) {
                                  //     int familiaId = value[0];
                                  //     int fichaId = value[1];

                                  //     if (familiaId != 0 && fichaId != 0) {
                                  //       createFicha(context, afiliado);
                                  //     }
                                  //   });
                                  // });
                                } else {
                                  CustomSnackBar.showCustomDialog(
                                      context,
                                      "Afiliado ya registrado",
                                      "El afiliado se encuentra registrado en la ficha No. ${ficha.numFicha}",
                                      () => Navigator.pop(context),
                                      false);
                                }
                              } else {
                                createFicha(context, afiliado);
                              }
                            });
                          } else {
                            CustomSnackBar.showCustomDialog(
                                context,
                                "Error al crear ficha",
                                "Este afiliado es menor de 14 años",
                                () => Navigator.pop(context),
                                false);
                          }
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
    }
  }

  Future<void> createFicha(
      BuildContext context, AfiliadoEntity afiliado) async {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final familiaCubit = BlocProvider.of<FamiliaCubit>(context);
    final fichaCubit = BlocProvider.of<FichaCubit>(context);

    final newFicha = FichaEntity(
        fechaCreacion: DateTime.now(),
        numFicha: '',
        userNameCreacion: authBloc.state.usuario!.userName,
        ultimaActualizacion: DateTime.now());

    final respFicha = await fichaCubit.createFichaDB(newFicha);

    if (respFicha != null) {
      final newFamilia = FamiliaEntity(
          fichaId: respFicha.fichaId!,
          apellidosFlia: '${afiliado.apellido1}  ${afiliado.apellido2}',
          fkAfiliadoId: afiliado.afiliadoId!);

      await familiaCubit.createFamiliaDB(newFamilia).then((value) {
        if (value != null) {
          afiliadoPrefsBloc
              .add(SaveAfiliado(afiliado.copyWith(familiaId: value.familiaId)));

          close(context, null);
        } else {
          afiliadoPrefsBloc
              .add(const AfiliadoPrefsError("Error al crear ficha"));
          close(context, null);
        }
      });
    }
  }

  Future<void> cargarFicha(
      BuildContext context, FichaEntity ficha, AfiliadoEntity afiliado) async {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);

    afiliadoPrefsBloc.add(
        SaveAfiliado(afiliado.copyWith(familiaId: ficha.familia!.familiaId)));
    close(context, null);
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
