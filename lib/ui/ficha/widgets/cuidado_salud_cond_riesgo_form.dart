import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/utils/input_decoration.dart';

import '../../../data/models/nombre_enfermedad.dart';
import '../../../data/models/servicio_solicitado.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo.dart';
import '../../../domain/entities/grupo_familiar.dart';
import '../../../domain/usecases/condicion_nutricional/condicion_nutricional_exports.dart';
import '../../../domain/usecases/conducta_seguir/conducta_seguir_exports.dart';
import '../../../domain/usecases/esquema_vacunacion/esquema_vacunacion_exports.dart';
import '../../../domain/usecases/lugar_vacunacion/lugar_vacunacion_exports.dart';
import '../../../domain/usecases/nombre_enfermedad/nombre_enfermedad_exports.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../../domain/usecases/seguimiento_enfermedad/seguimiento_enfermedad_exports.dart';
import '../../../domain/usecases/servicio_solicitado/servicio_solicitado_exports.dart';
import '../../../domain/usecases/ultima_vez_inst_salud/ultima_vez_inst_salud_exports.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../cubits/metodo_planificacion/metodo_planificacion_cubit.dart';
import '../helpers/nombres_enfermedades_helper.dart';
import '../helpers/servicios_solicitados_helper.dart';

class CuidadoSaludCondRiesgoForm extends StatefulWidget {
  const CuidadoSaludCondRiesgoForm(
      {super.key,
      required this.currentAfiliado,
      required this.cuidadoSaludCondRiesgo});

  final GrupoFamiliarEntity currentAfiliado;
  final CuidadoSaludCondRiesgoEntity cuidadoSaludCondRiesgo;

  @override
  State<CuidadoSaludCondRiesgoForm> createState() =>
      _CuidadoSaludCondRiesgoFormState();
}

