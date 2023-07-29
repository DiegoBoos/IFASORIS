import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/enfermedad_tradicional_model.dart';

import '../../../data/models/especialidad_med_tradicional_model.dart';
import '../../../data/models/lugar_atencion_medico_model.dart';
import '../../../data/models/planta_medicinal_model.dart';
import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/usecases/enfermedad_acude/enfermedad_acude_exports.dart';
import '../../../domain/usecases/enfermedad_tradicional/enfermedad_tradicional_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import '../../cubits/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_cubit.dart';
import '../../cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import '../../cubits/planta_medicinal/planta_medicinal_cubit.dart';

class AtencionSaludForm extends StatefulWidget {
  const AtencionSaludForm({super.key, required this.currentAfiliado});

  final GrupoFamiliarEntity currentAfiliado;

  @override
  State<AtencionSaludForm> createState() => _AtencionSaludFormState();
}

class _AtencionSaludFormState extends State<AtencionSaludForm> {
  final _nombresApellidosCtrl = TextEditingController();
  int? _enfermedadAcudeId;
  int? _recibioAtencionMedTradicionalId;
  int? _enfermedadTratamientoId;
  int? _plantaMedicinalId;
  List<LstEspMedTradicional> _selectedEspecialidadesMedTradicional = [];
  List<LstEnfermedadTradicional> _selectedEnfermedadesTradicionales = [];
  List<LstLugarAtencionMedico> _selectedLugaresAtencionMedico = [];
  List<LstPlantaMedicinal> _selectedPlantasMedicinales = [];

