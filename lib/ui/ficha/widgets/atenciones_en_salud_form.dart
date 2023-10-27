import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/enfermedad_tradicional_model.dart';
import '../../../data/models/especialidad_med_tradicional_model.dart';
import '../../../data/models/lugar_atencion_medico_model.dart';
import '../../../data/models/planta_medicinal_model.dart';
import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/usecases/enfermedad_acude/enfermedad_acude_exports.dart';
import '../../../domain/usecases/enfermedad_tradicional/enfermedad_tradicional_exports.dart';
import '../../../domain/usecases/lugar_planta_medicinal/lugar_planta_medicinal_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import '../../cubits/especialidad_med_tradicional/especialidad_med_tradicional_cubit.dart';
import '../../cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import '../../cubits/planta_medicinal/planta_medicinal_cubit.dart';
import '../../utils/custom_snack_bar.dart';

class AtencionSaludForm extends StatefulWidget {
  const AtencionSaludForm(
      {super.key, required this.currentAfiliado, this.atencionSalud});

  final GrupoFamiliarEntity currentAfiliado;
  final AtencionSaludEntity? atencionSalud;

  @override
  State<AtencionSaludForm> createState() => _AtencionSaludFormState();
}

class _AtencionSaludFormState extends State<AtencionSaludForm> {
  final _nombresApellidosCtrl = TextEditingController();
  int? _enfermedadAcudeId;
  int? _recibioAtencionMedTradicionalId;
  int? _enfermedadTratamientoId;
  int? _utilizaPlantasMedId;
  int? _lugarPlantaMedicinalId;

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
      _enfermedadAcudeId = widget.atencionSalud?.enfermedadAcudeId;
      _recibioAtencionMedTradicionalId =
          widget.atencionSalud?.recibioAtencionMedTradicionalId;
      _enfermedadTratamientoId = widget.atencionSalud?.enfermedadTratamientoId;
      _utilizaPlantasMedId = widget.atencionSalud?.utilizaPlantasMedId == 0
          ? null
          : widget.atencionSalud?.utilizaPlantasMedId;
      _lugarPlantaMedicinalId =
          widget.atencionSalud?.lugarPlantaMedicinalId == 0
              ? null
              : widget.atencionSalud?.lugarPlantaMedicinalId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);
    return ListView(
      children: [
        const Divider(),
        const Text(
          'VII. ATENCIONES EN SALUD',
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
                initialValue: _recibioAtencionMedTradicionalId,
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
                                      groupValue:
                                          _recibioAtencionMedTradicionalId,
                                      onChanged: (int? newValue) {
                                        if (newValue == 2) {
                                          atencionSaludBloc.add(
                                              const EspecialidadesMedTradicionalChanged(
                                                  []));
                                          atencionSaludBloc.add(
                                              const EnfermedadesTradicionalesChanged(
                                                  []));
                                          atencionSaludBloc.add(
                                              const LugaresAtencionMedicoChanged(
                                                  []));
                                        }
                                        setState(() {
                                          _recibioAtencionMedTradicionalId =
                                              newValue!;
                                        });

                                        atencionSaludBloc.add(
                                            RecibioAtencionMedTradicionalChanged(
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
                    return FormField<List<LstEspMedTradicional>>(
                      initialValue: atencionSaludBloc
                          .state.lstEspecialidadesMedTradicional,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstEspMedTradicional>>
                          formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state
                                    .especialidadesMedTradicionalLoaded!.length,
                                (index) {
                                  final e =
                                      state.especialidadesMedTradicionalLoaded![
                                          index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((element) =>
                                                  element
                                                      .especialidadMedTradId ==
                                                  e.especialidadMedTradId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        3)
                                                ? CustomSnackBar
                                                    .showCustomDialog(
                                                        context,
                                                        'Error',
                                                        'Máximo tres opciones',
                                                        () => Navigator.pop(
                                                            context),
                                                        false)
                                                : setState(
                                                    () {
                                                      var selectedItems = List<
                                                              LstEspMedTradicional>.from(
                                                          formState.value ??
                                                              []);
                                                      if (value == true) {
                                                        selectedItems.add(
                                                            LstEspMedTradicional(
                                                                especialidadMedTradId:
                                                                    e.especialidadMedTradId));
                                                      } else {
                                                        selectedItems
                                                            .removeWhere(
                                                          (element) =>
                                                              element
                                                                  .especialidadMedTradId ==
                                                              e.especialidadMedTradId,
                                                        );
                                                      }
                                                      formState.didChange(
                                                          selectedItems);
                                                      atencionSaludBloc.add(
                                                          EspecialidadesMedTradicionalChanged(
                                                              selectedItems));
                                                    },
                                                  );
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
                'Nombre de enfermedad tradicional por la cual fue atendido',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<EnfermedadTradicionalCubit,
                  EnfermedadesTradicionalesState>(
                builder: (context, state) {
                  if (state is EnfermedadesTradicionalesLoaded) {
                    return FormField<List<LstEnfermedadTradicional>>(
                      initialValue:
                          atencionSaludBloc.state.lstEnfermedadesTradicionales,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstEnfermedadTradicional>>
                          formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.enfermedadesTradicionalesLoaded!.length,
                                (index) {
                                  final e = state
                                      .enfermedadesTradicionalesLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((element) =>
                                                  element
                                                      .enfermedadTradicionalId ==
                                                  e.enfermedadTradicionalId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        5)
                                                ? CustomSnackBar
                                                    .showCustomDialog(
                                                        context,
                                                        'Error',
                                                        'Máximo cinco opciones',
                                                        () => Navigator.pop(
                                                            context),
                                                        false)
                                                : setState(
                                                    () {
                                                      var selectedItems = List<
                                                              LstEnfermedadTradicional>.from(
                                                          formState.value ??
                                                              []);
                                                      if (value == true) {
                                                        selectedItems.add(
                                                            LstEnfermedadTradicional(
                                                                enfermedadTradicionalId:
                                                                    e.enfermedadTradicionalId));
                                                      } else {
                                                        selectedItems
                                                            .removeWhere(
                                                          (element) =>
                                                              element
                                                                  .enfermedadTradicionalId ==
                                                              e.enfermedadTradicionalId,
                                                        );
                                                      }
                                                      formState.didChange(
                                                          selectedItems);
                                                      atencionSaludBloc.add(
                                                          EnfermedadesTradicionalesChanged(
                                                              selectedItems));
                                                    },
                                                  );
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
                'En que Lugar ha recibido Atención por parte del Medico Tradicional',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<LugarAtencionMedicoCubit, LugaresAtencionMedicoState>(
                builder: (context, state) {
                  if (state is LugaresAtencionMedicoLoaded) {
                    return FormField<List<LstLugarAtencionMedico>>(
                      initialValue:
                          atencionSaludBloc.state.lstLugaresAtencionMedico,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstLugarAtencionMedico>>
                          formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.lugaresAtencionMedicoLoaded!.length,
                                (index) {
                                  final e =
                                      state.lugaresAtencionMedicoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((element) =>
                                                  element
                                                      .lugarAtencionMedicoId ==
                                                  e.lugarAtencionMedicoId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        3)
                                                ? CustomSnackBar
                                                    .showCustomDialog(
                                                        context,
                                                        'Error',
                                                        'Máximo tres opciones',
                                                        () => Navigator.pop(
                                                            context),
                                                        false)
                                                : setState(
                                                    () {
                                                      var selectedItems = List<
                                                              LstLugarAtencionMedico>.from(
                                                          formState.value ??
                                                              []);
                                                      if (value == true) {
                                                        selectedItems.add(
                                                            LstLugarAtencionMedico(
                                                                lugarAtencionMedicoId:
                                                                    e.lugarAtencionMedicoId));
                                                      } else {
                                                        selectedItems
                                                            .removeWhere(
                                                          (element) =>
                                                              element
                                                                  .lugarAtencionMedicoId ==
                                                              e.lugarAtencionMedicoId,
                                                        );
                                                      }
                                                      formState.didChange(
                                                          selectedItems);
                                                      atencionSaludBloc.add(
                                                          LugaresAtencionMedicoChanged(
                                                              selectedItems));
                                                    },
                                                  );
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
            ],
          ),
        const Divider(),
        const Text(
          'En caso de enfermedad a que tratamiento acude',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<EnfermedadTratamientoCubit, EnfermedadesTratamientoState>(
          builder: (context, state) {
            if (state is EnfermedadesTratamientoLoaded) {
              return DropdownButtonFormField<int>(
                isExpanded: true,
                value: _enfermedadTratamientoId,
                items: state.enfermedadesTratamientoLoaded!
                    .map(
                      (enfermedadTratamiento) => DropdownMenuItem<int>(
                        value: enfermedadTratamiento.enfermedadTratamientoId,
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
                initialValue: _utilizaPlantasMedId,
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
                                      groupValue: _utilizaPlantasMedId,
                                      onChanged: (int? newValue) {
                                        if (newValue == 2) {
                                          setState(() {
                                            _lugarPlantaMedicinalId = null;
                                          });

                                          atencionSaludBloc.add(
                                              const PlantasMedicinalesChanged(
                                                  []));
                                          atencionSaludBloc.add(
                                              const LugarPlantaMedicinalChanged(
                                                  0));
                                        }
                                        setState(() {
                                          _utilizaPlantasMedId = newValue!;
                                        });

                                        atencionSaludBloc.add(
                                            UtilizaPlantasMedChanged(
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
        if (_utilizaPlantasMedId == 1)
          Column(
            children: [
              const Divider(),
              const Text(
                'Donde consigue las plantas medicinales',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<LugarPlantaMedicinalCubit,
                  LugaresPlantasMedicinalesState>(
                builder: (context, state) {
                  if (state is LugaresPlantasMedicinalesLoaded) {
                    return DropdownButtonFormField<int>(
                      value: _lugarPlantaMedicinalId,
                      items: state.lugaresPlantasMedicinalesLoaded!
                          .map(
                            (lugarPlantaMedicinal) => DropdownMenuItem<int>(
                              value:
                                  lugarPlantaMedicinal.lugarPlantaMedicinalId,
                              child: Text(lugarPlantaMedicinal.descripcion),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                          labelText: 'Seleccione una opción',
                          border: OutlineInputBorder()),
                      onChanged: (int? newValue) {
                        setState(() {
                          _lugarPlantaMedicinalId = newValue!;
                        });
                        atencionSaludBloc
                            .add(LugarPlantaMedicinalChanged(newValue!));
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
                    return FormField<List<LstPlantaMedicinal>>(
                      initialValue:
                          atencionSaludBloc.state.lstPlantasMedicinales,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder:
                          (FormFieldState<List<LstPlantaMedicinal>> formState) {
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
                                          value: formState.value?.any(
                                                  (element) =>
                                                      element
                                                          .plantaMedicinalId ==
                                                      e.plantaMedicinalId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        5)
                                                ? CustomSnackBar
                                                    .showCustomDialog(
                                                        context,
                                                        'Error',
                                                        'Máximo cinco opciones',
                                                        () => Navigator.pop(
                                                            context),
                                                        false)
                                                : setState(
                                                    () {
                                                      var selectedItems = List<
                                                              LstPlantaMedicinal>.from(
                                                          formState.value ??
                                                              []);
                                                      if (value == true) {
                                                        selectedItems.add(
                                                            LstPlantaMedicinal(
                                                                plantaMedicinalId:
                                                                    e.plantaMedicinalId));
                                                      } else {
                                                        selectedItems
                                                            .removeWhere(
                                                          (element) =>
                                                              element
                                                                  .plantaMedicinalId ==
                                                              e.plantaMedicinalId,
                                                        );
                                                      }
                                                      formState.didChange(
                                                          selectedItems);
                                                      atencionSaludBloc.add(
                                                          PlantasMedicinalesChanged(
                                                              selectedItems));
                                                    },
                                                  );
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
            ],
          ),
      ],
    );
  }
}
