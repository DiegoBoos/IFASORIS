import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/dificultad_acceso_med_tradicional_model.dart';
import 'package:ifasoris/ui/cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';

import '../../../data/models/especialidad_med_tradicional_model.dart';
import '../../../data/models/medio_utiliza_med_tradicional_model.dart';
import '../../../data/models/nombre_med_tradicional_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';

class AccesoMedicoForm extends StatefulWidget {
  const AccesoMedicoForm({super.key, this.dimUbicacion});

  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoMedicoForm> createState() => AccesoMedicoFormState();
}

class AccesoMedicoFormState extends State<AccesoMedicoForm> {
  int? _existeMedTradicionalComunidad;
  List<LstEspMedTradicional> _selectedEspecialidadesMedTradicional = [];
  int? _tiempoTardaMedTradId;
  int? _costoDesplazamientoMedTradicional;
  List<LstMediosMedTradicional> _selectedMediosUtilizaMedTradicional = [];
  List<LstDificultadAccesoMedTradicional>
      _selectedDificultadesAccesoMedTradicional = [];
  List<LstNombreMedTradicional> _nombresMedTrad = [];

  String? _validateEspecialidadesMedTradicionalByDpto() {
    if (_selectedEspecialidadesMedTradicional.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedEspecialidadesMedTradicional.length > 5) {
      return 'Máximo cinco opciones.';
    }
    return null;
  }