class _CuidadoSaludCondRiesgoFormState
    extends State<CuidadoSaludCondRiesgoForm> {
  final _nombresApellidosCtrl = TextEditingController();
  int? _ultimaVezInstSaludId;
  int? _seguimientoEnfermedadId;
  int? _condicionNutricionalId;
  int? _tosFlemaId;
  int? _manchasPielId;
  int? _carnetVacunacionId;
  int? _esquemaVacunacionId;
  int? _lugarVacunacionId;
  int? _metodoPlanificacionId;
  int? _utilizaMetodoPlanificacionId;
  int? _conductaSeguirId;
  int? _tieneEnfermedad;

  @override
  void initState() {
    super.initState();
    _nombresApellidosCtrl.text = '${widget.currentAfiliado.nombre1} '
        '${widget.currentAfiliado.nombre2} '
        '${widget.currentAfiliado.apellido1} '
        '${widget.currentAfiliado.apellido2}';

    setState(() {
      _ultimaVezInstSaludId =
          widget.cuidadoSaludCondRiesgo.ultimaVezInstSaludId;
      _seguimientoEnfermedadId =
          widget.cuidadoSaludCondRiesgo.seguimientoEnfermedadId == 0
              ? null
              : widget.cuidadoSaludCondRiesgo.seguimientoEnfermedadId;
      _condicionNutricionalId =
          widget.cuidadoSaludCondRiesgo.condicionNutricionalId;
      _tosFlemaId = widget.cuidadoSaludCondRiesgo.tosFlemaId;
      _manchasPielId = widget.cuidadoSaludCondRiesgo.manchasPielId;
      _carnetVacunacionId = widget.cuidadoSaludCondRiesgo.carnetVacunacionId;
      _esquemaVacunacionId =
          widget.cuidadoSaludCondRiesgo.esquemaVacunacionId == 0
              ? null
              : widget.cuidadoSaludCondRiesgo.esquemaVacunacionId;
      _lugarVacunacionId = widget.cuidadoSaludCondRiesgo.lugarVacunacionId == 0
          ? null
          : widget.cuidadoSaludCondRiesgo.lugarVacunacionId;
      _utilizaMetodoPlanificacionId =
          widget.cuidadoSaludCondRiesgo.utilizaMetodoPlanificacionId == 0
              ? null
              : widget.cuidadoSaludCondRiesgo.utilizaMetodoPlanificacionId;
      _metodoPlanificacionId =
          widget.cuidadoSaludCondRiesgo.metodoPlanificacionId == 0
              ? null
              : widget.cuidadoSaludCondRiesgo.metodoPlanificacionId;
      _conductaSeguirId = widget.cuidadoSaludCondRiesgo.conductaSeguirId == 0
          ? null
          : widget.cuidadoSaludCondRiesgo.conductaSeguirId;

      if (widget.cuidadoSaludCondRiesgo.lstNombresEnfermedades != null &&
          widget.cuidadoSaludCondRiesgo.lstNombresEnfermedades!.isNotEmpty) {
        _tieneEnfermedad = 1;
      } else {
        _tieneEnfermedad = 2;
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context)
            .add(const NombresEnfermedadesChanged([]));
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context)
            .add(const SeguimientoEnfermedadChanged(0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);
    return ListView(children: [
      const Divider(),
      const Text(
        'V. CUIDADO DE LA SALUD Y CONDICIONES DE RIESGO',
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
        'Cuando fue la última vez que asistió a la institución de salud',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<UltimaVezInstSaludCubit, UltimasVecesInstSaludState>(
        builder: (context, state) {
          if (state is UltimasVecesInstSaludLoaded) {
            final ultimasVecesInstSaludLoaded =
                state.ultimasVecesInstSaludLoaded!;

            return DropdownButtonFormField<int>(
              value: _ultimaVezInstSaludId,
              items: ultimasVecesInstSaludLoaded
                  .map(
                    (ultimaVezInstSalud) => DropdownMenuItem<int>(
                      value: ultimaVezInstSalud.ultimaVezInstSaludId,
                      child: Text(ultimaVezInstSalud.descripcion ?? ''),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _ultimaVezInstSaludId = newValue;
                });
                cuidadoSaludCondRiesgoBloc
                    .add(UltimaVezInstSaludChanged(newValue!));
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
        'Servicios Solicitados',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<ServicioSolicitadoCubit, ServiciosSolicitadosState>(
        builder: (context, state) {
          if (state is ServiciosSolicitadosLoaded) {
            final serviciosSolicitadosLoaded =
                state.serviciosSolicitadosLoaded!;

            return FormField<List<LstServicioSolicitado>>(
              initialValue:
                  cuidadoSaludCondRiesgoBloc.state.lstServiciosSolicitados,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Seleccione al menos una opción.';
                }
                return null;
              },
              builder: (FormFieldState<List<LstServicioSolicitado>> formState) {
                return Column(
                  children: [
                    Wrap(
                      children: List<Widget>.generate(
                        serviciosSolicitadosLoaded.length,
                        (index) {
                          final servicioSolicitado =
                              serviciosSolicitadosLoaded[index];
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.servicioSolicitadoId ==
                                          servicioSolicitado
                                              .servicioSolicitadoId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    handleServicioSolicitadoSelection(
                                        formState,
                                        context,
                                        value,
                                        servicioSolicitado
                                            .servicioSolicitadoId!,
                                        cuidadoSaludCondRiesgoBloc);
                                  }),
                              Flexible(
                                child: Text(
                                  servicioSolicitado.descripcion ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (index < serviciosSolicitadosLoaded.length - 1)
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
        'Le han diagnosticado alguna enfermedad que requiere tratamiento permanente o supervisado',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _tieneEnfermedad,
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
                                    groupValue: _tieneEnfermedad,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        _seguimientoEnfermedadId = null;
                                        cuidadoSaludCondRiesgoBloc.add(
                                            const NombresEnfermedadesChanged(
                                                []));
                                        cuidadoSaludCondRiesgoBloc.add(
                                            const SeguimientoEnfermedadChanged(
                                                0));
                                      }

                                      setState(() {
                                        _tieneEnfermedad = newValue!;
                                      });
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
      if (_tieneEnfermedad == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Nombre de la enfermedad',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<NombreEnfermedadCubit, NombresEnfermedadesState>(
              builder: (context, state) {
                if (state is NombresEnfermedadesLoaded) {
                  final nombresEnfermedadesLoaded =
                      state.nombresEnfermedadesLoaded!;

                  return FormField<List<LstNombreEnfermedad>>(
                    initialValue:
                        cuidadoSaludCondRiesgoBloc.state.lstNombresEnfermedades,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      }
                      return null;
                    },
                    builder:
                        (FormFieldState<List<LstNombreEnfermedad>> formState) {
                      return Column(
                        children: [
                          Wrap(
                            children: List<Widget>.generate(
                              nombresEnfermedadesLoaded.length,
                              (index) {
                                final nombreEnfermedad =
                                    nombresEnfermedadesLoaded[index];
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        value: formState.value?.any((e) =>
                                                e.nombreEnfermedadId ==
                                                nombreEnfermedad
                                                    .nombreEnfermedadId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          handleNombreEnfermedadSelection(
                                              formState,
                                              context,
                                              value,
                                              nombreEnfermedad
                                                  .nombreEnfermedadId!,
                                              cuidadoSaludCondRiesgoBloc);
                                        }),
                                    Flexible(
                                      child: Text(
                                        nombreEnfermedad.descripcion ?? '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (index <
                                        nombresEnfermedadesLoaded.length - 1)
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
              'Seguimiento de la Enfermedad',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<SeguimientoEnfermedadCubit,
                SeguimientoEnfermedadesState>(
              builder: (context, state) {
                if (state is SeguimientoEnfermedadesLoaded) {
                  final seguimientoEnfermedadesLoaded =
                      state.seguimientoEnfermedadesLoaded!;

                  return DropdownButtonFormField<int>(
                    isExpanded: true,
                    value: _seguimientoEnfermedadId,
                    items: seguimientoEnfermedadesLoaded
                        .map(
                          (seguimientoEnfermedad) => DropdownMenuItem<int>(
                            value:
                                seguimientoEnfermedad.seguimientoEnfermedadId,
                            child:
                                Text(seguimientoEnfermedad.descripcion ?? ''),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Seleccione una opción',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _seguimientoEnfermedadId = newValue!;
                      });
                      cuidadoSaludCondRiesgoBloc
                          .add(SeguimientoEnfermedadChanged(newValue!));
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
      const Divider(),
      const Text(
        'Condición Nutricional',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<CondicionNutricionalCubit, CondicionesNutricionalesState>(
        builder: (context, state) {
          if (state is CondicionesNutricionalesLoaded) {
            final condicionesNutricionalesLoaded =
                state.condicionesNutricionalesLoaded!;

            return DropdownButtonFormField<int>(
              value: _condicionNutricionalId,
              items: condicionesNutricionalesLoaded
                  .map(
                    (condicionNutricional) => DropdownMenuItem<int>(
                      value: condicionNutricional.condicionNutricionalId,
                      child: Text(condicionNutricional.descripcion ?? ''),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _condicionNutricionalId = newValue!;
                });
                cuidadoSaludCondRiesgoBloc
                    .add(CondicionNutricionalChanged(newValue!));
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
        'Presenta tos con flema por mas de 15 días',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _tosFlemaId,
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
                                    groupValue: _tosFlemaId,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        _tosFlemaId = newValue!;
                                      });
                                      formstate.didChange(newValue);

                                      cuidadoSaludCondRiesgoBloc
                                          .add(TosFlemaChanged(newValue!));
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
      const Divider(),
      const Text(
        'Presenta manchas inusuales en la piel que no pican y no duelen',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _manchasPielId,
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
                                    groupValue: _manchasPielId,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        _manchasPielId = newValue!;
                                      });
                                      cuidadoSaludCondRiesgoBloc
                                          .add(ManchasPielChanged(newValue!));
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
      const Divider(),
      const Text(
        'Cuenta con Carnet de Vacunación',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _carnetVacunacionId,
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
                                    groupValue: _carnetVacunacionId,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        setState(() {
                                          _esquemaVacunacionId = null;
                                          _lugarVacunacionId = null;
                                        });
                                        cuidadoSaludCondRiesgoBloc.add(
                                            const EsquemaVacunacionChanged(0));
                                        cuidadoSaludCondRiesgoBloc.add(
                                            const LugarVacunacionChanged(0));
                                      }
                                      setState(() {
                                        _carnetVacunacionId = newValue!;
                                      });

                                      formstate.didChange(newValue);
                                      cuidadoSaludCondRiesgoBloc.add(
                                          CarnetVacunacionChanged(newValue!));
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
      if (_carnetVacunacionId == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Esquema de vacunación acorde a la edad',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<EsquemaVacunacionCubit, EsquemasVacunacionState>(
              builder: (context, state) {
                if (state is EsquemasVacunacionLoaded) {
                  final esquemasVacunacionLoaded =
                      state.esquemasVacunacionLoaded!;
                  return FormField(
                    initialValue: _esquemaVacunacionId,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: esquemasVacunacionLoaded
                                .map(
                                  (e) => RadioListTile<int?>(
                                    title: Text(e.descripcion ?? ''),
                                    value: e.esquemaVacunacionId,
                                    groupValue: _esquemaVacunacionId,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        _esquemaVacunacionId = newValue!;
                                      });
                                      formstate.didChange(newValue);
                                      cuidadoSaludCondRiesgoBloc.add(
                                          EsquemaVacunacionChanged(newValue!));
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
            const Text(
              'Donde fue vacunado',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<LugarVacunacionCubit, LugaresVacunacionState>(
              builder: (context, state) {
                if (state is LugaresVacunacionLoaded) {
                  final lugaresVacunacionLoaded =
                      state.lugaresVacunacionLoaded!;

                  return FormField(
                    initialValue: _lugarVacunacionId,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: lugaresVacunacionLoaded
                                .map(
                                  (e) => RadioListTile<int?>(
                                    title: Text(e.descripcion ?? ''),
                                    value: e.lugarVacunacionId,
                                    groupValue: _lugarVacunacionId,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        _lugarVacunacionId = newValue!;
                                      });
                                      formstate.didChange(newValue);

                                      cuidadoSaludCondRiesgoBloc.add(
                                          LugarVacunacionChanged(newValue!));
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
          ],
        ),
      const Divider(),
      const Text(
        'Utiliza algún método de planificación familiar',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _utilizaMetodoPlanificacionId,
              builder: (FormFieldState<int> formstate) => Column(
                children: [
                  Column(
                      children: opcionesSiNoLoaded
                          .map(
                            (e) => widget.currentAfiliado.edad! < 12 &&
                                    e.opcionId == 1
                                ? Container()
                                : RadioListTile<int?>(
                                    title: Text(e.descripcion ?? ''),
                                    value: e.opcionId,
                                    groupValue: _utilizaMetodoPlanificacionId,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2 || newValue == 3) {
                                        setState(() {
                                          _metodoPlanificacionId = null;
                                          _conductaSeguirId = null;
                                        });
                                        cuidadoSaludCondRiesgoBloc.add(
                                            const MetodoPlanificacionChanged(
                                                0));
                                        cuidadoSaludCondRiesgoBloc.add(
                                            const ConductaSeguirChanged(0));
                                      }

                                      setState(() {
                                        _utilizaMetodoPlanificacionId =
                                            newValue!;
                                      });
                                      formstate.didChange(newValue);
                                      cuidadoSaludCondRiesgoBloc.add(
                                          UtilizaMetodoPlanificacionChanged(
                                              newValue!));
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
      if (_utilizaMetodoPlanificacionId == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Que metodo de planificación utiliza al momento de la consulta',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<MetodoPlanificacionCubit, MetodosPlanificacionState>(
              builder: (context, state) {
                if (state is MetodosPlanificacionLoaded) {
                  final metodosPlanificacionLoaded =
                      state.metodosPlanificacionLoaded!;

                  return DropdownButtonFormField<int>(
                    value: _metodoPlanificacionId,
                    items: metodosPlanificacionLoaded
                        .map(
                          (metodoPlanificacion) => DropdownMenuItem<int>(
                            value: metodoPlanificacion.metodoPlanificacionId,
                            child: Text(metodoPlanificacion.descripcion ?? ''),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Seleccione una opción',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _metodoPlanificacionId = newValue!;
                      });
                      cuidadoSaludCondRiesgoBloc
                          .add(MetodoPlanificacionChanged(newValue!));
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
      const Divider(),
      const Text(
        'Conducta a seguir',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<ConductaSeguirCubit, ConductasSeguirState>(
        builder: (context, state) {
          if (state is ConductasSeguirLoaded) {
            final conductasSeguirLoaded = state.conductasSeguirLoaded!;

            return DropdownButtonFormField<int>(
              isExpanded: true,
              value: _conductaSeguirId,
              items: conductasSeguirLoaded
                  .map(
                    (conductaSeguir) => DropdownMenuItem<int>(
                      value: conductaSeguir.conductaSeguirId,
                      child: Text(conductaSeguir.descripcion ?? ''),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _conductaSeguirId = newValue!;
                });
                cuidadoSaludCondRiesgoBloc
                    .add(ConductaSeguirChanged(newValue!));
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
    ]);
  }
}
