import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/factor_riesgo_vivienda_model.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../../data/models/techo_vivienda_model.dart';
import '../../../data/models/tipo_combustible_vivienda_model.dart';
import '../../../data/models/tipo_sanitario_vivienda_model.dart';
import '../../../data/models/tratamiento_agua_vivienda_model.dart';
import '../../../domain/usecases/dim_vivienda/dim_vivienda_exports.dart';
import '../../../domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_exports.dart';
import '../../../domain/usecases/piso_vivienda/piso_vivienda_exports.dart';
import '../../../domain/usecases/presencia_animal_vivienda/presencia_animal_vivienda_exports.dart';
import '../../../domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_exports.dart';
import '../../../domain/usecases/tenencia_vivienda/tenencia_vivienda_exports.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda/tipo_sanitario_vivienda_exports.dart';
import '../../../domain/usecases/tipo_vivienda/tipo_vivienda_exports.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda/tratamiento_agua_vivienda_exports.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
import '../../cubits/techo_vivienda/techo_vivienda_cubit.dart';
import '../../cubits/tipo_combustible_vivienda/tipo_combustible_vivienda_cubit.dart';
import '../../utils/input_decoration.dart';

class DatosViviendaForm extends StatefulWidget {
  const DatosViviendaForm({super.key, this.dimVivienda});

  final DimViviendaEntity? dimVivienda;
  @override
  State<DatosViviendaForm> createState() => _DatosViviendaFormState();
}

class _DatosViviendaFormState extends State<DatosViviendaForm> {
  int? _tipoVivienda;
  int? _tenenciaVivienda;
  int? _pisoViviendaId;
  int? _ventilacionViviendaId;
  /* int? _iluminacionViviendaId; */

  bool _showOtherTechoVivienda = false;
  String? _otroTipoTecho;
  bool _showOtherTipoSanitario = false;
  String? _otroTipoSanitario;
  bool _showOtherTipoCombustible = false;
  String? _otroTipoCombustible;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tipoVivienda = widget.dimVivienda?.tipoViviendaId;
      _tenenciaVivienda = widget.dimVivienda?.tenenciaViviendaId;
      _pisoViviendaId = widget.dimVivienda?.pisoViviendaId;
      _ventilacionViviendaId = widget.dimVivienda?.ventilacionViviendaId;
      /* _iluminacionViviendaId = widget.dimVivienda?.iluminacionViviendaId; */

      if (widget.dimVivienda != null &&
          widget.dimVivienda!.lstTechos!.isNotEmpty &&
          widget.dimVivienda!.lstTechos![0].otroTipoTecho != null) {
        _showOtherTechoVivienda = true;
      }

      if (widget.dimVivienda != null &&
          widget.dimVivienda!.lstTiposSanitario!.isNotEmpty &&
          widget.dimVivienda!.lstTiposSanitario![0].otroTipoSanitario != null) {
        _showOtherTipoSanitario = true;
      }