  String? _validateMediosUtilizaMedTradicionalByDpto() {
    if (_selectedMediosUtilizaMedTradicional.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedMediosUtilizaMedTradicional.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateDificultadesAccesoMedTradicionalByDpto() {
    if (_selectedDificultadesAccesoMedTradicional.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedDificultadesAccesoMedTradicional.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  void _addFormField() {
    if (_nombresMedTrad.length < 5) {
      setState(() {
        _nombresMedTrad.add(LstNombreMedTradicional(nombreMedTradicional: ''));
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Límite excedido'),
            content: const Text('No puede agregar más de 5 campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  void _removeFormField(int index) {
    if (_nombresMedTrad.length > 1) {
      setState(() {
        _nombresMedTrad.removeAt(index);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _existeMedTradicionalComunidad =
          widget.dimUbicacion?.existeMedTradicionalComunidad;

      _tiempoTardaMedTradId = widget.dimUbicacion?.tiempoTardaMedTradId == 0
          ? null
          : widget.dimUbicacion?.tiempoTardaMedTradId;

      _costoDesplazamientoMedTradicional =
          widget.dimUbicacion?.costoDesplazamientoMedTradicional == 0
              ? null
              : widget.dimUbicacion?.costoDesplazamientoMedTradicional;
    });
    getOptions();
  }

  Future<void> getOptions() async {
    final especialidadMedTradicionalByDptoCubit =
        BlocProvider.of<EspecialidadMedTradicionalByDptoCubit>(
      context,
    );

    final medioUtilizaMedTradicionalByDptoCubit =
        BlocProvider.of<MedioUtilizaMedTradicionalByDptoCubit>(
      context,
    );

    final dificultadAccesoMedTradicionalByDptoCubit =
        BlocProvider.of<DificultadAccesoMedTradicionalByDptoCubit>(
      context,
    );

    _selectedEspecialidadesMedTradicional =
        await especialidadMedTradicionalByDptoCubit
            .getUbicacionEspecialidadesMedTradicionalDB(
                widget.dimUbicacion?.ubicacionId);

    _nombresMedTrad = await especialidadMedTradicionalByDptoCubit
        .getUbicacionNombresMedTradicionalDB(widget.dimUbicacion?.ubicacionId);

    _selectedMediosUtilizaMedTradicional =
        await medioUtilizaMedTradicionalByDptoCubit
            .getMedioUtilizaMedTradicionalDB(widget.dimUbicacion?.ubicacionId);

    _selectedDificultadesAccesoMedTradicional =
        await dificultadAccesoMedTradicionalByDptoCubit
            .getUbicacionDificultadAccesoMedTradicionalDB(
                widget.dimUbicacion?.ubicacionId);
    setState(() {});
  }

  Widget buildTextField(TextEditingController controller, FocusNode focusNode) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'Text Field',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    if (_nombresMedTrad.isEmpty) {
      _nombresMedTrad.add(LstNombreMedTradicional(nombreMedTradicional: ''));
    }

    return Column(children: [
      const Divider(),
      const Text(
        'ACCESO AL MEDICO TRADICIONAL MAS CERCANO',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      const SizedBox(height: 20),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            return FormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: _existeMedTradicionalComunidad,
              builder: (FormFieldState<int> formstate) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Existe médico tradicional en la comunidad'),
                    Column(
                      children: state.opcionesSiNoLoaded!
                          .map(
                            (e) => RadioListTile(
                              title: Text(
                                e.descripcion,
                              ),
                              value: e.opcionId,
                              groupValue: _existeMedTradicionalComunidad,
                              onChanged: (int? value) {
                                setState(() {
                                  _existeMedTradicionalComunidad = value;
                                  formstate.didChange(value);
                                  if (_existeMedTradicionalComunidad != 1) {
                                    _selectedEspecialidadesMedTradicional = [];
                                    dimUbicacionBloc.add(
                                        const EspecialidadesMedTradChanged([]));

                                    _tiempoTardaMedTradId = null;
                                    dimUbicacionBloc.add(
                                        const TiempoTardaMedTradChanged(0));

                                    _selectedMediosUtilizaMedTradicional = [];
                                    dimUbicacionBloc.add(
                                        const MediosUtilizaMedTradChanged([]));

                                    _selectedDificultadesAccesoMedTradicional =
                                        [];
                                    dimUbicacionBloc.add(
                                        const DificultadesAccesoMedTradicionalChanged(
                                            []));

                                    _costoDesplazamientoMedTradicional = null;
                                    dimUbicacionBloc.add(
                                        const CostoDesplazamientoMedTradicionalChanged(
                                            0));

                                    _nombresMedTrad = [];
                                    dimUbicacionBloc.add(
                                        const NombresMedTradicionalChanged([]));
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    formstate.hasError
                        ? const Text(
                            'Seleccione una opción',
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                  ],
                );
              },
              validator: (value) {
                if (value == null) {
                  return 'Seleccione una opción';
                }
                return null;
              },
              onSaved: (int? value) {
                dimUbicacionBloc
                    .add(ExisteMedTradicionalComunidadChanged(value!));
              },
            );
          }
          return Container();
        },
      ),
      const SizedBox(height: 20),
      if (_existeMedTradicionalComunidad == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Especialidades médico tradicional',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<EspecialidadMedTradicionalByDptoCubit,
                EspecialidadesMedTradicionalByDptoState>(
              builder: (context, state) {
                if (state is EspecialidadesMedTradicionalByDptoLoaded) {
                  return FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _selectedEspecialidadesMedTradicional,
                    builder:
                        (FormFieldState<List<LstEspMedTradicional>> formstate) {
                      return Column(
                        children: [
                          Wrap(
                              children: List<Widget>.generate(
                                  state
                                      .especialidadesMedtradicionalByDptoLoaded!
                                      .length, (index) {
                            final e =
                                state.especialidadesMedtradicionalByDptoLoaded![
                                    index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                    value: _selectedEspecialidadesMedTradicional
                                        .any((element) =>
                                            element.especialidadMedTradId ==
                                            e.especialidadMedTradId),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value!) {
                                          _selectedEspecialidadesMedTradicional
                                              .add(LstEspMedTradicional(
                                                  especialidadMedTradId:
                                                      e.especialidadMedTradId));
                                        } else {
                                          _selectedEspecialidadesMedTradicional
                                              .removeWhere((element) =>
                                                  element
                                                      .especialidadMedTradId ==
                                                  e.especialidadMedTradId);
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
                                    state.especialidadesMedtradicionalByDptoLoaded!
                                            .length -
                                        1)
                                  const VerticalDivider(),
                              ],
                            );
                          })),
                          Text(
                            _validateEspecialidadesMedTradicionalByDpto() ?? '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      );
                    },
                    validator: (_) =>
                        _validateEspecialidadesMedTradicionalByDpto(),
                    onSaved: (List<LstEspMedTradicional>? value) {
                      dimUbicacionBloc
                          .add(EspecialidadesMedTradChanged(value!));
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<TiempoTardaMedTradicionalCubit,
                TiemposTardaMedTradicionalState>(
              builder: (context, state) {
                if (state is TiemposTardaMedTradicionalLoaded) {
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _tiempoTardaMedTradId,
                    items: state.tiemposTardaMedTradicionalLoaded!
                        .map(
                          (tiempoTardaMedTradicional) => DropdownMenuItem<int>(
                            value:
                                tiempoTardaMedTradicional.tiempoTardaMedTradId,
                            child: Text(tiempoTardaMedTradicional.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText:
                            'Tiempo que tarda en llegar desde su casa al medico tradicional',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _tiempoTardaMedTradId = newValue;
                      });
                      dimUbicacionBloc
                          .add(TiempoTardaMedTradChanged(newValue!));
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                  );
                }
                return Container();
              },
            ),
            const Divider(),
            const Text(
              'Medios que utiliza para el desplazamiento al médico tradicional',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<MedioUtilizaMedTradicionalByDptoCubit,
                MediosUtilizaMedTradicionalByDptoState>(
              builder: (context, state) {
                if (state is MediosUtilizaMedTradicionalByDptoLoaded) {
                  return FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _selectedMediosUtilizaMedTradicional,
                    builder: (FormFieldState<List<LstMediosMedTradicional>>
                        formstate) {
                      return Column(
                        children: [
                          Wrap(
                              children: List<Widget>.generate(
                                  state.mediosUtilizaMedTradicionalByDptoLoaded!
                                      .length, (index) {
                            final e =
                                state.mediosUtilizaMedTradicionalByDptoLoaded![
                                    index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                    value: _selectedMediosUtilizaMedTradicional
                                        .any((element) =>
                                            element.medioUtilizaMedTradId ==
                                            e.medioUtilizaMedTradId),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value!) {
                                          _selectedMediosUtilizaMedTradicional
                                              .add(LstMediosMedTradicional(
                                                  medioUtilizaMedTradId:
                                                      e.medioUtilizaMedTradId));
                                        } else {
                                          _selectedMediosUtilizaMedTradicional
                                              .removeWhere((element) =>
                                                  element
                                                      .medioUtilizaMedTradId ==
                                                  e.medioUtilizaMedTradId);
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
                                    state.mediosUtilizaMedTradicionalByDptoLoaded!
                                            .length -
                                        1)
                                  const VerticalDivider(),
                              ],
                            );
                          })),
                          Text(
                            _validateMediosUtilizaMedTradicionalByDpto() ?? '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      );
                    },
                    validator: (_) =>
                        _validateMediosUtilizaMedTradicionalByDpto(),
                    onSaved: (List<LstMediosMedTradicional>? value) {
                      dimUbicacionBloc.add(MediosUtilizaMedTradChanged(value!));
                    },
                  );
                }
                return Container();
              },
            ),
            const Divider(),
            const Text(
              'Que dificultad de acceso tiene, para llegar donde el médico tradicional',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<DificultadAccesoMedTradicionalByDptoCubit,
                DificultadesAccesoMedTradicionalByDptoState>(
              builder: (context, state) {
                if (state is DificultadesAccesoMedTradicionalByDptoLoaded) {
                  return FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _selectedDificultadesAccesoMedTradicional,
                    builder:
                        (FormFieldState<List<LstDificultadAccesoMedTradicional>>
                            formstate) {
                      return Column(
                        children: [
                          Wrap(
                              children: List<Widget>.generate(
                                  state
                                      .dificultadesAccesoMedTradicionalByDptoLoaded!
                                      .length, (index) {
                            final e = state
                                    .dificultadesAccesoMedTradicionalByDptoLoaded![
                                index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                    value:
                                        _selectedDificultadesAccesoMedTradicional
                                            .any((element) =>
                                                element
                                                    .dificultadAccesoMedTradId ==
                                                e.dificultadAccesoMedTradId),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (e.dificultadAccesoMedTradId == 5) {
                                          _selectedDificultadesAccesoMedTradicional =
                                              [
                                            LstDificultadAccesoMedTradicional(
                                                dificultadAccesoMedTradId:
                                                    e.dificultadAccesoMedTradId)
                                          ];
                                        } else if (value!) {
                                          _selectedDificultadesAccesoMedTradicional
                                              .removeWhere((element) =>
                                                  element
                                                      .dificultadAccesoMedTradId ==
                                                  5);
                                          _selectedDificultadesAccesoMedTradicional.add(
                                              LstDificultadAccesoMedTradicional(
                                                  dificultadAccesoMedTradId: e
                                                      .dificultadAccesoMedTradId));
                                        } else {
                                          _selectedDificultadesAccesoMedTradicional
                                              .removeWhere(
                                            (element) =>
                                                element
                                                    .dificultadAccesoMedTradId ==
                                                e.dificultadAccesoMedTradId,
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
                                    state.dificultadesAccesoMedTradicionalByDptoLoaded!
                                            .length -
                                        1)
                                  const VerticalDivider(),
                              ],
                            );
                          })),
                          Text(
                            _validateDificultadesAccesoMedTradicionalByDpto() ??
                                '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      );
                    },
                    validator: (_) =>
                        _validateDificultadesAccesoMedTradicionalByDpto(),
                    onSaved: (List<LstDificultadAccesoMedTradicional>? value) {
                      dimUbicacionBloc
                          .add(DificultadesAccesoMedTradicionalChanged(value!));
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<CostoDesplazamientoCubit, CostosDesplazamientoState>(
              builder: (context, state) {
                if (state is CostosDesplazamientoLoaded) {
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _costoDesplazamientoMedTradicional,
                    items: state.costosDesplazamientoLoaded!
                        .map(
                          (costoDesplazamiento) => DropdownMenuItem<int>(
                            value: costoDesplazamiento.costoDesplazamientoId,
                            child: Text(costoDesplazamiento.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText:
                            'Costo de desplazamiento a médico tradicional',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _costoDesplazamientoMedTradicional = newValue;
                      });
                      dimUbicacionBloc.add(
                          CostoDesplazamientoMedTradicionalChanged(newValue!));
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _nombresMedTrad.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            _nombresMedTrad[index].nombreMedTradicional,
                        decoration: InputDecoration(
                            labelText:
                                'Nombre del médico tradicional ${index + 1}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _nombresMedTrad[index].nombreMedTradicional = value!;
                          dimUbicacionBloc.add(
                              NombresMedTradicionalChanged(_nombresMedTrad));
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        _removeFormField(index);
                      },
                    ),
                  ],
                );
              },
            ),
            TextButton(
              onPressed: _addFormField,
              child: const Text('Agregar nombre del médico tradicional'),
            ),
          ],
        ),
    ]);
  }
}
