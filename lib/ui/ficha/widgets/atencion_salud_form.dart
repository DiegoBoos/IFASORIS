import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/utils/input_decoration.dart';

import '../../../data/models/enfermedad_tradicional.dart';
import '../../../data/models/especialidad_med_tradicional.dart';
import '../../../data/models/lugar_atencion_medico.dart';
import '../../../data/models/planta_medicinal.dart';
import '../../../domain/entities/atencion_salud.dart';
import '../../../domain/entities/grupo_familiar.dart';
import '../../../domain/usecases/enfermedad_acude/enfermedad_acude_exports.dart';
import '../../../domain/usecases/enfermedad_tradicional/enfermedad_tradicional_exports.dart';
import '../../../domain/usecases/lugar_planta_medicinal/lugar_planta_medicinal_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import '../../cubits/especialidad_med_tradicional/especialidad_med_tradicional_cubit.dart';
import '../../cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import '../../cubits/planta_medicinal/planta_medicinal_cubit.dart';
import '../helpers/enfermedades_tradicionales_helper.dart';
import '../helpers/esp_med_tradicional_helper.dart';
import '../helpers/lugares_atencion_medico_helper.dart';
import '../helpers/plantas_medicinales_helper.dart';

class AtencionSaludForm extends StatefulWidget {
  const AtencionSaludForm(
      {super.key, required this.currentAfiliado, required this.atencionSalud});

  final GrupoFamiliarEntity currentAfiliado;
  final AtencionSaludEntity atencionSalud;

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
    _nombresApellidosCtrl.text = '${widget.currentAfiliado.nombre1} '
        '${widget.currentAfiliado.nombre2} '
        '${widget.currentAfiliado.apellido1} '
        '${widget.currentAfiliado.apellido2}';

    setState(() {
      _enfermedadAcudeId = widget.atencionSalud.enfermedadAcudeId;
      _recibioAtencionMedTradicionalId =
          widget.atencionSalud.recibioAtencionMedTradicionalId;
      _enfermedadTratamientoId = widget.atencionSalud.enfermedadTratamientoId;
      _utilizaPlantasMedId = widget.atencionSalud.utilizaPlantasMedId == 0
          ? null
          : widget.atencionSalud.utilizaPlantasMedId;
      _lugarPlantaMedicinalId = widget.atencionSalud.lugarPlantaMedicinalId == 0
          ? null
          : widget.atencionSalud.lugarPlantaMedicinalId;
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
          decoration: CustomInputDecoration.inputDecoration(
            hintText: 'Nombres y Apellidos',
            labelText: 'Integrante Grupo Familiar',
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
              final enfermedadesAcudeLoaded = state.enfermedadesAcudeLoaded!;

              return DropdownButtonFormField<int>(
                isExpanded: true,
                value: _enfermedadAcudeId,
                items: enfermedadesAcudeLoaded
                    .map(
                      (enfermedadAcude) => DropdownMenuItem<int>(
                        value: enfermedadAcude.enfermedadAcudeId,
                        child: Text(enfermedadAcude.descripcion ?? ''),
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
              final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

              return FormField(
                initialValue: _recibioAtencionMedTradicionalId,
                builder: (FormFieldState<int> formstate) => Column(
                  children: [
                    Column(
                        children: opcionesSiNoLoaded
                            .map(
                              (e) => e.opcionId == 3
                                  ? Container()
                                  : RadioListTile<int?>(
                                      title: Text(e.descripcion ?? ''),
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
                    final especialidadesMedTradicionalLoaded =
                        state.especialidadesMedTradicionalLoaded!;

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
                                especialidadesMedTradicionalLoaded.length,
                                (index) {
                                  final especialidadMedTradicional =
                                      especialidadesMedTradicionalLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.especialidadMedTradId ==
                                                  especialidadMedTradicional
                                                      .especialidadMedTradId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleEspecialidadMedTradSelection(
                                                formState,
                                                context,
                                                value,
                                                especialidadMedTradicional
                                                    .especialidadMedTradId!,
                                                atencionSaludBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          especialidadMedTradicional
                                                  .descripcion ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          especialidadesMedTradicionalLoaded
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
                    final enfermedadesTradicionalesLoaded =
                        state.enfermedadesTradicionalesLoaded!;
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
                                enfermedadesTradicionalesLoaded.length,
                                (index) {
                                  final enfermedadTradicional = state
                                      .enfermedadesTradicionalesLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.enfermedadTradicionalId ==
                                                  enfermedadTradicional
                                                      .enfermedadTradicionalId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleEnfermedadTradicionalSelection(
                                                formState,
                                                context,
                                                value,
                                                enfermedadTradicional
                                                    .enfermedadTradicionalId!,
                                                atencionSaludBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          enfermedadTradicional.descripcion ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          enfermedadesTradicionalesLoaded
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
                    final lugaresAtencionMedicoLoaded =
                        state.lugaresAtencionMedicoLoaded!;
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
                                lugaresAtencionMedicoLoaded.length,
                                (index) {
                                  final lugarAtencionMedico =
                                      lugaresAtencionMedicoLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.lugarAtencionMedicoId ==
                                                  lugarAtencionMedico
                                                      .lugarAtencionMedicoId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleLugarAtencionMedicoSelection(
                                                formState,
                                                context,
                                                value,
                                                lugarAtencionMedico
                                                    .lugarAtencionMedicoId!,
                                                atencionSaludBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          lugarAtencionMedico.descripcion ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          lugaresAtencionMedicoLoaded.length -
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
              final enfermedadesTratamientoLoaded =
                  state.enfermedadesTratamientoLoaded!;
              return DropdownButtonFormField<int>(
                isExpanded: true,
                value: _enfermedadTratamientoId,
                items: enfermedadesTratamientoLoaded
                    .map(
                      (enfermedadTratamiento) => DropdownMenuItem<int>(
                        value: enfermedadTratamiento.enfermedadTratamientoId,
                        child: Text(enfermedadTratamiento.descripcion ?? ''),
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
              final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

              return FormField(
                initialValue: _utilizaPlantasMedId,
                builder: (FormFieldState<int> formstate) => Column(
                  children: [
                    Column(
                        children: opcionesSiNoLoaded
                            .map(
                              (e) => e.opcionId == 3
                                  ? Container()
                                  : RadioListTile<int?>(
                                      title: Text(e.descripcion ?? ''),
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
                    final lugaresPlantasMedicinalesLoaded =
                        state.lugaresPlantasMedicinalesLoaded!;

                    return DropdownButtonFormField<int>(
                      value: _lugarPlantaMedicinalId,
                      items: lugaresPlantasMedicinalesLoaded
                          .map(
                            (lugarPlantaMedicinal) => DropdownMenuItem<int>(
                              value:
                                  lugarPlantaMedicinal.lugarPlantaMedicinalId,
                              child:
                                  Text(lugarPlantaMedicinal.descripcion ?? ''),
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
                    final plantasMedicinalesLoaded =
                        state.plantasMedicinalesLoaded!;

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
                                plantasMedicinalesLoaded.length,
                                (index) {
                                  final plantaMedicinal =
                                      plantasMedicinalesLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.plantaMedicinalId ==
                                                  plantaMedicinal
                                                      .plantaMedicinalId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handlePlantaMedicinalSelection(
                                                formState,
                                                context,
                                                value,
                                                plantaMedicinal
                                                    .plantaMedicinalId!,
                                                atencionSaludBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          plantaMedicinal.descripcion ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          plantasMedicinalesLoaded.length - 1)
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
