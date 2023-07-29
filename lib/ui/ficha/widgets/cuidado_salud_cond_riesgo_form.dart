import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/nombre_enfermedad_model.dart';
import '../../../data/models/servicio_solicitado_model.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
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

class CuidadoSaludCondRiesgoForm extends StatefulWidget {
  const CuidadoSaludCondRiesgoForm({super.key, required this.currentAfiliado});

  final GrupoFamiliarEntity currentAfiliado;

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

  List<LstServicioSolicitado> _selectedServiciosSolicitados = [];
  List<LstNombreEnfermedad> _selectedNombresEnfermedades = [];

  String? _validateServiciosSolicitados() {
    if (_selectedServiciosSolicitados.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedServiciosSolicitados.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateNombresEnfermedades() {
    if (_selectedNombresEnfermedades.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedNombresEnfermedades.length > 3) {
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

    BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context)
        .add(GetCuidadoSaludCondRiesgo(widget.currentAfiliado.afiliadoId!));
  }

  Future<void> getOptions(int? cuidadoSaludCondRiesgoId) async {
    final servicioSolicitadoCubit = BlocProvider.of<ServicioSolicitadoCubit>(
      context,
    );

    final nombreEnfermedadCubit = BlocProvider.of<NombreEnfermedadCubit>(
      context,
    );

    _selectedServiciosSolicitados = await servicioSolicitadoCubit
        .getServiciosSolicitadosDB(cuidadoSaludCondRiesgoId);
    _selectedNombresEnfermedades = await nombreEnfermedadCubit
        .getNombresEnfermedadesDB(cuidadoSaludCondRiesgoId);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);
    return BlocListener<CuidadoSaludCondRiesgoBloc,
            CuidadoSaludCondRiesgoEntity>(
        listener: (context, state) {
          if (state.formStatus is CuidadoSaludCondRiesgoFormLoaded) {
            setState(() {
              _ultimaVezInstSaludId = state.ultimaVezInstSaludId;
              _seguimientoEnfermedadId = state.seguimientoEnfermedadId;
              _condicionNutricionalId = state.condicionNutricionalId;
              _tosFlemaId = state.tosFlemaId;
              _manchasPielId = state.manchasPielId;
              _carnetVacunacionId = state.carnetVacunacionId;
              _esquemaVacunacionId = state.esquemaVacunacionId;
              _lugarVacunacionId = state.lugarVacunacionId;
              _utilizaMetodoPlanificacionId =
                  state.utilizaMetodoPlanificacionId;
              _metodoPlanificacionId = state.metodoPlanificacionId;
              _conductaSeguirId = state.conductaSeguirId;
              _tosFlemaId = state.tosFlemaId;
              _manchasPielId = state.manchasPielId;
              _carnetVacunacionId = state.carnetVacunacionId;
            });
            getOptions(state.cuidadoSaludCondRiesgoId);
          }
        },
        child: ListView(children: [
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
            decoration: const InputDecoration(
              labelText: 'Integrante Grupo Familiar',
              border: OutlineInputBorder(),
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
                return DropdownButtonFormField<int>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: _ultimaVezInstSaludId,
                  items: state.ultimasVecesInstSaludLoaded!
                      .map(
                        (ultimaVezInstSalud) => DropdownMenuItem<int>(
                          value: ultimaVezInstSalud.ultimaVezInstSaludId,
                          child: Text(ultimaVezInstSalud.descripcion),
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
                return FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _selectedServiciosSolicitados,
                  builder:
                      (FormFieldState<List<LstServicioSolicitado>> formstate) {
                    return Column(
                      children: [
                        Wrap(
                            children: List<Widget>.generate(
                                state.serviciosSolicitadosLoaded!.length,
                                (index) {
                          final e = state.serviciosSolicitadosLoaded![index];
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: _selectedServiciosSolicitados.any(
                                      (element) =>
                                          element.servicioSolicitadoId ==
                                          e.servicioSolicitadoId),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedServiciosSolicitados.add(
                                            LstServicioSolicitado(
                                                servicioSolicitadoId:
                                                    e.servicioSolicitadoId));
                                      } else {
                                        _selectedServiciosSolicitados
                                            .removeWhere(
                                          (element) =>
                                              element.servicioSolicitadoId ==
                                              e.servicioSolicitadoId,
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
                                  state.serviciosSolicitadosLoaded!.length - 1)
                                const VerticalDivider(),
                            ],
                          );
                        })),
                        Text(
                          _validateServiciosSolicitados() ?? '',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    );
                  },
                  validator: (_) => _validateServiciosSolicitados(),
                  onSaved: (List<LstServicioSolicitado>? value) {
                    cuidadoSaludCondRiesgoBloc
                        .add(ServiciosSolicitadosChanged(value!));
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
                return FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _tieneEnfermedad,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
                                  value: e.opcionId,
                                  groupValue: _tieneEnfermedad,
                                  onChanged: (int? newValue) {
                                    if (newValue == 2) {
                                      setState(() {
                                        _tieneEnfermedad = newValue!;
                                        _selectedNombresEnfermedades = [];
                                      });
                                      cuidadoSaludCondRiesgoBloc.add(
                                          const NombresEnfermedadesChanged([]));
                                    } else {
                                      setState(() {
                                        _tieneEnfermedad = newValue!;
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
                      return FormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _selectedNombresEnfermedades,
                        builder: (FormFieldState<List<LstNombreEnfermedad>>
                            formstate) {
                          return Column(
                            children: [
                              Wrap(
                                  children: List<Widget>.generate(
                                      state.nombresEnfermedadesLoaded!.length,
                                      (index) {
                                final e =
                                    state.nombresEnfermedadesLoaded![index];
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        value: _selectedNombresEnfermedades.any(
                                            (element) =>
                                                element.nombreEnfermedadId ==
                                                e.nombreEnfermedadId),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              _selectedNombresEnfermedades.add(
                                                  LstNombreEnfermedad(
                                                      nombreEnfermedadId: e
                                                          .nombreEnfermedadId));
                                            } else {
                                              _selectedNombresEnfermedades
                                                  .removeWhere(
                                                (element) =>
                                                    element
                                                        .nombreEnfermedadId ==
                                                    e.nombreEnfermedadId,
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
                                        state.nombresEnfermedadesLoaded!
                                                .length -
                                            1)
                                      const VerticalDivider(),
                                  ],
                                );
                              })),
                              Text(
                                _validateNombresEnfermedades() ?? '',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          );
                        },
                        validator: (_) => _validateNombresEnfermedades(),
                        onSaved: (List<LstNombreEnfermedad>? value) {
                          cuidadoSaludCondRiesgoBloc
                              .add(NombresEnfermedadesChanged(value!));
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
                      return DropdownButtonFormField<int>(
                        isExpanded: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        value: _seguimientoEnfermedadId,
                        items: state.seguimientoEnfermedadesLoaded!
                            .map(
                              (seguimientoEnfermedad) => DropdownMenuItem<int>(
                                value: seguimientoEnfermedad
                                    .seguimientoEnfermedadId,
                                child: Text(seguimientoEnfermedad.descripcion),
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
                return DropdownButtonFormField<int>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: _condicionNutricionalId,
                  items: state.condicionesNutricionalesLoaded!
                      .map(
                        (condicionNutricional) => DropdownMenuItem<int>(
                          value: condicionNutricional.condicionNutricionalId,
                          child: Text(condicionNutricional.descripcion),
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
                return FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _tosFlemaId,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
                                  value: e.opcionId,
                                  groupValue: _tosFlemaId,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _tosFlemaId = newValue!;
                                    });

                                    cuidadoSaludCondRiesgoBloc
                                        .add(TosFlemaChanged(newValue!));
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
            'Presenta manchas inusuales en la piel que no pican y no duelen',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Divider(),
          BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
            builder: (context, state) {
              if (state is OpcionesSiNoLoaded) {
                return FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _manchasPielId,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
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
                return FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _carnetVacunacionId,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
                                  value: e.opcionId,
                                  groupValue: _carnetVacunacionId,
                                  onChanged: (int? newValue) {
                                    if (newValue == 2) {
                                      setState(() {
                                        _carnetVacunacionId = newValue!;
                                        _esquemaVacunacionId = null;
                                      });
                                      cuidadoSaludCondRiesgoBloc.add(
                                          const EsquemaVacunacionChanged(0));
                                    } else {
                                      setState(() {
                                        _carnetVacunacionId = newValue!;
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
                      return FormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _esquemaVacunacionId,
                        builder: (FormFieldState<int> formstate) => Column(
                          children: [
                            Column(
                                children: state.esquemasVacunacionLoaded!
                                    .map(
                                      (e) => RadioListTile(
                                        title: Text(e.descripcion),
                                        value: e.esquemaVacunacionId,
                                        groupValue: _esquemaVacunacionId,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            _esquemaVacunacionId = newValue!;
                                          });
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
                      return FormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _lugarVacunacionId,
                        builder: (FormFieldState<int> formstate) => Column(
                          children: [
                            Column(
                                children: state.lugaresVacunacionLoaded!
                                    .map(
                                      (e) => RadioListTile(
                                        title: Text(e.descripcion),
                                        value: e.lugarVacunacionId,
                                        groupValue: _lugarVacunacionId,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            _lugarVacunacionId = newValue!;
                                          });
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
                return FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _utilizaMetodoPlanificacionId,
                  builder: (FormFieldState<int> formstate) => Column(
                    children: [
                      Column(
                          children: state.opcionesSiNoLoaded!
                              .map(
                                (e) => RadioListTile(
                                  title: Text(e.descripcion),
                                  value: e.opcionId,
                                  groupValue: _utilizaMetodoPlanificacionId,
                                  onChanged: (int? newValue) {
                                    if (newValue == 2 || newValue == 3) {
                                      setState(() {
                                        _utilizaMetodoPlanificacionId =
                                            newValue!;
                                        _metodoPlanificacionId = null;
                                        _conductaSeguirId = null;
                                      });
                                      cuidadoSaludCondRiesgoBloc.add(
                                          const UtilizaMetodoPlanificacionChanged(
                                              0));
                                      cuidadoSaludCondRiesgoBloc.add(
                                          const MetodoPlanificacionChanged(0));
                                      cuidadoSaludCondRiesgoBloc
                                          .add(const ConductaSeguirChanged(0));
                                    } else {
                                      setState(() {
                                        _utilizaMetodoPlanificacionId =
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
                BlocBuilder<MetodoPlanificacionCubit,
                    MetodosPlanificacionState>(
                  builder: (context, state) {
                    if (state is MetodosPlanificacionLoaded) {
                      return DropdownButtonFormField<int>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        value: _metodoPlanificacionId,
                        items: state.metodosPlanificacionLoaded!
                            .map(
                              (metodoPlanificacion) => DropdownMenuItem<int>(
                                value:
                                    metodoPlanificacion.metodoPlanificacionId,
                                child: Text(metodoPlanificacion.descripcion),
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
                      return DropdownButtonFormField<int>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        value: _conductaSeguirId,
                        items: state.conductasSeguirLoaded!
                            .map(
                              (conductaSeguir) => DropdownMenuItem<int>(
                                value: conductaSeguir.conductaSeguirId,
                                child: Text(conductaSeguir.descripcion),
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
              ],
            ),
        ]));
  }
}