      if (widget.dimVivienda != null &&
          widget.dimVivienda!.lstTiposCombustible!.isNotEmpty &&
          widget.dimVivienda!.lstTiposCombustible![0].otroTipoCombustible !=
              null) {
        _showOtherTipoCombustible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          color: Theme.of(context).colorScheme.primary,
          child: const Text(
            'II. DATOS DE LA VIVIENDA',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        const Text(
          'Tipo de vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TipoViviendaCubit, TiposViviendaState>(
          builder: (context, state) {
            if (state is TiposViviendaLoaded) {
              return FormField(
                initialValue: _tipoVivienda,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tiposViviendaLoaded!.length,
                          (index) {
                            final e = state.tiposViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _tipoVivienda == e.tipoViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _tipoVivienda =
                                          value! ? e.tipoViviendaId : null;
                                    });
                                    formstate.didChange(_tipoVivienda);
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.tiposViviendaLoaded!.length - 1)
                                  const VerticalDivider(), // Adds a vertical separator between items
                              ],
                            );
                          },
                        ),
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
                onSaved: (int? newValue) {
                  dimViviendaBloc.add(TipoViviendaChanged(newValue!));
                },
              );
            }
            return Container();
          },
        ),
        /*  BlocBuilder<DormitoriodimViviendaBloc, DormitoriosViviendaState>(
            builder: (context, state) {
              if (state is DormitoriosViviendaLoaded) {
                return DropdownButtonFormField<int>(
                  value: _dormitorioVivienda,
                  items: state.dormitoriosViviendaLoaded!
                      .map((dormitorioVivienda) => DropdownMenuItem<int>(
                            value: dormitorioVivienda.dormitorioViviendaId,
                            child: Text(dormitorioVivienda.descripcion),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                      labelText: 'Dormitorio vivienda',
                      border: OutlineInputBorder()),
                  onChanged: (int? newValue) {
                    setState(() {
                      _dormitorioVivienda = newValue;
                    });
                    dimViviendaBloc.changeDormitorioViviendaId(newValue);
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
          ), */
        const Divider(),
        const Text(
          'Tenencia de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TenenciaViviendaCubit, TenenciasViviendaState>(
          builder: (context, state) {
            if (state is TenenciasViviendaLoaded) {
              return FormField(
                initialValue: _tenenciaVivienda,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tenenciasViviendaLoaded!.length,
                          (index) {
                            final e = state.tenenciasViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value:
                                      _tenenciaVivienda == e.tenenciaViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _tenenciaVivienda =
                                          value! ? e.tenenciaViviendaId : null;
                                    });
                                    formstate.didChange(_tenenciaVivienda);
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.tenenciasViviendaLoaded!.length - 1)
                                  const VerticalDivider(), // Adds a vertical separator between items
                              ],
                            );
                          },
                        ),
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
                onSaved: (int? newValue) {
                  dimViviendaBloc.add(TenenciaViviendaChanged(newValue!));
                },
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'Piso de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<PisoViviendaCubit, PisosViviendaState>(
          builder: (context, state) {
            if (state is PisosViviendaLoaded) {
              return FormField(
                initialValue: _pisoViviendaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.pisosViviendaLoaded!.length,
                          (index) {
                            final e = state.pisosViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _pisoViviendaId == e.pisoViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _pisoViviendaId =
                                          value! ? e.pisoViviendaId : null;
                                    });
                                    formstate.didChange(_pisoViviendaId);
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.pisosViviendaLoaded!.length - 1)
                                  const VerticalDivider(), // Adds a vertical separator between items
                              ],
                            );
                          },
                        ),
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
                onSaved: (int? newValue) {
                  dimViviendaBloc.add(PisoViviendaChanged(newValue!));
                },
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'Techo de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TechoViviendaCubit, TechosViviendaState>(
          builder: (context, state) {
            if (state is TechosViviendaLoaded) {
              return FormField<List<LstTecho>>(
                initialValue: dimViviendaBloc.state.lstTechos,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 3) {
                    return 'Máximo tres opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTecho>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.techosViviendaLoaded!.length,
                          (index) {
                            final e = state.techosViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.techoViviendaId ==
                                          e.techoViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems = List<LstTecho>.from(
                                        formState.value ?? []);

                                    setState(() {
                                      if (e.techoViviendaId == 6) {
                                        selectedItems = [
                                          LstTecho(
                                              techoViviendaId:
                                                  e.techoViviendaId)
                                        ];
                                        _showOtherTechoVivienda = true;
                                      } else if (value == true) {
                                        selectedItems.removeWhere((element) =>
                                            element.techoViviendaId == 6);
                                        selectedItems.add(LstTecho(
                                            techoViviendaId:
                                                e.techoViviendaId));
                                        _showOtherTechoVivienda = false;
                                        _otroTipoTecho = null;
                                      } else {
                                        selectedItems.removeWhere(
                                          (element) =>
                                              element.techoViviendaId ==
                                              e.techoViviendaId,
                                        );
                                      }

                                      if (!_showOtherTechoVivienda) {
                                        dimViviendaBloc.add(
                                            TechosViviendaChanged(
                                                selectedItems));
                                      }
                                    });
                                    formState.didChange(selectedItems);
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    e.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    state.techosViviendaLoaded!.length - 1)
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
        if (_showOtherTechoVivienda)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              initialValue: dimViviendaBloc.state.lstTechos?[0].otroTipoTecho,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Otro', labelText: 'Cuál'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
              onChanged: (String? value) {
                setState(() {
                  _otroTipoTecho = value;
                });

                dimViviendaBloc.add(TechosViviendaChanged([
                  LstTecho(techoViviendaId: 6, otroTipoTecho: _otroTipoTecho)
                ]));
              },
            ),
          ),
        const Divider(),
        const Text(
          'Ventilación',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<VentilacionViviendaCubit, VentilacionesViviendaState>(
          builder: (context, state) {
            if (state is VentilacionesViviendaLoaded) {
              return FormField(
                initialValue: _ventilacionViviendaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.ventilacionesViviendaLoaded!.length,
                          (index) {
                            final e = state.ventilacionesViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _ventilacionViviendaId ==
                                      e.ventilacionViviendaId,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _ventilacionViviendaId = newValue!
                                          ? e.ventilacionViviendaId
                                          : null;
                                    });
                                    formstate.didChange(_ventilacionViviendaId);
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.ventilacionesViviendaLoaded!.length -
                                        1)
                                  const VerticalDivider(), // Adds a vertical separator between items
                              ],
                            );
                          },
                        ),
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
                onSaved: (int? newValue) {
                  dimViviendaBloc.add(VentilacionViviendaChanged(newValue!));
                },
              );
            }
            return Container();
          },
        ),
        /*  const Divider(),
          const Text(
            'Iluminación',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Divider(),
          BlocBuilder<IluminacionViviendaCubit, IluminacionesViviendaState>(
            builder: (context, state) {
              if (state is IluminacionesViviendaLoaded) {
                return FormField(
                  
                  initialValue: _iluminacionViviendaId,
                  builder: (FormFieldState<int> formstate) {
                    return Column(
                      children: [
                        Wrap(
                          children: List<Widget>.generate(
                            state.iluminacionesViviendaLoaded!.length,
                            (index) {
                              final e = state.iluminacionesViviendaLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: _iluminacionViviendaId ==
                                        e.iluminacionViviendaId,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _iluminacionViviendaId = value!
                                            ? e.iluminacionViviendaId
                                            : null;
                                        formstate
                                            .didChange(_iluminacionViviendaId);
                                      });
                                    },
                                  ),
                                  Text(e.descripcion),
                                  if (index <
                                      state.iluminacionesViviendaLoaded!.length -
                                          1)
                                    const VerticalDivider(), // Adds a vertical separator between items
                                ],
                              );
                            },
                          ),
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
                  onSaved: (int? newValue) {
                    dimViviendaBloc.add(IluminacionViviendaChanged(newValue!));
                  },
                );
              }
              return Container();
            },
          ), */
        const Divider(),
        const Text(
          'Servicios públicos',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<ServicioPublicoViviendaCubit,
            ServiciosPublicosViviendaState>(
          builder: (context, state) {
            if (state is ServiciosPublicosViviendaLoaded) {
              return FormField<List<LstServPublico>>(
                initialValue: dimViviendaBloc.state.lstServPublicos,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 3) {
                    return 'Máximo tres opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstServPublico>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.serviciosPublicosViviendaLoaded!.length,
                          (index) {
                            final e =
                                state.serviciosPublicosViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.servicioPublicoViviendaId ==
                                          e.servicioPublicoViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems =
                                        List<LstServPublico>.from(
                                            formState.value ?? []);
                                    if (e.servicioPublicoViviendaId == 7) {
                                      selectedItems = [
                                        LstServPublico(
                                            servicioPublicoViviendaId:
                                                e.servicioPublicoViviendaId)
                                      ];
                                    } else if (value == true) {
                                      selectedItems.removeWhere((element) =>
                                          element.servicioPublicoViviendaId ==
                                          7);
                                      selectedItems.add(LstServPublico(
                                          servicioPublicoViviendaId:
                                              e.servicioPublicoViviendaId));
                                    } else {
                                      selectedItems.removeWhere(
                                        (element) =>
                                            element.servicioPublicoViviendaId ==
                                            e.servicioPublicoViviendaId,
                                      );
                                    }
                                    formState.didChange(selectedItems);
                                    dimViviendaBloc.add(
                                        ServiciosPublicosViviendaChanged(
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
                                    state.serviciosPublicosViviendaLoaded!
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
          'Tratamiento casero del agua',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TratamientoAguaViviendaCubit,
            TratamientosAguaViviendaState>(
          builder: (context, state) {
            if (state is TratamientosAguaViviendaLoaded) {
              return FormField<List<LstTmtoAgua>>(
                initialValue: dimViviendaBloc.state.lstTmtoAguas,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 3) {
                    return 'Máximo tres opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTmtoAgua>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tratamientosAguaViviendaLoaded!.length,
                          (index) {
                            final e =
                                state.tratamientosAguaViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.tratamientoAguaViviendaId ==
                                          e.tratamientoAguaViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems = List<LstTmtoAgua>.from(
                                        formState.value ?? []);
                                    if (e.tratamientoAguaViviendaId == 5) {
                                      selectedItems = [
                                        LstTmtoAgua(
                                            tratamientoAguaViviendaId:
                                                e.tratamientoAguaViviendaId)
                                      ];
                                    } else if (value == true) {
                                      selectedItems.removeWhere((element) =>
                                          element.tratamientoAguaViviendaId ==
                                          5);
                                      selectedItems.add(LstTmtoAgua(
                                          tratamientoAguaViviendaId:
                                              e.tratamientoAguaViviendaId));
                                    } else {
                                      selectedItems.removeWhere(
                                        (element) =>
                                            element.tratamientoAguaViviendaId ==
                                            e.tratamientoAguaViviendaId,
                                      );
                                    }
                                    formState.didChange(selectedItems);
                                    dimViviendaBloc.add(
                                        TratamientosAguaViviendaChanged(
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
                                    state.tratamientosAguaViviendaLoaded!
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
          'Tipo de sanitario',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TipoSanitarioViviendaCubit, TiposSanitarioViviendaState>(
          builder: (context, state) {
            if (state is TiposSanitarioViviendaLoaded) {
              return FormField<List<LstTiposSanitario>>(
                initialValue: dimViviendaBloc.state.lstTiposSanitario,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 2) {
                    return 'Máximo dos opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTiposSanitario>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tiposSanitarioViviendaLoaded!.length,
                          (index) {
                            final e =
                                state.tiposSanitarioViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.tipoSanitarioViviendaId ==
                                          e.tipoSanitarioViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems =
                                        List<LstTiposSanitario>.from(
                                            formState.value ?? []);

                                    setState(() {
                                      if (e.tipoSanitarioViviendaId == 2) {
                                        selectedItems = [
                                          LstTiposSanitario(
                                              tipoSanitarioViviendaId:
                                                  e.tipoSanitarioViviendaId)
                                        ];
                                        _showOtherTipoSanitario = false;
                                        _otroTipoSanitario = null;
                                      } else if (e.tipoSanitarioViviendaId ==
                                          5) {
                                        selectedItems = [
                                          LstTiposSanitario(
                                              tipoSanitarioViviendaId:
                                                  e.tipoSanitarioViviendaId)
                                        ];
                                        _showOtherTipoSanitario = true;
                                      } else if (value == true) {
                                        selectedItems.removeWhere((element) =>
                                            element.tipoSanitarioViviendaId ==
                                                2 ||
                                            element.tipoSanitarioViviendaId ==
                                                5);
                                        selectedItems.add(LstTiposSanitario(
                                            tipoSanitarioViviendaId:
                                                e.tipoSanitarioViviendaId));
                                        _showOtherTipoSanitario = false;
                                      } else {
                                        selectedItems.removeWhere(
                                          (element) =>
                                              element.tipoSanitarioViviendaId ==
                                              e.tipoSanitarioViviendaId,
                                        );
                                      }
                                      formState.didChange(selectedItems);

                                      if (!_showOtherTipoSanitario) {
                                        dimViviendaBloc.add(
                                            TiposSanitarioViviendaChanged(
                                                selectedItems));
                                      }
                                    });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    e.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    state.tiposSanitarioViviendaLoaded!.length -
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
                      if (_showOtherTipoSanitario)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc
                                .state.lstTiposSanitario?[0].otroTipoSanitario,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Otro', labelText: 'Cuál'),
                            validator: (value) {
                              if (value == null) {
                                return 'Campo requerido';
                              }
                              return null;
                            },
                            onChanged: (String? value) {
                              setState(() {
                                _otroTipoSanitario = value;
                              });

                              dimViviendaBloc
                                  .add(TiposSanitarioViviendaChanged([
                                LstTiposSanitario(
                                    tipoSanitarioViviendaId: 5,
                                    otroTipoSanitario: _otroTipoSanitario)
                              ]));
                            },
                          ),
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
          'Tipo de combustible que utiliza para cocinar',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TipoCombustibleViviendaCubit,
            TiposCombustibleViviendaState>(
          builder: (context, state) {
            if (state is TiposCombustibleViviendaLoaded) {
              return FormField<List<LstTiposCombustible>>(
                initialValue: dimViviendaBloc.state.lstTiposCombustible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 2) {
                    return 'Máximo dos opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTiposCombustible>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tiposCombustibleViviendaLoaded!.length,
                          (index) {
                            final e =
                                state.tiposCombustibleViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.tipoCombustibleViviendaId ==
                                          e.tipoCombustibleViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems =
                                        List<LstTiposCombustible>.from(
                                            formState.value ?? []);

                                    setState(() {
                                      if (e.tipoCombustibleViviendaId == 7) {
                                        selectedItems = [
                                          LstTiposCombustible(
                                              tipoCombustibleViviendaId:
                                                  e.tipoCombustibleViviendaId)
                                        ];
                                        _showOtherTipoCombustible = true;
                                      } else if (value == true) {
                                        selectedItems.removeWhere((element) =>
                                            element.tipoCombustibleViviendaId ==
                                            7);
                                        selectedItems.add(LstTiposCombustible(
                                            tipoCombustibleViviendaId:
                                                e.tipoCombustibleViviendaId));
                                        _showOtherTipoCombustible = false;
                                        _otroTipoCombustible = null;
                                      } else {
                                        selectedItems.removeWhere(
                                          (element) =>
                                              element
                                                  .tipoCombustibleViviendaId ==
                                              e.tipoCombustibleViviendaId,
                                        );
                                      }
                                      formState.didChange(selectedItems);

                                      if (!_showOtherTipoCombustible) {
                                        dimViviendaBloc.add(
                                            TiposCombustibleViviendaChanged(
                                                selectedItems));
                                      }
                                    });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    e.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    state.tiposCombustibleViviendaLoaded!
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
                      if (_showOtherTipoCombustible)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc.state
                                .lstTiposCombustible?[0].otroTipoCombustible,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Otro', labelText: 'Cuál'),
                            validator: (value) {
                              if (value == null) {
                                return 'Campo requerido';
                              }
                              return null;
                            },
                            onChanged: (String? value) {
                              setState(() {
                                _otroTipoCombustible = value;
                              });

                              dimViviendaBloc
                                  .add(TiposCombustibleViviendaChanged([
                                LstTiposCombustible(
                                    tipoCombustibleViviendaId: 7,
                                    otroTipoCombustible: _otroTipoCombustible)
                              ]));
                            },
                          ),
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
          'Factores de riesgo en el entorno de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<FactorRiesgoViviendaCubit, FactoresRiesgoViviendaState>(
          builder: (context, state) {
            if (state is FactoresRiesgoViviendaLoaded) {
              return FormField<List<LstFactoresRiesgo>>(
                initialValue: dimViviendaBloc.state.lstFactoresRiesgo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 3) {
                    return 'Máximo tres opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstFactoresRiesgo>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.factoresRiesgoViviendaLoaded!.length,
                          (index) {
                            final e =
                                state.factoresRiesgoViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.factorRiesgoViviendaId ==
                                          e.factorRiesgoViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems =
                                        List<LstFactoresRiesgo>.from(
                                            formState.value ?? []);
                                    if (e.factorRiesgoViviendaId == 7) {
                                      selectedItems = [
                                        LstFactoresRiesgo(
                                            factorRiesgoViviendaId:
                                                e.factorRiesgoViviendaId)
                                      ];
                                    } else if (value == true) {
                                      selectedItems.removeWhere((element) =>
                                          element.factorRiesgoViviendaId == 7);
                                      selectedItems.add(LstFactoresRiesgo(
                                          factorRiesgoViviendaId:
                                              e.factorRiesgoViviendaId));
                                    } else {
                                      selectedItems.removeWhere(
                                        (element) =>
                                            element.factorRiesgoViviendaId ==
                                            e.factorRiesgoViviendaId,
                                      );
                                    }
                                    formState.didChange(selectedItems);
                                    dimViviendaBloc.add(
                                        FactoresRiesgoViviendaChanged(
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
                                    state.factoresRiesgoViviendaLoaded!.length -
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
          'Presencia de animales en la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<PresenciaAnimalViviendaCubit,
            PresenciaAnimalesViviendaState>(
          builder: (context, state) {
            if (state is PresenciaAnimalesViviendaLoaded) {
              return FormField<List<LstPresenciaAnimal>>(
                initialValue: dimViviendaBloc.state.lstPresenciaAnimales,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 3) {
                    return 'Máximo tres opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstPresenciaAnimal>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.presenciaAnimalesViviendaLoaded!.length,
                          (index) {
                            final e =
                                state.presenciaAnimalesViviendaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.presenciaAnimalViviendaId ==
                                          e.presenciaAnimalViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems =
                                        List<LstPresenciaAnimal>.from(
                                            formState.value ?? []);
                                    if (value == true) {
                                      selectedItems.add(LstPresenciaAnimal(
                                          presenciaAnimalViviendaId:
                                              e.presenciaAnimalViviendaId));
                                    } else {
                                      selectedItems.removeWhere(
                                        (element) =>
                                            element.presenciaAnimalViviendaId ==
                                            e.presenciaAnimalViviendaId,
                                      );
                                    }
                                    formState.didChange(selectedItems);
                                    dimViviendaBloc.add(
                                        PresenciaAnimalesViviendaChanged(
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
                                    state.presenciaAnimalesViviendaLoaded!
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
    );
  }
}
