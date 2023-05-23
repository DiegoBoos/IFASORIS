import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_exports.dart';
import 'package:ifasoris/domain/usecases/iluminacion_vivienda/iluminacion_vivienda_exports.dart';
import 'package:ifasoris/domain/usecases/piso_vivienda_by_dpto/piso_vivienda_by_dpto_exports.dart';
import 'package:ifasoris/domain/usecases/techo_vivienda_by_dpto/techo_vivienda_by_dpto_exports.dart';
import 'package:ifasoris/domain/usecases/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_exports.dart';
import 'package:ifasoris/domain/usecases/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_exports.dart';
import 'package:ifasoris/ui/utils/input_decoration.dart';

import '../../../domain/usecases/dim_vivienda/dim_vivienda_exports.dart';
import '../../../domain/usecases/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_exports.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';

class DatosViviendaForm extends StatefulWidget {
  const DatosViviendaForm({super.key, this.dimVivienda});

  final DimViviendaEntity? dimVivienda;
  @override
  State<DatosViviendaForm> createState() => _DatosViviendaFormState();
}

class _DatosViviendaFormState extends State<DatosViviendaForm> {
  int? _tipoVivienda;
  //int? _dormitorioVivienda;
  int? _tenenciaVivienda;
  List<int> _selectedPisosVivienda = [];
  List<int> _selectedTechosVivienda = [];
  int? _ventilacionViviendaId;
  int? _iluminacionViviendaId;
  List<int> _selectedServiciosPublicosVivienda = [];
  List<int> _selectedTratamientosAguaVivienda = [];
  List<int> _selectedTiposSanitarioVivienda = [];
  List<int> _selectedTiposCombustibleVivienda = [];
  List<int> _selectedFactoresRiesgoVivienda = [];
  List<int> _selectedPresenciaAnimalesVivienda = [];

  bool _showOtherPisoVivienda = false;
  bool _showOtherTechoVivienda = false;
  bool _showOtherTratamientoAgua = false;
  bool _showOtherTipoSanitario = false;
  bool _showOtherTipoCombustible = false;