  String? _validateEspecialidadesMedTradicional() {
    if (_selectedEspecialidadesMedTradicional.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedEspecialidadesMedTradicional.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateEnfermedadesTradicionales() {
    if (_selectedEnfermedadesTradicionales.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedEnfermedadesTradicionales.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateLugaresAtencionMedico() {
    if (_selectedLugaresAtencionMedico.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedLugaresAtencionMedico.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validatePlantasMedicinales() {
    if (_selectedPlantasMedicinales.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedPlantasMedicinales.length > 3) {
      return 'Máximo tres opciones.';
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

    BlocProvider.of<AtencionSaludBloc>(context)
        .add(GetAtencionSalud(widget.currentAfiliado.afiliadoId!));
  }

  Future<void> getOptions(int? atencionSaludId) async {
    final especialidadMedTradicionalCubit =
        BlocProvider.of<EspecialidadMedTradicionalCubit>(
      context,
    );

    final enfermedadTradicionalCubit =
        BlocProvider.of<EnfermedadTradicionalCubit>(
      context,
    );

    final lugarAtencionMedicoCubit = BlocProvider.of<LugarAtencionMedicoCubit>(
      context,
    );

    final plantaMedicinalCubit = BlocProvider.of<PlantaMedicinalCubit>(
      context,
    );

    _selectedEspecialidadesMedTradicional =
        await especialidadMedTradicionalCubit
            .getEspecialidadesMedTradicionalAtencionSaludDB(atencionSaludId);
    _selectedEnfermedadesTradicionales = await enfermedadTradicionalCubit
        .getEnfermedadesTradicionalesAtencionSaludDB(atencionSaludId);
    _selectedLugaresAtencionMedico = await lugarAtencionMedicoCubit
        .getLugaresAtencionMedicoAtencionSaludDB(atencionSaludId);
    _selectedPlantasMedicinales = await plantaMedicinalCubit
        .getPlantasMedicinalesAtencionSaludDB(atencionSaludId);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);
    return BlocListener<AtencionSaludBloc, AtencionSaludEntity>(
        listener: (context, state) {
          if (state.formStatus is AtencionSaludFormLoaded) {
            setState(() {
              _enfermedadAcudeId = state.enfermedadAcudeId;
              _enfermedadAcudeId = state.enfermedadAcudeId;
              _recibioAtencionMedTradicionalId =
                  state.recibioAtencionMedTradicionalId;
              _enfermedadTratamientoId = state.enfermedadTratamientoId;
              _plantaMedicinalId =
                  state.plantaMedicinalId == 0 ? null : state.plantaMedicinalId;
            });
            getOptions(state.atencionSaludId);
          }
        },
        child: ListView(
          children: [
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
              'Cuando se enferma acude a',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<EnfermedadAcudeCubit, EnfermedadesAcudeState>(
              builder: (context, state) {
                if (state is EnfermedadesAcudeLoaded) {
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _enfermedadAcudeId,
                    items: state.enfermedadesAcudeLoaded!
                        .map(
                          (enfermedadAcude) => DropdownMenuItem<int>(
                            value: enfermedadAcude.enfermedadAcudeId,
                            child: Text(enfermedadAcude.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Seleccione una opción',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _enfermedadAcudeId = newValue;
                      });
                      atencionSaludBloc.add(EnfermedadAcudeChanged(newValue!));
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
              'Ha recibido atención por Medicina Tradicional:',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
              builder: (context, state) {
                if (state is OpcionesSiNoLoaded) {
                  return FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _recibioAtencionMedTradicionalId,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: state.opcionesSiNoLoaded!
                                .map(
                                  (e) => RadioListTile(
                                    title: Text(e.descripcion),
                                    value: e.opcionId,
                                    groupValue:
                                        _recibioAtencionMedTradicionalId,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        setState(() {
                                          _recibioAtencionMedTradicionalId =
                                              newValue!;
                                          _selectedEspecialidadesMedTradicional =
                                              [];
                                          _selectedEnfermedadesTradicionales =
                                              [];
                                          _selectedLugaresAtencionMedico = [];
                                          _selectedPlantasMedicinales = [];
                                        });
                                        atencionSaludBloc.add(
                                            const EspecialidadesMedTradicionalChanged(
                                                []));
                                        atencionSaludBloc.add(
                                            const EnfermedadesTradicionalesChanged(
                                                []));
                                        atencionSaludBloc.add(
                                            const LugaresAtencionMedicoChanged(
                                                []));
                                        atencionSaludBloc.add(
                                            const PlantasMedicinalesChanged(
                                                []));
                                      } else {
                                        setState(() {
                                          _recibioAtencionMedTradicionalId =
                                              newValue!;
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
            if (_recibioAtencionMedTradicionalId == 1)
              Column(
                children: [
                  const Divider(),
                  const Text(
                    'Especialidad del medico tradicional que lo atendió',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<EspecialidadMedTradicionalCubit,
                      EspecialidadesMedTradicionalState>(
                    builder: (context, state) {
                      if (state is EspecialidadesMedTradicionalLoaded) {
                        return FormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _selectedEspecialidadesMedTradicional,
                          builder: (FormFieldState<List<LstEspMedTradicional>>
                              formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state
                                            .especialidadesMedTradicionalLoaded!
                                            .length, (index) {
                                  final e =
                                      state.especialidadesMedTradicionalLoaded![
                                          index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedEspecialidadesMedTradicional
                                              .any((element) =>
                                                  element
                                                      .especialidadMedTradId ==
                                                  e.especialidadMedTradId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedEspecialidadesMedTradicional
                                                    .add(LstEspMedTradicional(
                                                        especialidadMedTradId: e
                                                            .especialidadMedTradId));
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
                                          state.especialidadesMedTradicionalLoaded!
                                                  .length -
                                              1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                })),
                                Text(
                                  _validateEspecialidadesMedTradicional() ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            );
                          },
                          validator: (_) =>
                              _validateEspecialidadesMedTradicional(),
                          onSaved: (List<LstEspMedTradicional>? value) {
                            atencionSaludBloc.add(
                                EspecialidadesMedTradicionalChanged(value!));
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  BlocBuilder<EnfermedadTradicionalCubit,
                      EnfermedadesTradicionalesState>(
                    builder: (context, state) {
                      if (state is EnfermedadesTradicionalesLoaded) {
                        return FormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _selectedEnfermedadesTradicionales,
                          builder:
                              (FormFieldState<List<LstEnfermedadTradicional>>
                                  formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.enfermedadesTradicionalesLoaded!
                                            .length, (index) {
                                  final e = state
                                      .enfermedadesTradicionalesLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedEnfermedadesTradicionales
                                              .any((element) =>
                                                  element
                                                      .enfermedadTradicionalId ==
                                                  e.enfermedadTradicionalId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedEnfermedadesTradicionales
                                                    .add(LstEnfermedadTradicional(
                                                        enfermedadTradicionalId:
                                                            e.enfermedadTradicionalId));
                                              } else {
                                                _selectedEnfermedadesTradicionales
                                                    .removeWhere((element) =>
                                                        element
                                                            .enfermedadTradicionalId ==
                                                        e.enfermedadTradicionalId);
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
                                          state.enfermedadesTradicionalesLoaded!
                                                  .length -
                                              1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                })),
                                Text(
                                  _validateEnfermedadesTradicionales() ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            );
                          },
                          validator: (_) =>
                              _validateEnfermedadesTradicionales(),
                          onSaved: (List<LstEnfermedadTradicional>? value) {
                            atencionSaludBloc
                                .add(EnfermedadesTradicionalesChanged(value!));
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  BlocBuilder<LugarAtencionMedicoCubit,
                      LugaresAtencionMedicoState>(
                    builder: (context, state) {
                      if (state is LugaresAtencionMedicoLoaded) {
                        return FormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _selectedLugaresAtencionMedico,
                          builder: (FormFieldState<List<LstLugarAtencionMedico>>
                              formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.lugaresAtencionMedicoLoaded!
                                            .length, (index) {
                                  final e =
                                      state.lugaresAtencionMedicoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedLugaresAtencionMedico
                                              .any((element) =>
                                                  element
                                                      .lugarAtencionMedicoId ==
                                                  e.lugarAtencionMedicoId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedLugaresAtencionMedico
                                                    .add(LstLugarAtencionMedico(
                                                        lugarAtencionMedicoId: e
                                                            .lugarAtencionMedicoId));
                                              } else {
                                                _selectedLugaresAtencionMedico
                                                    .removeWhere((element) =>
                                                        element
                                                            .lugarAtencionMedicoId ==
                                                        e.lugarAtencionMedicoId);
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
                                          state.lugaresAtencionMedicoLoaded!
                                                  .length -
                                              1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                })),
                                Text(
                                  _validateLugaresAtencionMedico() ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            );
                          },
                          validator: (_) => _validateLugaresAtencionMedico(),
                          onSaved: (List<LstLugarAtencionMedico>? value) {
                            atencionSaludBloc
                                .add(LugaresAtencionMedicoChanged(value!));
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            const Divider(),
            const Text(
              'En caso de enfermedad a que tratamiento acude',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<EnfermedadTratamientoCubit,
                EnfermedadesTratamientoState>(
              builder: (context, state) {
                if (state is EnfermedadesTratamientoLoaded) {
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _enfermedadTratamientoId,
                    items: state.enfermedadesTratamientoLoaded!
                        .map(
                          (enfermedadTratamiento) => DropdownMenuItem<int>(
                            value:
                                enfermedadTratamiento.enfermedadTratamientoId,
                            child: Text(enfermedadTratamiento.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Seleccione una opción',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _enfermedadTratamientoId = newValue!;
                      });
                      atencionSaludBloc
                          .add(EnfermedadTratamientoChanged(newValue!));
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
              'Utiliza plantas Medicinales',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
              builder: (context, state) {
                if (state is OpcionesSiNoLoaded) {
                  return FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _plantaMedicinalId,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: state.opcionesSiNoLoaded!
                                .map(
                                  (e) => RadioListTile(
                                    title: Text(e.descripcion),
                                    value: e.opcionId,
                                    groupValue: _plantaMedicinalId,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        setState(() {
                                          _plantaMedicinalId = newValue!;
                                          _plantaMedicinalId = null;
                                          _selectedPlantasMedicinales = [];
                                        });
                                        atencionSaludBloc.add(
                                            const PlantaMedicinalChanged(0));
                                        atencionSaludBloc.add(
                                            const PlantasMedicinalesChanged(
                                                []));
                                      } else {
                                        setState(() {
                                          _plantaMedicinalId = newValue!;
                                        });
                                      }
                                      atencionSaludBloc.add(
                                          PlantaMedicinalChanged(newValue!));
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
            if (_plantaMedicinalId == 1)
              Column(
                children: [
                  const Divider(),
                  const Text(
                    'Donde consigue las plantas medicinales',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<PlantaMedicinalCubit, PlantasMedicinalesState>(
                    builder: (context, state) {
                      if (state is PlantasMedicinalesLoaded) {
                        return DropdownButtonFormField<int>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: _plantaMedicinalId,
                          items: state.plantasMedicinalesLoaded!
                              .map(
                                (plantaMedicinal) => DropdownMenuItem<int>(
                                  value: plantaMedicinal.plantaMedicinalId,
                                  child: Text(plantaMedicinal.descripcion),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Seleccione una opción',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _plantaMedicinalId = newValue!;
                            });
                            atencionSaludBloc
                                .add(PlantaMedicinalChanged(newValue!));
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
                    'Que Plantas Medicinales utiliza con frecuencia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<PlantaMedicinalCubit, PlantasMedicinalesState>(
                    builder: (context, state) {
                      if (state is PlantasMedicinalesLoaded) {
                        return FormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _selectedPlantasMedicinales,
                          builder: (FormFieldState<List<LstPlantaMedicinal>>
                              formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.plantasMedicinalesLoaded!.length,
                                        (index) {
                                  final e =
                                      state.plantasMedicinalesLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedPlantasMedicinales
                                              .any((element) =>
                                                  element.plantaMedicinalId ==
                                                  e.plantaMedicinalId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedPlantasMedicinales.add(
                                                    LstPlantaMedicinal(
                                                        plantaMedicinalId: e
                                                            .plantaMedicinalId));
                                              } else {
                                                _selectedPlantasMedicinales
                                                    .removeWhere((element) =>
                                                        element
                                                            .plantaMedicinalId ==
                                                        e.plantaMedicinalId);
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
                                          state.plantasMedicinalesLoaded!
                                                  .length -
                                              1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                })),
                                Text(
                                  _validatePlantasMedicinales() ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            );
                          },
                          validator: (_) => _validatePlantasMedicinales(),
                          onSaved: (List<LstPlantaMedicinal>? value) {
                            atencionSaludBloc
                                .add(PlantasMedicinalesChanged(value!));
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
          ],
        ));
  }
}
