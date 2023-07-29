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

class DimensionSocioculturalPueblosIndigenasForm extends StatefulWidget {
  const DimensionSocioculturalPueblosIndigenasForm(
      {super.key, required this.currentAfiliado});

  final GrupoFamiliarEntity currentAfiliado;

  @override
  State<DimensionSocioculturalPueblosIndigenasForm> createState() =>
      _DimensionSocioculturalPueblosIndigenasFormState();
}

class _DimensionSocioculturalPueblosIndigenasFormState
    extends State<DimensionSocioculturalPueblosIndigenasForm> {
  final _nombresApellidosCtrl = TextEditingController();
  int? _religionProfesaId;
  int? _conoceUsosCostumbresId;
  final _cualesUsosCostumbresCtrl = TextEditingController();
  int? _participaCostumbresId;
  int? _costumbrePracticaId;
  int? _sancionJusticiaId;
  int? _sitiosSagradosId;
  final _cualesSitiosSagradosCtrl = TextEditingController();

  List<LstEventoCostumbreParticipa> _selectedEventosCostumbresParticipa = [];

  String? _validateEventosCostumbresParticipa() {
    if (_selectedEventosCostumbresParticipa.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedEventosCostumbresParticipa.length > 4) {
      return 'Máximo cuatro opciones.';
    }
    return null;
  }

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

    BlocProvider.of<DimensionSocioculturalPueblosIndigenasBloc>(context).add(
        GetDimensionSocioculturalPueblosIndigenas(
            widget.currentAfiliado.afiliadoId!));
  }

  Future<void> getOptions(int? dimensionSocioculturalPueblosIndigenasId) async {
    final eventoCostumbreParticipaCubit =
        BlocProvider.of<EventoCostumbreParticipaCubit>(
      context,
    );

    _selectedEventosCostumbresParticipa =
        await eventoCostumbreParticipaCubit.getAsp6EventosCostumbresParticipaDB(
            dimensionSocioculturalPueblosIndigenasId);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimensionSocioculturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioculturalPueblosIndigenasBloc>(context);
    return BlocListener<DimensionSocioculturalPueblosIndigenasBloc,
            DimensionSocioculturalPueblosIndigenasEntity>(
        listener: (context, state) {
          if (state.formStatus
              is DimensionSocioculturalPueblosIndigenasFormLoaded) {
            setState(() {
              _religionProfesaId = state.religionProfesaId;
              _conoceUsosCostumbresId = state.conoceUsosCostumbresId;
              _cualesUsosCostumbresCtrl.text = state.cualesUsosCostumbres ?? '';
              _participaCostumbresId = state.participaCostumbresId;
              _costumbrePracticaId = state.costumbrePracticaId;
              _sancionJusticiaId = state.sancionJusticiaId;
              _sitiosSagradosId = state.sitiosSagradosId;
              _cualesSitiosSagradosCtrl.text = state.cualesSitiosSagrados ?? '';
            });
            getOptions(state.dimensionSocioculturalPueblosIndigenasId);
          }
        },
        child: ListView(children: [
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    dimensionSocioculturalPueblosIndigenasBloc
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _conoceUsosCostumbresId,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
                                  value: e.opcionId,
                                  groupValue: _conoceUsosCostumbresId,
                                  onChanged: (int? newValue) {
                                    if (newValue == 2) {
                                      setState(() {
                                        _cualesUsosCostumbresCtrl.text = '';
                                      });
                                      dimensionSocioculturalPueblosIndigenasBloc
                                          .add(
                                              const ConoceUsosCostumbresChanged(
                                                  0));
                                    } else {
                                      setState(() {
                                        _conoceUsosCostumbresId = newValue!;
                                      });
                                    }

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
                //TODO: expand textfield
                TextFormField(
                  controller: _cualesUsosCostumbresCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Integrante Grupo Familiar',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Campo requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    dimensionSocioculturalPueblosIndigenasBloc
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _participaCostumbresId,
                        builder: (FormFieldState<int> formstate) => Column(
                          children: [
                            Column(
                                children: state.opcionesSiNoLoaded!
                                    .map(
                                      (e) => RadioListTile(
                                        title: Text(e.descripcion),
                                        value: e.opcionId,
                                        groupValue: _participaCostumbresId,
                                        onChanged: (int? newValue) {
                                          if (newValue == 2) {
                                            setState(() {
                                              _selectedEventosCostumbresParticipa =
                                                  [];
                                            });
                                            dimensionSocioculturalPueblosIndigenasBloc
                                                .add(
                                                    const EventosCostumbresParticipaChanged(
                                                        []));
                                          }

                                          setState(() {
                                            _participaCostumbresId = newValue!;
                                          });

                                          dimensionSocioculturalPueblosIndigenasBloc
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
                if (_selectedEventosCostumbresParticipa.isNotEmpty)
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
                            return FormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              initialValue: _selectedEventosCostumbresParticipa,
                              builder: (FormFieldState<
                                      List<LstEventoCostumbreParticipa>>
                                  formstate) {
                                return Column(
                                  children: [
                                    Wrap(
                                        children: List<Widget>.generate(
                                            state
                                                .eventosCostumbresParticipaLoaded!
                                                .length, (index) {
                                      final e = state
                                              .eventosCostumbresParticipaLoaded![
                                          index];
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                              value: _selectedEventosCostumbresParticipa
                                                  .any((element) =>
                                                      element
                                                          .eventoCostumbreParticipaId ==
                                                      e.eventoCostumbreParticipaId),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (value!) {
                                                    _selectedEventosCostumbresParticipa.add(
                                                        LstEventoCostumbreParticipa(
                                                            eventoCostumbreParticipaId:
                                                                e.eventoCostumbreParticipaId));
                                                  } else {
                                                    _selectedEventosCostumbresParticipa
                                                        .removeWhere(
                                                      (element) =>
                                                          element
                                                              .eventoCostumbreParticipaId ==
                                                          e.eventoCostumbreParticipaId,
                                                    );
                                                  }
                                                });
                                              }),
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
                                    })),
                                    Text(
                                      _validateEventosCostumbresParticipa() ??
                                          '',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ],
                                );
                              },
                              validator: (_) =>
                                  _validateEventosCostumbresParticipa(),
                              onSaved:
                                  (List<LstEventoCostumbreParticipa>? value) {
                                dimensionSocioculturalPueblosIndigenasBloc.add(
                                    EventosCostumbresParticipaChanged(value!));
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
                      BlocBuilder<CostumbrePracticaCubit,
                          CostumbresPracticanState>(
                        builder: (context, state) {
                          if (state is CostumbresPracticanLoaded) {
                            return DropdownButtonFormField<int>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              value: _costumbrePracticaId,
                              items: state.costumbresPracticanLoaded!
                                  .map(
                                    (costumbrePractica) =>
                                        DropdownMenuItem<int>(
                                      value:
                                          costumbrePractica.costumbrePracticaId,
                                      child:
                                          Text(costumbrePractica.descripcion),
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
                                dimensionSocioculturalPueblosIndigenasBloc
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
                    ],
                  ),
              ],
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    dimensionSocioculturalPueblosIndigenasBloc
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _sitiosSagradosId,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
                                  value: e.opcionId,
                                  groupValue: _sitiosSagradosId,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _sitiosSagradosId = newValue!;
                                    });

                                    dimensionSocioculturalPueblosIndigenasBloc
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
                  'Su territorio cuenta con  sitios sagrados',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                TextFormField(
                  controller: _cualesSitiosSagradosCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Cuáles',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Campo requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    dimensionSocioculturalPueblosIndigenasBloc
                        .add(CualesSitiosSagradosChanged(newValue!));
                  },
                ),
              ],
            ),
        ]));
  }
}