  String? _validatePisosVivienda() {
    if (_selectedPisosVivienda.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedPisosVivienda.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

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

    _tipoVivienda = widget.dimVivienda?.tipoViviendaId;
    //_dormitorioVivienda = widget.dimVivienda?.dormitorioViviendaId;
    _tenenciaVivienda = widget.dimVivienda?.tenenciaViviendaId;
    _selectedPisosVivienda = widget.dimVivienda?.pisosViviendaIds ?? [];
    _selectedTechosVivienda = widget.dimVivienda?.techosViviendaIds ?? [];
    _ventilacionViviendaId = widget.dimVivienda?.ventilacionViviendaId;
    _iluminacionViviendaId = widget.dimVivienda?.iluminacionViviendaId;
    _selectedServiciosPublicosVivienda =
        widget.dimVivienda?.serviciosPublicosViviendaIds ?? [];
    _selectedTratamientosAguaVivienda =
        widget.dimVivienda?.tratamientosAguaViviendaIds ?? [];
    _selectedTiposSanitarioVivienda =
        widget.dimVivienda?.tiposSanitarioViviendaIds ?? [];
    _selectedTiposCombustibleVivienda =
        widget.dimVivienda?.tiposCombustibleViviendaIds ?? [];
    _selectedFactoresRiesgoVivienda =
        widget.dimVivienda?.factoresRiesgoViviendaIds ?? [];
    _selectedPresenciaAnimalesVivienda =
        widget.dimVivienda?.presenciaAnimalesViviendaIds ?? [];
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
                autovalidateMode: AutovalidateMode.always,
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
                autovalidateMode: AutovalidateMode.always,
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedPisosVivienda,
                builder: (FormFieldState<List<int>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.pisosViviendaByDptoLoaded!.length, (index) {
                        final e = state.pisosViviendaByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedPisosVivienda
                                    .contains(e.pisoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.pisoViviendaId == 6) {
                                      _selectedPisosVivienda = [
                                        e.pisoViviendaId
                                      ];
                                      _showOtherPisoVivienda = true;
                                    } else if (value!) {
                                      _selectedPisosVivienda.remove(6);
                                      _selectedPisosVivienda
                                          .add(e.pisoViviendaId);
                                      _showOtherPisoVivienda = false;
                                    } else {
                                      _selectedPisosVivienda
                                          .remove(e.pisoViviendaId);
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
                                state.pisosViviendaByDptoLoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })
                            ..add(
                              _showOtherPisoVivienda
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        initialValue: '',
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          //TODO: guardar nuevo valor???
                                        },
                                      ),
                                    )
                                  : Container(),
                            )),
                      Text(
                        _validatePisosVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validatePisosVivienda(),
                onSaved: (List<int>? value) {
                  dimViviendaBloc.add(PisosViviendaChanged(value!));
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedTechosVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedTechosVivienda
                                    .contains(e.techoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.techoViviendaId == 6) {
                                      _selectedTechosVivienda = [
                                        e.techoViviendaId
                                      ];
                                      _showOtherTechoVivienda = true;
                                    } else if (value!) {
                                      _selectedTechosVivienda.remove(6);
                                      _selectedTechosVivienda
                                          .add(e.techoViviendaId);
                                      _showOtherTechoVivienda = false;
                                    } else {
                                      _selectedTechosVivienda
                                          .remove(e.techoViviendaId);
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
                      })
                            ..add(
                              _showOtherTechoVivienda
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        initialValue: '',
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          //TODO: guardar nuevo valor???
                                        },
                                      ),
                                    )
                                  : Container(),
                            )),
                      Text(
                        _validateTechosVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateTechosVivienda(),
                onSaved: (List<int>? value) {
                  dimViviendaBloc.add(TechosViviendaChanged(value!));
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
                autovalidateMode: AutovalidateMode.always,
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
        const Divider(),
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
                autovalidateMode: AutovalidateMode.always,
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
        ),
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedServiciosPublicosVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedServiciosPublicosVivienda
                                    .contains(e.servicioPublicoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.servicioPublicoViviendaId == 7) {
                                      _selectedServiciosPublicosVivienda = [
                                        e.servicioPublicoViviendaId
                                      ];
                                    } else if (value!) {
                                      _selectedServiciosPublicosVivienda
                                          .remove(7);
                                      _selectedServiciosPublicosVivienda
                                          .add(e.servicioPublicoViviendaId);
                                    } else {
                                      _selectedServiciosPublicosVivienda
                                          .remove(e.servicioPublicoViviendaId);
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
                    return 'Seleccione una opción';
                  }
                  return null;
                },
                onSaved: (List<int>? value) {
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedTratamientosAguaVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedTratamientosAguaVivienda
                                    .contains(e.tratamientoAguaViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.tratamientoAguaViviendaId == 5) {
                                      _selectedTratamientosAguaVivienda = [
                                        e.tratamientoAguaViviendaId
                                      ];
                                      _showOtherTratamientoAgua = true;
                                    } else if (value!) {
                                      _selectedTratamientosAguaVivienda
                                          .remove(5);
                                      _selectedTratamientosAguaVivienda
                                          .add(e.tratamientoAguaViviendaId);
                                      _showOtherTratamientoAgua = false;
                                    } else {
                                      _selectedTratamientosAguaVivienda
                                          .remove(e.tratamientoAguaViviendaId);
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
                      })
                            ..add(
                              _showOtherTratamientoAgua
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: TextFormField(
                                        initialValue: '',
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          //TODO: guardar nuevo valor???
                                        },
                                      ),
                                    )
                                  : Container(),
                            )),
                      Text(
                        _validateTratamientosAguaVivienda() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateTratamientosAguaVivienda(),
                onSaved: (List<int>? value) {
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedTiposSanitarioVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedTiposSanitarioVivienda
                                    .contains(e.tipoSanitarioViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.tipoSanitarioViviendaId == 6) {
                                      _selectedTiposSanitarioVivienda = [
                                        e.tipoSanitarioViviendaId
                                      ];
                                      _showOtherTipoSanitario = true;
                                    } else if (value!) {
                                      _selectedTiposSanitarioVivienda.remove(6);
                                      _selectedTiposSanitarioVivienda
                                          .add(e.tipoSanitarioViviendaId);
                                      _showOtherTipoSanitario = false;
                                    } else {
                                      _selectedTiposSanitarioVivienda
                                          .remove(e.tipoSanitarioViviendaId);
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
                                        initialValue: '',
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          //TODO: guardar nuevo valor???
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
                onSaved: (List<int>? value) {
                  dimViviendaBloc.add(TiposSanitarioViviendaChanged(value!));
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedTiposCombustibleVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedTiposCombustibleVivienda
                                    .contains(e.tipoCombustibleViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.tipoCombustibleViviendaId == 8) {
                                      _selectedTiposCombustibleVivienda = [
                                        e.tipoCombustibleViviendaId
                                      ];
                                      _showOtherTipoCombustible = true;
                                    } else if (value!) {
                                      _selectedTiposCombustibleVivienda
                                          .remove(8);
                                      _selectedTiposCombustibleVivienda
                                          .add(e.tipoCombustibleViviendaId);
                                      _showOtherTipoCombustible = false;
                                    } else {
                                      _selectedTiposCombustibleVivienda
                                          .remove(e.tipoCombustibleViviendaId);
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
                                        initialValue: '',
                                        decoration: CustomInputDecoration
                                            .inputDecoration(
                                                hintText: 'Otro',
                                                labelText: 'Cuál'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          //TODO: guardar nuevo valor???
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
                onSaved: (List<int>? value) {
                  dimViviendaBloc.add(TiposCombustibleViviendaChanged(value!));
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedFactoresRiesgoVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedFactoresRiesgoVivienda
                                    .contains(e.factorRiesgoViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      _selectedFactoresRiesgoVivienda
                                          .add(e.factorRiesgoViviendaId);
                                    } else {
                                      _selectedFactoresRiesgoVivienda
                                          .remove(e.factorRiesgoViviendaId);
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
                onSaved: (List<int>? value) {
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
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedPresenciaAnimalesVivienda,
                builder: (FormFieldState<List<int>> formstate) {
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
                                value: _selectedPresenciaAnimalesVivienda
                                    .contains(e.presenciaAnimalViviendaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      _selectedPresenciaAnimalesVivienda
                                          .add(e.presenciaAnimalViviendaId);
                                    } else {
                                      _selectedPresenciaAnimalesVivienda
                                          .remove(e.presenciaAnimalViviendaId);
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
                onSaved: (List<int>? value) {
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
