import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/evento_costumbre_participa_model.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/usecases/evento_costumbre_participa/evento_costumbre_participa_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../../domain/usecases/sancion_justicia/sancion_justicia_exports.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import '../../cubits/costumbre_practica/costumbre_practica_cubit.dart';
import '../../cubits/religion_profesa/religion_profesa_cubit.dart';

class DimensionSocioCulturalPueblosIndigenasForm extends StatefulWidget {
  const DimensionSocioCulturalPueblosIndigenasForm(
      {super.key,
      required this.currentAfiliado,
      required this.dimensionSocioCulturalPueblosIndigenas});

  final GrupoFamiliarEntity currentAfiliado;
  final DimensionSocioCulturalPueblosIndigenasEntity
      dimensionSocioCulturalPueblosIndigenas;

  @override
  State<DimensionSocioCulturalPueblosIndigenasForm> createState() =>
      _DimensionSocioCulturalPueblosIndigenasFormState();
}

class _DimensionSocioCulturalPueblosIndigenasFormState
    extends State<DimensionSocioCulturalPueblosIndigenasForm> {
  final _nombresApellidosCtrl = TextEditingController();
  int? _religionProfesaId;
  int? _conoceUsosCostumbresId;
  final _cualesUsosCostumbresCtrl = TextEditingController();
  int? _participaCostumbresId;
  int? _costumbrePracticaId;
  int? _sancionJusticiaId;
  int? _sitiosSagradosId;
  final _cualesSitiosSagradosCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombresApellidosCtrl.text = '${widget.currentAfiliado.nombre1 ?? ''}'
        ' '
        '${widget.currentAfiliado.nombre2 ?? ''}'
        ' '
        '${widget.currentAfiliado.apellido1 ?? ''}'
        ' '
        '${widget.currentAfiliado.apellido2 ?? ''}'
        '';

    setState(() {
      _religionProfesaId =
          widget.dimensionSocioCulturalPueblosIndigenas.religionProfesaId;
      _conoceUsosCostumbresId =
          widget.dimensionSocioCulturalPueblosIndigenas.conoceUsosCostumbresId;
      _cualesUsosCostumbresCtrl.text =
          widget.dimensionSocioCulturalPueblosIndigenas.cualesUsosCostumbres ??
              '';
      _participaCostumbresId =
          widget.dimensionSocioCulturalPueblosIndigenas.participaCostumbresId;
      _costumbrePracticaId =
          widget.dimensionSocioCulturalPueblosIndigenas.costumbrePracticaId == 0
              ? null
              : widget
                  .dimensionSocioCulturalPueblosIndigenas.costumbrePracticaId;
      _sancionJusticiaId =
          widget.dimensionSocioCulturalPueblosIndigenas.sancionJusticiaId == 0
              ? null
              : widget.dimensionSocioCulturalPueblosIndigenas.sancionJusticiaId;
      _sitiosSagradosId =
          widget.dimensionSocioCulturalPueblosIndigenas.sitiosSagradosId;
      _cualesSitiosSagradosCtrl.text =
          widget.dimensionSocioCulturalPueblosIndigenas.cualesSitiosSagrados ??
              '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimensionSocioCulturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioCulturalPueblosIndigenasBloc>(context);
    return ListView(children: [
      const Divider(),
      const Text(
        'VI. DIMENSION SOCIOCULTURAL DE LOS PUEBLOS INDIGENAS',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      const SizedBox(height: 20),
      TextFormField(
        enabled: false,
        controller: _nombresApellidosCtrl,
        decoration: const InputDecoration(
          labelText: 'Integrante Grupo Familiar',
          border: OutlineInputBorder(),
        ),
      ),
      const Divider(),
      const Text(
        'Religión Que Profesa',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<ReligionProfesaCubit, ReligionesProfesaState>(
        builder: (context, state) {
          if (state is ReligionesProfesaLoaded) {
            return DropdownButtonFormField<int>(
              value: _religionProfesaId,
              items: state.religionesProfesaLoaded!
                  .map(
                    (religionProfesa) => DropdownMenuItem<int>(
                      value: religionProfesa.religionProfesaId,
                      child: Text(religionProfesa.descripcion),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _religionProfesaId = newValue;
                });
                dimensionSocioCulturalPueblosIndigenasBloc
                    .add(ReligionProfesaChanged(newValue!));
              },
              validator: (value) {
                if (value == null) {
                  return 'Campo Requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      const Divider(),
      const Text(
        'Conoce los usos y costumbres Propios de su comunidad:',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            return FormField(
              initialValue: _conoceUsosCostumbresId,
              builder: (FormFieldState<int> formstate) => Column(
                children: [
                  Column(
                      children: state.opcionesSiNoLoaded!
                          .map(
                            (e) => e.opcionId == 3
                                ? Container()
                                : RadioListTile(
                                    title: Text(e.descripcion),
                                    value: e.opcionId,
                                    groupValue: _conoceUsosCostumbresId,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        setState(() {
                                          _cualesUsosCostumbresCtrl.text = '';
                                        });
                                        dimensionSocioCulturalPueblosIndigenasBloc
                                            .add(
                                                const CualesUsosCostumbresChanged(
                                                    ''));
                                        dimensionSocioCulturalPueblosIndigenasBloc
                                            .add(
                                                const ParticipaCostumbresChanged(
                                                    0));
                                        dimensionSocioCulturalPueblosIndigenasBloc
                                            .add(const CostumbrePracticaChanged(
                                                0));
                                        dimensionSocioCulturalPueblosIndigenasBloc
                                            .add(const SancionJusticiaChanged(
                                                0));
                                        dimensionSocioCulturalPueblosIndigenasBloc
                                            .add(
                                                EventosCostumbresParticipaChanged([
                                          LstEventoCostumbreParticipa(
                                              eventoCostumbreParticipaId: 5)
                                        ]));
                                      }
                                      setState(() {
                                        _conoceUsosCostumbresId = newValue!;
                                      });
                                      dimensionSocioCulturalPueblosIndigenasBloc
                                          .add(ConoceUsosCostumbresChanged(
                                              newValue!));
                                      formstate.didChange(newValue);
                                    },
                                  ),
                          )
                          .toList()),
                  formstate.hasError
                      ? const Text(
                          'Seleccione una opción',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              validator: (value) {
                if (value == null) {
                  return 'Campo requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      if (_conoceUsosCostumbresId == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Cuales Conoce',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            TextFormField(
              maxLines: 3,
              controller: _cualesUsosCostumbresCtrl,
              decoration: const InputDecoration(
                labelText: 'Cuales Conoce',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                dimensionSocioCulturalPueblosIndigenasBloc
                    .add(CualesUsosCostumbresChanged(newValue!));
              },
            ),
            const Divider(),
            const Text(
              'Participa de los Costumbres Propios de su Comunidad',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
              builder: (context, state) {
                if (state is OpcionesSiNoLoaded) {
                  return FormField(
                    initialValue: _participaCostumbresId,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: state.opcionesSiNoLoaded!
                                .map(
                                  (e) => e.opcionId == 3
                                      ? Container()
                                      : RadioListTile(
                                          title: Text(e.descripcion),
                                          value: e.opcionId,
                                          groupValue: _participaCostumbresId,
                                          onChanged: (int? newValue) {
                                            if (newValue == 2) {
                                              setState(() {
                                                _costumbrePracticaId = null;
                                                _sancionJusticiaId = null;
                                              });
                                              dimensionSocioCulturalPueblosIndigenasBloc
                                                  .add(
                                                      EventosCostumbresParticipaChanged([
                                                LstEventoCostumbreParticipa(
                                                    eventoCostumbreParticipaId:
                                                        5)
                                              ]));
                                              dimensionSocioCulturalPueblosIndigenasBloc
                                                  .add(
                                                      const CostumbrePracticaChanged(
                                                          0));
                                              dimensionSocioCulturalPueblosIndigenasBloc
                                                  .add(
                                                      const SancionJusticiaChanged(
                                                          0));
                                            }

                                            setState(() {
                                              _participaCostumbresId =
                                                  newValue!;
                                            });

                                            dimensionSocioCulturalPueblosIndigenasBloc
                                                .add(ParticipaCostumbresChanged(
                                                    newValue!));
                                            formstate.didChange(newValue);
                                          },
                                        ),
                                )
                                .toList()),
                        formstate.hasError
                            ? const Text(
                                'Seleccione una opción',
                                style: TextStyle(color: Colors.red),
                              )
                            : Container(),
                      ],
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Campo requerido';
                      }
                      return null;
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            if (_participaCostumbresId == 1)
              Column(
                children: [
                  const Divider(),
                  const Text(
                    'En que eventos propios de usos y costumbres Participa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<EventoCostumbreParticipaCubit,
                      EventosCostumbresParticipaState>(
                    builder: (context, state) {
                      if (state is EventosCostumbresParticipaLoaded) {
                        return FormField<List<LstEventoCostumbreParticipa>>(
                          initialValue:
                              dimensionSocioCulturalPueblosIndigenasBloc
                                  .state.lstEventoCostumbreParticipa,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Seleccione al menos una opción.';
                            }
                            return null;
                          },
                          builder:
                              (FormFieldState<List<LstEventoCostumbreParticipa>>
                                  formState) {
                            return Column(
                              children: [
                                Wrap(
                                  children: List<Widget>.generate(
                                    state.eventosCostumbresParticipaLoaded!
                                        .length,
                                    (index) {
                                      final e = state
                                              .eventosCostumbresParticipaLoaded![
                                          index];
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: formState.value?.any((element) =>
                                                    element
                                                        .eventoCostumbreParticipaId ==
                                                    e.eventoCostumbreParticipaId) ??
                                                false,
                                            onChanged: (bool? value) {
                                              var selectedItems = List<
                                                      LstEventoCostumbreParticipa>.from(
                                                  formState.value ?? []);
                                              if (e.eventoCostumbreParticipaId ==
                                                  5) {
                                                selectedItems = [
                                                  LstEventoCostumbreParticipa(
                                                      eventoCostumbreParticipaId:
                                                          e.eventoCostumbreParticipaId)
                                                ];
                                              } else if (value == true) {
                                                selectedItems.removeWhere(
                                                    (element) =>
                                                        element
                                                            .eventoCostumbreParticipaId ==
                                                        5);
                                                selectedItems.add(
                                                    LstEventoCostumbreParticipa(
                                                        eventoCostumbreParticipaId:
                                                            e.eventoCostumbreParticipaId));
                                              } else {
                                                selectedItems.removeWhere(
                                                  (element) =>
                                                      element
                                                          .eventoCostumbreParticipaId ==
                                                      e.eventoCostumbreParticipaId,
                                                );
                                              }
                                              formState
                                                  .didChange(selectedItems);
                                              dimensionSocioCulturalPueblosIndigenasBloc
                                                  .add(
                                                      EventosCostumbresParticipaChanged(
                                                          selectedItems));
                                            },
                                          ),
                                          Flexible(
                                            child: Text(
                                              e.descripcion,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (index <
                                              state.eventosCostumbresParticipaLoaded!
                                                      .length -
                                                  1)
                                            const VerticalDivider(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  formState.errorText ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  const Divider(),
                  const Text(
                    'Que costumbres se practican en las etapas del desarrollo humano',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<CostumbrePracticaCubit, CostumbresPracticanState>(
                    builder: (context, state) {
                      if (state is CostumbresPracticanLoaded) {
                        return DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: _costumbrePracticaId,
                          items: state.costumbresPracticanLoaded!
                              .map(
                                (costumbrePractica) => DropdownMenuItem<int>(
                                  value: costumbrePractica.costumbrePracticaId,
                                  child: Text(costumbrePractica.descripcion),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Seleccione una opción',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _costumbrePracticaId = newValue;
                            });
                            dimensionSocioCulturalPueblosIndigenasBloc
                                .add(CostumbrePracticaChanged(newValue!));
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const Divider(),
                  const Text(
                    'En su Comunidad con que justicia se sanciona',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<SancionJusticiaCubit, SancionesJusticiaState>(
                    builder: (context, state) {
                      if (state is SancionesJusticiaLoaded) {
                        return DropdownButtonFormField<int>(
                          value: _sancionJusticiaId,
                          items: state.sancionesJusticiaLoaded!
                              .map(
                                (sancionJusticia) => DropdownMenuItem<int>(
                                  value: sancionJusticia.sancionJusticiaId,
                                  child: Text(sancionJusticia.descripcion),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Seleccione una opción',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _sancionJusticiaId = newValue!;
                            });
                            dimensionSocioCulturalPueblosIndigenasBloc
                                .add(SancionJusticiaChanged(newValue!));
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
      const Divider(),
      const Text(
        'Su territorio cuenta con sitios sagrados',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            return FormField(
              initialValue: _sitiosSagradosId,
              builder: (FormFieldState<int> formstate) => Column(
                children: [
                  Column(
                      children: state.opcionesSiNoLoaded!
                          .map(
                            (e) => e.opcionId == 3
                                ? Container()
                                : RadioListTile(
                                    title: Text(e.descripcion),
                                    value: e.opcionId,
                                    groupValue: _sitiosSagradosId,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        setState(() {
                                          _cualesSitiosSagradosCtrl.text = '';
                                        });
                                        dimensionSocioCulturalPueblosIndigenasBloc
                                            .add(
                                                const CualesSitiosSagradosChanged(
                                                    ''));
                                      }
                                      setState(() {
                                        _sitiosSagradosId = newValue!;
                                      });

                                      dimensionSocioCulturalPueblosIndigenasBloc
                                          .add(SitioSagradoChanged(newValue!));
                                      formstate.didChange(newValue);
                                    },
                                  ),
                          )
                          .toList()),
                  formstate.hasError
                      ? const Text(
                          'Seleccione una opción',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              validator: (value) {
                if (value == null) {
                  return 'Campo requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      if (_sitiosSagradosId == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Cuáles sitios sagrados',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            TextFormField(
              maxLines: 3,
              controller: _cualesSitiosSagradosCtrl,
              decoration: const InputDecoration(
                labelText: 'Cuáles',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                dimensionSocioCulturalPueblosIndigenasBloc
                    .add(CualesSitiosSagradosChanged(newValue!));
              },
            ),
          ],
        ),
    ]);
  }
}
