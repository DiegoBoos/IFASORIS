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
import '../../../domain/usecases/piso_vivienda_by_dpto/piso_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
import '../../cubits/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_cubit.dart';
import '../../cubits/techo_vivienda_by_dpto/techo_vivienda_by_dpto_cubit.dart';
import '../../cubits/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_cubit.dart';
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
  List<LstTecho> _selectedTechosVivienda = [];
  int? _ventilacionViviendaId;
  /* int? _iluminacionViviendaId; */
  List<LstServPublico> _selectedServiciosPublicosVivienda = [];
  List<LstTmtoAgua> _selectedTratamientosAguaVivienda = [];
  List<LstTiposSanitario> _selectedTiposSanitarioVivienda = [];
  List<LstTiposCombustible> _selectedTiposCombustibleVivienda = [];
  List<LstFactoresRiesgo> _selectedFactoresRiesgoVivienda = [];
  List<LstPresenciaAnimal> _selectedPresenciaAnimalesVivienda = [];

  bool _showOtherTechoVivienda = false;
  String? _otroTipoTecho;
  bool _showOtherTipoSanitario = false;
  String? _otroTipoSanitario;
  bool _showOtherTipoCombustible = false;
  String? _otroTipoCombustible;
  bool _showOtherPresenciaAnimal = false;

  String? _validateTechosVivienda() {
    if (_selectedTechosVivienda.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedTechosVivienda.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateTratamientosAguaVivienda() {
    if (_selectedTratamientosAguaVivienda.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedTratamientosAguaVivienda.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateTiposSanitariosVivienda() {
    if (_selectedTiposSanitarioVivienda.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedTiposSanitarioVivienda.length > 2) {
      return 'Máximo dos opciones.';
    }
    return null;
  }

  String? _validateTiposCombustibleVivienda() {
    if (_selectedTiposCombustibleVivienda.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedTiposCombustibleVivienda.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _tipoVivienda = widget.dimVivienda?.tipoViviendaId;
      _tenenciaVivienda = widget.dimVivienda?.tenenciaViviendaId;
      _pisoViviendaId = widget.dimVivienda?.pisoViviendaId;
      _ventilacionViviendaId = widget.dimVivienda?.ventilacionViviendaId;
      /* _iluminacionViviendaId = widget.dimVivienda?.iluminacionViviendaId; */
    });
    getOptions();
  }

  Future<void> getOptions() async {
    final techoViviendaByDptoCubit = BlocProvider.of<TechoViviendaByDptoCubit>(
      context,
    );

    final servicioPublicoViviendaByDptoCubit =
        BlocProvider.of<ServicioPublicoViviendaByDptoCubit>(
      context,
    );

    final tratamientoAguaViviendaByDptoCubit =
        BlocProvider.of<TratamientoAguaViviendaByDptoCubit>(
      context,
    );
    final tipoSanitarioViviendaByDptoCubit =
        BlocProvider.of<TipoSanitarioViviendaByDptoCubit>(
      context,
    );
    final tipoCombustibleViviendaByDptoCubit =
        BlocProvider.of<TipoCombustibleViviendaByDptoCubit>(
      context,
    );
    final factorRiesgoViviendaByDptoCubit =
        BlocProvider.of<FactorRiesgoViviendaByDptoCubit>(
      context,
    );
    final presenciaAnimalViviendaByDptoCubit =
        BlocProvider.of<PresenciaAnimalViviendaByDptoCubit>(
      context,
    );

    _selectedTechosVivienda = await techoViviendaByDptoCubit
        .getTechosViviendaDB(widget.dimVivienda?.datoViviendaId);

    if (_selectedTechosVivienda.isNotEmpty &&
        _selectedTechosVivienda[0].otroTipoTecho != null) {
      _showOtherTechoVivienda = true;
    }

    _selectedServiciosPublicosVivienda =
        await servicioPublicoViviendaByDptoCubit
            .getServiciosPublicosViviendaDB(widget.dimVivienda?.datoViviendaId);

    _selectedTratamientosAguaVivienda = await tratamientoAguaViviendaByDptoCubit
        .getTratamientosAguaViviendaDB(widget.dimVivienda?.datoViviendaId);

    _selectedTiposSanitarioVivienda = await tipoSanitarioViviendaByDptoCubit
        .getTiposSanitarioViviendaDB(widget.dimVivienda?.datoViviendaId);

    if (_selectedTiposSanitarioVivienda.isNotEmpty &&
        _selectedTiposSanitarioVivienda[0].otroTipoSanitario != null) {
      _showOtherTipoSanitario = true;
    }

    _selectedTiposCombustibleVivienda = await tipoCombustibleViviendaByDptoCubit
        .getTiposCombustibleViviendaDB(widget.dimVivienda?.datoViviendaId);

    if (_selectedTiposCombustibleVivienda.isNotEmpty &&
        _selectedTiposCombustibleVivienda[0].otroTipoCombustible != null) {
      _showOtherTipoCombustible = true;
    }

    _selectedFactoresRiesgoVivienda = await factorRiesgoViviendaByDptoCubit
        .getFactoresRiesgoViviendaDB(widget.dimVivienda?.datoViviendaId);

    _selectedPresenciaAnimalesVivienda =
        await presenciaAnimalViviendaByDptoCubit
            .getPresenciasAnimalesViviendaDB(
                widget.dimVivienda?.datoViviendaId);
    setState(() {});
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
        BlocBuilder<TipoViviendaByDptoCubit, TiposViviendaByDptoState>(
          builder: (context, state) {
            if (state is TiposViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _tipoVivienda,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tiposViviendaByDptoLoaded!.length,
                          (index) {
                            final e = state.tiposViviendaByDptoLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _tipoVivienda == e.tipoViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _tipoVivienda =
                                          value! ? e.tipoViviendaId : null;
                                      formstate.didChange(_tipoVivienda);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.tiposViviendaByDptoLoaded!.length - 1)
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
                onSaved: (int? value) {
                  dimViviendaBloc.add(TipoViviendaChanged(value!));
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
        BlocBuilder<TenenciaViviendaByDptoCubit, TenenciasViviendaByDptoState>(
          builder: (context, state) {
            if (state is TenenciasViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _tenenciaVivienda,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.tenenciasViviendaByDptoLoaded!.length,
                          (index) {
                            final e =
                                state.tenenciasViviendaByDptoLoaded![index];
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
                                      formstate.didChange(_tenenciaVivienda);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.tenenciasViviendaByDptoLoaded!
                                            .length -
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
                onSaved: (int? value) {
                  dimViviendaBloc.add(TenenciaViviendaChanged(value!));
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
        BlocBuilder<PisoViviendaByDptoCubit, PisosViviendaByDptoState>(
          builder: (context, state) {
            if (state is PisosViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _pisoViviendaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.pisosViviendaByDptoLoaded!.length,
                          (index) {
                            final e = state.pisosViviendaByDptoLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _pisoViviendaId == e.pisoViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _pisoViviendaId =
                                          value! ? e.pisoViviendaId : null;
                                      formstate.didChange(_pisoViviendaId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.pisosViviendaByDptoLoaded!.length - 1)
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
                onSaved: (int? value) {
                  dimViviendaBloc.add(PisoViviendaChanged(value!));
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
        BlocBuilder<TechoViviendaByDptoCubit, TechosViviendaByDptoState>(
          builder: (context, state) {
            if (state is TechosViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedTechosVivienda,
                builder: (FormFieldState<List<LstTecho>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.techosViviendaByDptoLoaded!.length,
                              (index) {
                        final e = state.techosViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedTechosVivienda.any((element) =>
                                    element.techoViviendaId ==
                                    e.techoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.techoViviendaId == 6) {
                                      _selectedTechosVivienda = [
                                        LstTecho(
                                            techoViviendaId: e.techoViviendaId)
                                      ];
                                      _showOtherTechoVivienda = true;
                                    } else if (value!) {
                                      _selectedTechosVivienda.removeWhere(
                                          (element) =>
                                              element.techoViviendaId == 6);
                                      _selectedTechosVivienda.add(LstTecho(
                                          techoViviendaId: e.techoViviendaId));
                                      _showOtherTechoVivienda = false;
                                    } else {
                                      _selectedTechosVivienda.removeWhere(
                                        (element) =>
                                            element.techoViviendaId ==
                                            e.techoViviendaId,
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
                                state.techosViviendaByDptoLoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      if (_showOtherTechoVivienda)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue:
                                _selectedTechosVivienda[0].otroTipoTecho,
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
                            },
                          ),
                        ),
                      Text(
                        _validateTechosVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateTechosVivienda(),
                onSaved: (List<LstTecho>? value) {
                  if (_otroTipoTecho != null) {
                    final List<LstTecho> lstTecho = value!;
                    lstTecho[0].otroTipoTecho = _otroTipoTecho;
                    dimViviendaBloc.add(TechosViviendaChanged(lstTecho));
                  } else {
                    dimViviendaBloc.add(TechosViviendaChanged(value!));
                  }
                },
              );
            }
            return Container();
          },
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _ventilacionViviendaId = value!
                                          ? e.ventilacionViviendaId
                                          : null;
                                      formstate
                                          .didChange(_ventilacionViviendaId);
                                    });
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
                onSaved: (int? value) {
                  dimViviendaBloc.add(VentilacionViviendaChanged(value!));
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                onSaved: (int? value) {
                  dimViviendaBloc.add(IluminacionViviendaChanged(value!));
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
        BlocBuilder<ServicioPublicoViviendaByDptoCubit,
            ServiciosPublicosViviendaByDptoState>(
          builder: (context, state) {
            if (state is ServiciosPublicosViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedServiciosPublicosVivienda,
                builder: (FormFieldState<List<LstServPublico>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.serviciosPublicosViviendaByDptoLoaded!
                                  .length, (index) {
                        final e =
                            state.serviciosPublicosViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedServiciosPublicosVivienda.any(
                                    (element) =>
                                        element.servicioPublicoViviendaId ==
                                        e.servicioPublicoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.servicioPublicoViviendaId == 7) {
                                      _selectedServiciosPublicosVivienda = [
                                        LstServPublico(
                                            servicioPublicoViviendaId:
                                                e.servicioPublicoViviendaId)
                                      ];
                                    } else if (value!) {
                                      _selectedServiciosPublicosVivienda
                                          .removeWhere((element) =>
                                              element
                                                  .servicioPublicoViviendaId ==
                                              7);
                                      _selectedServiciosPublicosVivienda.add(
                                          LstServPublico(
                                              servicioPublicoViviendaId:
                                                  e.servicioPublicoViviendaId));
                                    } else {
                                      _selectedServiciosPublicosVivienda
                                          .removeWhere(
                                        (element) =>
                                            element.servicioPublicoViviendaId ==
                                            e.servicioPublicoViviendaId,
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
                                state.serviciosPublicosViviendaByDptoLoaded!
                                        .length -
                                    1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
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
                  if (value!.isEmpty) {
                    return 'Seleccione al menos una opción';
                  }
                  return null;
                },
                onSaved: (List<LstServPublico>? value) {
                  dimViviendaBloc.add(ServiciosPublicosViviendaChanged(value!));
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
        BlocBuilder<TratamientoAguaViviendaByDptoCubit,
            TratamientosAguaViviendaByDptoState>(
          builder: (context, state) {
            if (state is TratamientosAguaViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedTratamientosAguaVivienda,
                builder: (FormFieldState<List<LstTmtoAgua>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.tratamientosAguaViviendaByDptoLoaded!
                                  .length, (index) {
                        final e =
                            state.tratamientosAguaViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedTratamientosAguaVivienda.any(
                                    (element) =>
                                        element.tratamientoAguaViviendaId ==
                                        e.tratamientoAguaViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.tratamientoAguaViviendaId == 5) {
                                      _selectedTratamientosAguaVivienda = [
                                        LstTmtoAgua(
                                            tratamientoAguaViviendaId:
                                                e.tratamientoAguaViviendaId)
                                      ];
                                    } else if (value!) {
                                      _selectedTratamientosAguaVivienda
                                          .removeWhere((element) =>
                                              element
                                                  .tratamientoAguaViviendaId ==
                                              5);
                                      _selectedTratamientosAguaVivienda.add(
                                          LstTmtoAgua(
                                              tratamientoAguaViviendaId:
                                                  e.tratamientoAguaViviendaId));
                                    } else {
                                      _selectedTratamientosAguaVivienda
                                          .removeWhere(
                                        (element) =>
                                            element.tratamientoAguaViviendaId ==
                                            e.tratamientoAguaViviendaId,
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
                                state.tratamientosAguaViviendaByDptoLoaded!
                                        .length -
                                    1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      Text(
                        _validateTratamientosAguaVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateTratamientosAguaVivienda(),
                onSaved: (List<LstTmtoAgua>? value) {
                  dimViviendaBloc.add(TratamientoAguaViviendaChanged(value!));
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
        BlocBuilder<TipoSanitarioViviendaByDptoCubit,
            TiposSanitarioViviendaByDptoState>(
          builder: (context, state) {
            if (state is TiposSanitarioViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedTiposSanitarioVivienda,
                builder: (FormFieldState<List<LstTiposSanitario>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.tiposSanitarioViviendaByDptoLoaded!.length,
                              (index) {
                        final e =
                            state.tiposSanitarioViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedTiposSanitarioVivienda.any(
                                    (element) =>
                                        element.tipoSanitarioViviendaId ==
                                        e.tipoSanitarioViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.tipoSanitarioViviendaId == 2) {
                                      _selectedTiposSanitarioVivienda = [
                                        LstTiposSanitario(
                                            tipoSanitarioViviendaId:
                                                e.tipoSanitarioViviendaId)
                                      ];
                                      _showOtherTipoSanitario = false;
                                    }
                                    if (e.tipoSanitarioViviendaId == 5) {
                                      _selectedTiposSanitarioVivienda = [
                                        LstTiposSanitario(
                                            tipoSanitarioViviendaId:
                                                e.tipoSanitarioViviendaId)
                                      ];
                                      _showOtherTipoSanitario = true;
                                    } else if (value!) {
                                      _selectedTiposSanitarioVivienda
                                          .removeWhere((element) =>
                                              element.tipoSanitarioViviendaId ==
                                                  2 ||
                                              element.tipoSanitarioViviendaId ==
                                                  5);
                                      _selectedTiposSanitarioVivienda.add(
                                          LstTiposSanitario(
                                              tipoSanitarioViviendaId:
                                                  e.tipoSanitarioViviendaId));
                                      _showOtherTipoSanitario = false;
                                    } else {
                                      _selectedTiposSanitarioVivienda
                                          .removeWhere(
                                        (element) =>
                                            element.tipoSanitarioViviendaId ==
                                            e.tipoSanitarioViviendaId,
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
                                state.tiposSanitarioViviendaByDptoLoaded!
                                        .length -
                                    1)
                              const VerticalDivider(),
                          ],
                        );
                      })
                            ..add(
                              _showOtherTipoSanitario
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        initialValue:
                                            _selectedTiposSanitarioVivienda[0]
                                                .otroTipoSanitario,
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
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
                                        },
                                      ),
                                    )
                                  : Container(),
                            )),
                      Text(
                        _validateTiposSanitariosVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateTiposSanitariosVivienda(),
                onSaved: (List<LstTiposSanitario>? value) {
                  if (_otroTipoSanitario != null) {
                    final List<LstTiposSanitario> lstTiposSanitario = value!;
                    lstTiposSanitario[0].otroTipoSanitario = _otroTipoSanitario;
                    dimViviendaBloc
                        .add(TiposSanitarioViviendaChanged(lstTiposSanitario));
                  } else {
                    dimViviendaBloc.add(TiposSanitarioViviendaChanged(value!));
                  }
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
        BlocBuilder<TipoCombustibleViviendaByDptoCubit,
            TiposCombustibleViviendaByDptoState>(
          builder: (context, state) {
            if (state is TiposCombustibleViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedTiposCombustibleVivienda,
                builder: (FormFieldState<List<LstTiposCombustible>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.tiposCombustibleViviendaByDptoLoaded!
                                  .length, (index) {
                        final e =
                            state.tiposCombustibleViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedTiposCombustibleVivienda.any(
                                    (element) =>
                                        element.tipoCombustibleViviendaId ==
                                        e.tipoCombustibleViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.tipoCombustibleViviendaId == 7) {
                                      _selectedTiposCombustibleVivienda = [
                                        LstTiposCombustible(
                                            tipoCombustibleViviendaId:
                                                e.tipoCombustibleViviendaId)
                                      ];
                                      _showOtherTipoCombustible = true;
                                    } else if (value!) {
                                      _selectedTiposCombustibleVivienda
                                          .removeWhere((element) =>
                                              element
                                                  .tipoCombustibleViviendaId ==
                                              7);
                                      _selectedTiposCombustibleVivienda.add(
                                          LstTiposCombustible(
                                              tipoCombustibleViviendaId:
                                                  e.tipoCombustibleViviendaId));
                                      _showOtherTipoCombustible = false;
                                    } else {
                                      _selectedTiposCombustibleVivienda
                                          .removeWhere(
                                        (element) =>
                                            element.tipoCombustibleViviendaId ==
                                            e.tipoCombustibleViviendaId,
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
                                state.tiposCombustibleViviendaByDptoLoaded!
                                        .length -
                                    1)
                              const VerticalDivider(),
                          ],
                        );
                      })
                            ..add(
                              _showOtherTipoCombustible
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        initialValue:
                                            _selectedTiposCombustibleVivienda[0]
                                                .otroTipoCombustible,
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
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
                                        },
                                      ),
                                    )
                                  : Container(),
                            )),
                      Text(
                        _validateTiposCombustibleVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateTiposCombustibleVivienda(),
                onSaved: (List<LstTiposCombustible>? value) {
                  if (_otroTipoCombustible != null) {
                    final List<LstTiposCombustible> lstTiposCombustible =
                        value!;
                    lstTiposCombustible[0].otroTipoCombustible =
                        _otroTipoCombustible;
                    dimViviendaBloc.add(
                        TiposCombustibleViviendaChanged(lstTiposCombustible));
                  } else {
                    dimViviendaBloc
                        .add(TiposCombustibleViviendaChanged(value!));
                  }
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
        BlocBuilder<FactorRiesgoViviendaByDptoCubit,
            FactoresRiesgoViviendaByDptoState>(
          builder: (context, state) {
            if (state is FactoresRiesgoViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedFactoresRiesgoVivienda,
                builder: (FormFieldState<List<LstFactoresRiesgo>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.factoresRiesgoViviendaByDptoLoaded!.length,
                              (index) {
                        final e =
                            state.factoresRiesgoViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedFactoresRiesgoVivienda.any(
                                    (element) =>
                                        element.factorRiesgoViviendaId ==
                                        e.factorRiesgoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.factorRiesgoViviendaId == 7) {
                                      _selectedFactoresRiesgoVivienda = [
                                        LstFactoresRiesgo(
                                            factorRiesgoViviendaId:
                                                e.factorRiesgoViviendaId)
                                      ];
                                    } else if (value!) {
                                      _selectedFactoresRiesgoVivienda
                                          .removeWhere((element) =>
                                              element.factorRiesgoViviendaId ==
                                              7);
                                      _selectedFactoresRiesgoVivienda.add(
                                          LstFactoresRiesgo(
                                              factorRiesgoViviendaId:
                                                  e.factorRiesgoViviendaId));
                                    } else {
                                      _selectedFactoresRiesgoVivienda
                                          .removeWhere(
                                        (element) =>
                                            element.factorRiesgoViviendaId ==
                                            e.factorRiesgoViviendaId,
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
                                state.factoresRiesgoViviendaByDptoLoaded!
                                        .length -
                                    1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
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
                  if (value!.isEmpty) {
                    return 'Seleccione una opción';
                  }
                  return null;
                },
                onSaved: (List<LstFactoresRiesgo>? value) {
                  dimViviendaBloc.add(FactoresRiesgoViviendaChanged(value!));
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
        BlocBuilder<PresenciaAnimalViviendaByDptoCubit,
            PresenciaAnimalesViviendaByDptoState>(
          builder: (context, state) {
            if (state is PresenciaAnimalesViviendaByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedPresenciaAnimalesVivienda,
                builder: (FormFieldState<List<LstPresenciaAnimal>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.presenciaAnimalesViviendaByDptoLoaded!
                                  .length, (index) {
                        final e =
                            state.presenciaAnimalesViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedPresenciaAnimalesVivienda.any(
                                    (element) =>
                                        element.presenciaAnimalViviendaId ==
                                        e.presenciaAnimalViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    formstate.didChange(
                                        _selectedPresenciaAnimalesVivienda);
                                    if (e.presenciaAnimalViviendaId == 5) {
                                      _selectedPresenciaAnimalesVivienda = [
                                        LstPresenciaAnimal(
                                            presenciaAnimalViviendaId:
                                                e.presenciaAnimalViviendaId)
                                      ];
                                      _showOtherPresenciaAnimal = true;
                                    } else if (value!) {
                                      //TODO: falta opcion otro
                                      _selectedPresenciaAnimalesVivienda
                                          .removeWhere((element) =>
                                              element
                                                  .presenciaAnimalViviendaId ==
                                              5);
                                      _selectedPresenciaAnimalesVivienda.add(
                                          LstPresenciaAnimal(
                                              presenciaAnimalViviendaId:
                                                  e.presenciaAnimalViviendaId));
                                      _showOtherPresenciaAnimal = false;
                                    } else {
                                      _selectedPresenciaAnimalesVivienda
                                          .removeWhere(
                                        (element) =>
                                            element.presenciaAnimalViviendaId ==
                                            e.presenciaAnimalViviendaId,
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
                                state.presenciaAnimalesViviendaByDptoLoaded!
                                        .length -
                                    1)
                              const VerticalDivider(),
                          ],
                        );
                      })
                            ..add(
                              _showOtherPresenciaAnimal
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        initialValue: '',
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          dimViviendaBloc.add(
                                              PresenciaAnimalesViviendaChanged([
                                            LstPresenciaAnimal(
                                                otroPresenciaAnimal: value!)
                                          ]));
                                        },
                                      ),
                                    )
                                  : Container(),
                            )),
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
                  if (value!.isEmpty) {
                    return 'Seleccione una opción';
                  }
                  return null;
                },
                onSaved: (List<LstPresenciaAnimal>? value) {
                  dimViviendaBloc.add(PresenciaAnimalesViviendaChanged(value!));
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
