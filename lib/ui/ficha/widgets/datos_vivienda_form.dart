import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/factor_riesgo_vivienda_model.dart';
import '../../../data/models/piso_vivienda_model.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../../data/models/techo_vivienda_model.dart';
import '../../../data/models/tipo_combustible_vivienda_model.dart';
import '../../../data/models/tipo_sanitario_vivienda_model.dart';
import '../../../data/models/tratamiento_agua_vivienda_model.dart';
import '../../../domain/usecases/dim_vivienda/dim_vivienda_exports.dart';
import '../../../domain/usecases/factor_riesgo_vivienda/factor_riesgo_vivienda_exports.dart';
import '../../../domain/usecases/presencia_animal_vivienda/presencia_animal_vivienda_exports.dart';
import '../../../domain/usecases/servicio_publico_vivienda/servicio_publico_vivienda_exports.dart';
import '../../../domain/usecases/tenencia_vivienda/tenencia_vivienda_exports.dart';
import '../../../domain/usecases/tipo_sanitario_vivienda/tipo_sanitario_vivienda_exports.dart';
import '../../../domain/usecases/tipo_vivienda/tipo_vivienda_exports.dart';
import '../../../domain/usecases/tratamiento_agua_vivienda/tratamiento_agua_vivienda_exports.dart';
import '../../../domain/usecases/ventilacion_vivienda/ventilacion_vivienda_exports.dart';
import '../../cubits/cuarto_vivienda/cuarto_vivienda_cubit.dart';
import '../../cubits/iluminacion_vivienda/iluminacion_vivienda_cubit.dart';
import '../../cubits/piso_vivienda/piso_vivienda_cubit.dart';
import '../../cubits/techo_vivienda/techo_vivienda_cubit.dart';
import '../../cubits/tipo_combustible_vivienda/tipo_combustible_vivienda_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../helpers/servicios_publicos_helper.dart';

class DatosViviendaForm extends StatefulWidget {
  const DatosViviendaForm({super.key, required this.dimVivienda});

  final DimViviendaEntity dimVivienda;
  @override
  State<DatosViviendaForm> createState() => _DatosViviendaFormState();
}

class _DatosViviendaFormState extends State<DatosViviendaForm> {
  int? _tipoVivienda;
  int? _tenenciaVivienda;
  int? _ventilacionViviendaId;
  int? _iluminacionViviendaId;
  int? _nroCuartoViviendaId;

  bool _showOtroTechoVivienda = false;
  String? _otroTipoTecho;
  bool _showOtroTipoSanitario = false;
  String? _otroTipoSanitario;
  bool _showOtroTipoCombustible = false;
  String? _otroTipoCombustible;
  bool _showOtroPisoVivienda = false;
  String? _otroTipoPiso;
  bool _showOtroTratamientoAgua = false;
  String? _otroTratamientoAgua;
  bool _showOtroFactorRiesgo = false;
  String? _otroFactorRiesgo;
  bool _showOtroPresenciaAnimal = false;
  String? _otroPresenciaAnimal;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tipoVivienda = widget.dimVivienda.tipoViviendaId;
      _tenenciaVivienda = widget.dimVivienda.tenenciaViviendaId;
      _ventilacionViviendaId = widget.dimVivienda.ventilacionViviendaId;
      _iluminacionViviendaId = widget.dimVivienda.iluminacionViviendaId;
      _nroCuartoViviendaId = widget.dimVivienda.nroCuartosViviendaId;

      if (widget.dimVivienda.lstTecho != null &&
          widget.dimVivienda.lstTecho!.isNotEmpty &&
          widget.dimVivienda.lstTecho![0].otroTipoTecho != null) {
        _showOtroTechoVivienda = true;
      }

      if (widget.dimVivienda.lstTipoSanitario != null &&
          widget.dimVivienda.lstTipoSanitario!.isNotEmpty &&
          widget.dimVivienda.lstTipoSanitario![0].otroTipoSanitario != null) {
        _showOtroTipoSanitario = true;
      }

      if (widget.dimVivienda.lstTipoCombustible != null &&
          widget.dimVivienda.lstTipoCombustible!.isNotEmpty &&
          widget.dimVivienda.lstTipoCombustible![0].otroTipoCombustible !=
              null) {
        _showOtroTipoCombustible = true;
      }

      if (widget.dimVivienda.lstPiso != null &&
          widget.dimVivienda.lstPiso!.isNotEmpty &&
          widget.dimVivienda.lstPiso![0].otroTipoPiso != null) {
        _showOtroPisoVivienda = true;
      }

      if (widget.dimVivienda.lstTmtoAgua != null &&
          widget.dimVivienda.lstTmtoAgua!.isNotEmpty &&
          widget.dimVivienda.lstTmtoAgua![0].otroTratamientoAgua != null) {
        _showOtroTratamientoAgua = true;
      }

      if (widget.dimVivienda.lstFactorRiesgo != null &&
          widget.dimVivienda.lstFactorRiesgo!.isNotEmpty &&
          widget.dimVivienda.lstFactorRiesgo![0].otroFactorRiesgo != null) {
        _showOtroFactorRiesgo = true;
      }

      if (widget.dimVivienda.lstPresenciaAnimal != null &&
          widget.dimVivienda.lstPresenciaAnimal!.isNotEmpty &&
          widget.dimVivienda.lstPresenciaAnimal![0].otroPresenciaAnimal !=
              null) {
        _showOtroPresenciaAnimal = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          color: Theme.of(context).colorScheme.primary,
          child: const Text(
            'II. DATOS DE LA VIVIENDA',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              final tiposViviendaLoaded = state.tiposViviendaLoaded!;

              return FormField(
                initialValue: _tipoVivienda,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          tiposViviendaLoaded.length,
                          (index) {
                            final tipoVivienda = tiposViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _tipoVivienda ==
                                      tipoVivienda.tipoViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _tipoVivienda = value!
                                          ? tipoVivienda.tipoViviendaId
                                          : null;
                                    });
                                    dimViviendaBloc.add(
                                        TipoViviendaChanged(_tipoVivienda!));
                                    formstate.didChange(_tipoVivienda);
                                  },
                                ),
                                Text(tipoVivienda.descripcion),
                                if (index < tiposViviendaLoaded.length - 1)
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
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'Número de cuartos vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<NroCuartoViviendaCubit, NroCuartosViviendaState>(
          builder: (context, state) {
            if (state is NroCuartosViviendaLoaded) {
              final nroCuartosViviendaLoaded = state.nroCuartosViviendaLoaded!;

              return DropdownButtonFormField<int>(
                value: _nroCuartoViviendaId,
                items: nroCuartosViviendaLoaded
                    .map((nroCuartoVivienda) => DropdownMenuItem<int>(
                          value: nroCuartoVivienda.nroCuartoViviendaId,
                          child: Text(nroCuartoVivienda.descripcion),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Cuarto vivienda', border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _nroCuartoViviendaId = newValue;
                  });
                  dimViviendaBloc.add(NroCuartoViviendaChanged(newValue!));
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
          'Tenencia de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TenenciaViviendaCubit, TenenciasViviendaState>(
          builder: (context, state) {
            if (state is TenenciasViviendaLoaded) {
              final tenenciasViviendaLoaded = state.tenenciasViviendaLoaded!;

              return FormField(
                initialValue: _tenenciaVivienda,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          tenenciasViviendaLoaded.length,
                          (index) {
                            final e = tenenciasViviendaLoaded[index];
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
                                    dimViviendaBloc.add(TenenciaViviendaChanged(
                                        _tenenciaVivienda!));
                                    formstate.didChange(_tenenciaVivienda);
                                  },
                                ),
                                Text(e.descripcion),
                                if (index < tenenciasViviendaLoaded.length - 1)
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
              final pisosViviendaLoaded = state.pisosViviendaLoaded!;
              final otroId = pisosViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'Otro',
                      orElse: () => PisoViviendaModel(
                          pisoViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .pisoViviendaId;

              return FormField<List<LstPiso>>(
                initialValue: dimViviendaBloc.state.lstPiso,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstPiso>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          pisosViviendaLoaded.length,
                          (index) {
                            final pisoVivienda = pisosViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.pisoViviendaId ==
                                          pisoVivienda.pisoViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems = List<LstPiso>.from(
                                        formState.value ?? []);

                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 3 &&
                                            pisoVivienda.pisoViviendaId !=
                                                otroId)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo tres opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            if (pisoVivienda.pisoViviendaId ==
                                                otroId) {
                                              selectedItems = [
                                                LstPiso(
                                                    pisoViviendaId: pisoVivienda
                                                        .pisoViviendaId)
                                              ];
                                              _showOtroPisoVivienda = true;
                                            } else if (value == true) {
                                              selectedItems.removeWhere((e) =>
                                                  e.pisoViviendaId == otroId);
                                              selectedItems.add(LstPiso(
                                                  pisoViviendaId: pisoVivienda
                                                      .pisoViviendaId));
                                              _showOtroPisoVivienda = false;
                                              _otroTipoPiso = null;
                                            } else {
                                              selectedItems.removeWhere(
                                                (e) =>
                                                    e.pisoViviendaId ==
                                                    pisoVivienda.pisoViviendaId,
                                              );
                                            }
                                            formState.didChange(selectedItems);

                                            if (!_showOtroPisoVivienda) {
                                              dimViviendaBloc.add(
                                                  PisosViviendaChanged(
                                                      selectedItems));
                                            }
                                          });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    pisoVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index < pisosViviendaLoaded.length - 1)
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
                      if (_showOtroPisoVivienda)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue:
                                dimViviendaBloc.state.lstPiso?[0].otroTipoPiso,
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
                                _otroTipoPiso = value;
                              });

                              dimViviendaBloc.add(PisosViviendaChanged([
                                LstPiso(
                                    pisoViviendaId: otroId,
                                    otroTipoPiso: _otroTipoPiso)
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
          'Techo de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TechoViviendaCubit, TechosViviendaState>(
          builder: (context, state) {
            if (state is TechosViviendaLoaded) {
              final techosViviendaLoaded = state.techosViviendaLoaded!;
              final otroId = techosViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'Otro',
                      orElse: () => TechoViviendaModel(
                          techoViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .techoViviendaId;

              return FormField<List<LstTecho>>(
                initialValue: dimViviendaBloc.state.lstTecho,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTecho>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          techosViviendaLoaded.length,
                          (index) {
                            final techoVivienda = techosViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.techoViviendaId ==
                                          techoVivienda.techoViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 3 &&
                                            techoVivienda.techoViviendaId !=
                                                otroId)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo tres opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            var selectedItems =
                                                List<LstTecho>.from(
                                                    formState.value ?? []);

                                            if (techoVivienda.techoViviendaId ==
                                                otroId) {
                                              selectedItems = [
                                                LstTecho(
                                                    techoViviendaId:
                                                        techoVivienda
                                                            .techoViviendaId)
                                              ];
                                              _showOtroTechoVivienda = true;
                                            } else if (value == true) {
                                              selectedItems.removeWhere((e) =>
                                                  e.techoViviendaId == otroId);
                                              selectedItems.add(LstTecho(
                                                  techoViviendaId: techoVivienda
                                                      .techoViviendaId));
                                              _showOtroTechoVivienda = false;
                                              _otroTipoTecho = null;
                                            } else {
                                              selectedItems.removeWhere(
                                                (e) =>
                                                    e.techoViviendaId ==
                                                    techoVivienda
                                                        .techoViviendaId,
                                              );
                                            }

                                            if (!_showOtroTechoVivienda) {
                                              dimViviendaBloc.add(
                                                  TechosViviendaChanged(
                                                      selectedItems));
                                            }
                                            formState.didChange(selectedItems);
                                          });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    techoVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index < techosViviendaLoaded.length - 1)
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
                      if (_showOtroTechoVivienda)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc
                                .state.lstTecho?[0].otroTipoTecho,
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
                                LstTecho(
                                    techoViviendaId: otroId,
                                    otroTipoTecho: _otroTipoTecho)
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
          'Ventilación',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<VentilacionViviendaCubit, VentilacionesViviendaState>(
          builder: (context, state) {
            if (state is VentilacionesViviendaLoaded) {
              final ventilacionesViviendaLoaded =
                  state.ventilacionesViviendaLoaded!;

              return FormField(
                initialValue: _ventilacionViviendaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          ventilacionesViviendaLoaded.length,
                          (index) {
                            final ventilacionVivienda =
                                ventilacionesViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _ventilacionViviendaId ==
                                      ventilacionVivienda.ventilacionViviendaId,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _ventilacionViviendaId = newValue!
                                          ? ventilacionVivienda
                                              .ventilacionViviendaId
                                          : null;
                                    });
                                    dimViviendaBloc.add(
                                        VentilacionViviendaChanged(
                                            _ventilacionViviendaId!));

                                    formstate.didChange(_ventilacionViviendaId);
                                  },
                                ),
                                Text(ventilacionVivienda.descripcion),
                                if (index <
                                    ventilacionesViviendaLoaded.length - 1)
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
              final iluminacionesViviendaLoaded =
                  state.iluminacionesViviendaLoaded!;

              return FormField(
                initialValue: _iluminacionViviendaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          iluminacionesViviendaLoaded.length,
                          (index) {
                            final iluminacionVivienda =
                                iluminacionesViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _iluminacionViviendaId ==
                                      iluminacionVivienda.iluminacionViviendaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _iluminacionViviendaId = value!
                                          ? iluminacionVivienda
                                              .iluminacionViviendaId
                                          : null;
                                    });
                                    formstate.didChange(_iluminacionViviendaId);
                                    dimViviendaBloc.add(
                                        IluminacionViviendaChanged(
                                            _iluminacionViviendaId!));
                                  },
                                ),
                                Text(iluminacionVivienda.descripcion),
                                if (index <
                                    iluminacionesViviendaLoaded.length - 1)
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
        BlocBuilder<ServicioPublicoViviendaCubit,
            ServiciosPublicosViviendaState>(
          builder: (context, state) {
            if (state is ServiciosPublicosViviendaLoaded) {
              final serviciosPublicosViviendaLoaded =
                  state.serviciosPublicosViviendaLoaded!;
              int? ningunoId;

              for (var e in serviciosPublicosViviendaLoaded) {
                if (e.descripcion == 'Ninguno') {
                  ningunoId = e.servicioPublicoViviendaId;
                }
              }

              return FormField<List<LstServPublico>>(
                initialValue: dimViviendaBloc.state.lstServPublico,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstServPublico>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          serviciosPublicosViviendaLoaded.length,
                          (index) {
                            final servicioPublicoVivienda =
                                serviciosPublicosViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.servicioPublicoViviendaId ==
                                          servicioPublicoVivienda
                                              .servicioPublicoViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    handleServiciosPublicosSelection(
                                        formState,
                                        ningunoId,
                                        context,
                                        value,
                                        servicioPublicoVivienda
                                            .servicioPublicoViviendaId,
                                        dimViviendaBloc);
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    servicioPublicoVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    serviciosPublicosViviendaLoaded.length - 1)
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
              final tratamientosAguaViviendaLoaded =
                  state.tratamientosAguaViviendaLoaded!;

              final otroId = tratamientosAguaViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'Otro',
                      orElse: () => TratamientoAguaViviendaModel(
                          tratamientoAguaViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .tratamientoAguaViviendaId;

              return FormField<List<LstTmtoAgua>>(
                initialValue: dimViviendaBloc.state.lstTmtoAgua,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTmtoAgua>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          tratamientosAguaViviendaLoaded.length,
                          (index) {
                            final tratamientoAguaVivienda =
                                tratamientosAguaViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.tratamientoAguaViviendaId ==
                                          tratamientoAguaVivienda
                                              .tratamientoAguaViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 3 &&
                                            tratamientoAguaVivienda
                                                    .tratamientoAguaViviendaId !=
                                                otroId)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo tres opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            var selectedItems =
                                                List<LstTmtoAgua>.from(
                                                    formState.value ?? []);
                                            if (tratamientoAguaVivienda
                                                    .tratamientoAguaViviendaId ==
                                                otroId) {
                                              selectedItems = [
                                                LstTmtoAgua(
                                                    tratamientoAguaViviendaId:
                                                        tratamientoAguaVivienda
                                                            .tratamientoAguaViviendaId)
                                              ];
                                              _showOtroTratamientoAgua = true;
                                            } else if (value == true) {
                                              selectedItems.removeWhere((e) =>
                                                  e.tratamientoAguaViviendaId ==
                                                  otroId);
                                              selectedItems.add(LstTmtoAgua(
                                                  tratamientoAguaViviendaId:
                                                      tratamientoAguaVivienda
                                                          .tratamientoAguaViviendaId));
                                              _showOtroTratamientoAgua = false;
                                              _otroTratamientoAgua = null;
                                            } else {
                                              selectedItems.removeWhere(
                                                (e) =>
                                                    e.tratamientoAguaViviendaId ==
                                                    tratamientoAguaVivienda
                                                        .tratamientoAguaViviendaId,
                                              );
                                            }
                                            formState.didChange(selectedItems);

                                            if (!_showOtroTratamientoAgua) {
                                              dimViviendaBloc.add(
                                                  TratamientosAguaViviendaChanged(
                                                      selectedItems));
                                            }
                                          });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    tratamientoAguaVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    tratamientosAguaViviendaLoaded.length - 1)
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
                      if (_showOtroTratamientoAgua)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc
                                .state.lstTmtoAgua?[0].otroTratamientoAgua,
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
                                _otroTratamientoAgua = value;
                              });

                              dimViviendaBloc
                                  .add(TratamientosAguaViviendaChanged([
                                LstTmtoAgua(
                                    tratamientoAguaViviendaId: otroId,
                                    otroTratamientoAgua: _otroTratamientoAgua)
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
          'Tipo de sanitario',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<TipoSanitarioViviendaCubit, TiposSanitarioViviendaState>(
          builder: (context, state) {
            if (state is TiposSanitarioViviendaLoaded) {
              final tiposSanitarioViviendaLoaded =
                  state.tiposSanitarioViviendaLoaded!;
              final noTieneId = tiposSanitarioViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'No tiene',
                      orElse: () => TipoSanitarioViviendaModel(
                          tipoSanitarioViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .tipoSanitarioViviendaId;

              final otroId = tiposSanitarioViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'Otro',
                      orElse: () => TipoSanitarioViviendaModel(
                          tipoSanitarioViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .tipoSanitarioViviendaId;

              return FormField<List<LstTipoSanitario>>(
                initialValue: dimViviendaBloc.state.lstTipoSanitario,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTipoSanitario>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          tiposSanitarioViviendaLoaded.length,
                          (index) {
                            final tipoSanitarioVivienda =
                                tiposSanitarioViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.tipoSanitarioViviendaId ==
                                          tipoSanitarioVivienda
                                              .tipoSanitarioViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 2 &&
                                            tipoSanitarioVivienda
                                                    .tipoSanitarioViviendaId !=
                                                noTieneId &&
                                            tipoSanitarioVivienda
                                                    .tipoSanitarioViviendaId !=
                                                otroId)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo dos opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            var selectedItems =
                                                List<LstTipoSanitario>.from(
                                                    formState.value ?? []);

                                            if (tipoSanitarioVivienda
                                                    .tipoSanitarioViviendaId ==
                                                noTieneId) {
                                              selectedItems = [
                                                LstTipoSanitario(
                                                    tipoSanitarioViviendaId:
                                                        tipoSanitarioVivienda
                                                            .tipoSanitarioViviendaId)
                                              ];
                                              _showOtroTipoSanitario = false;
                                              _otroTipoSanitario = null;
                                            } else if (tipoSanitarioVivienda
                                                    .tipoSanitarioViviendaId ==
                                                otroId) {
                                              selectedItems = [
                                                LstTipoSanitario(
                                                    tipoSanitarioViviendaId:
                                                        tipoSanitarioVivienda
                                                            .tipoSanitarioViviendaId)
                                              ];
                                              _showOtroTipoSanitario = true;
                                            } else if (value == true) {
                                              selectedItems.removeWhere((e) =>
                                                  e.tipoSanitarioViviendaId ==
                                                      noTieneId ||
                                                  e.tipoSanitarioViviendaId ==
                                                      otroId);
                                              selectedItems.add(LstTipoSanitario(
                                                  tipoSanitarioViviendaId:
                                                      tipoSanitarioVivienda
                                                          .tipoSanitarioViviendaId));
                                              _showOtroTipoSanitario = false;
                                            } else {
                                              selectedItems.removeWhere(
                                                (e) =>
                                                    e.tipoSanitarioViviendaId ==
                                                    tipoSanitarioVivienda
                                                        .tipoSanitarioViviendaId,
                                              );
                                            }
                                            formState.didChange(selectedItems);

                                            if (!_showOtroTipoSanitario) {
                                              dimViviendaBloc.add(
                                                  TiposSanitarioViviendaChanged(
                                                      selectedItems));
                                            }
                                          });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    tipoSanitarioVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    tiposSanitarioViviendaLoaded.length - 1)
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
                      if (_showOtroTipoSanitario)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc
                                .state.lstTipoSanitario?[0].otroTipoSanitario,
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
                                _otroTipoSanitario = value;
                              });

                              dimViviendaBloc
                                  .add(TiposSanitarioViviendaChanged([
                                LstTipoSanitario(
                                    tipoSanitarioViviendaId: otroId,
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
              final tiposCombustibleViviendaLoaded =
                  state.tiposCombustibleViviendaLoaded!;

              final otroId = tiposCombustibleViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'otro',
                      orElse: () => TipoCombustibleViviendaModel(
                          tipoCombustibleViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .tipoCombustibleViviendaId;

              return FormField<List<LstTipoCombustible>>(
                initialValue: dimViviendaBloc.state.lstTipoCombustible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstTipoCombustible>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          tiposCombustibleViviendaLoaded.length,
                          (index) {
                            final tipoCombustibleVivienda =
                                tiposCombustibleViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.tipoCombustibleViviendaId ==
                                          tipoCombustibleVivienda
                                              .tipoCombustibleViviendaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 3 &&
                                            tipoCombustibleVivienda
                                                    .tipoCombustibleViviendaId !=
                                                otroId)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo tres opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            var selectedItems =
                                                List<LstTipoCombustible>.from(
                                                    formState.value ?? []);

                                            if (tipoCombustibleVivienda
                                                    .tipoCombustibleViviendaId ==
                                                otroId) {
                                              selectedItems = [
                                                LstTipoCombustible(
                                                    tipoCombustibleViviendaId:
                                                        tipoCombustibleVivienda
                                                            .tipoCombustibleViviendaId)
                                              ];
                                              _showOtroTipoCombustible = true;
                                            } else if (value == true) {
                                              selectedItems.removeWhere((e) =>
                                                  e.tipoCombustibleViviendaId ==
                                                  otroId);
                                              selectedItems.add(LstTipoCombustible(
                                                  tipoCombustibleViviendaId:
                                                      tipoCombustibleVivienda
                                                          .tipoCombustibleViviendaId));
                                              _showOtroTipoCombustible = false;
                                              _otroTipoCombustible = null;
                                            } else {
                                              selectedItems.removeWhere(
                                                (e) =>
                                                    e.tipoCombustibleViviendaId ==
                                                    tipoCombustibleVivienda
                                                        .tipoCombustibleViviendaId,
                                              );
                                            }
                                            formState.didChange(selectedItems);

                                            if (!_showOtroTipoCombustible) {
                                              dimViviendaBloc.add(
                                                  TiposCombustibleViviendaChanged(
                                                      selectedItems));
                                            }
                                          });
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    tipoCombustibleVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    tiposCombustibleViviendaLoaded.length - 1)
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
                      if (_showOtroTipoCombustible)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc.state
                                .lstTipoCombustible?[0].otroTipoCombustible,
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
                                _otroTipoCombustible = value;
                              });

                              dimViviendaBloc
                                  .add(TiposCombustibleViviendaChanged([
                                LstTipoCombustible(
                                    tipoCombustibleViviendaId: otroId,
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
              final factoresRiesgoViviendaLoaded =
                  state.factoresRiesgoViviendaLoaded!;

              final otrosId = factoresRiesgoViviendaLoaded
                  .firstWhere((e) => e.descripcion == 'Otros',
                      orElse: () => FactorRiesgoViviendaModel(
                          factorRiesgoViviendaId: 0,
                          descripcion: '',
                          departamentoIde: 0))
                  .factorRiesgoViviendaId;

              return FormField<List<LstFactorRiesgo>>(
                initialValue: dimViviendaBloc.state.lstFactorRiesgo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstFactorRiesgo>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          factoresRiesgoViviendaLoaded.length,
                          (index) {
                            final factorRiesgoVivienda =
                                factoresRiesgoViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                    value: formState.value?.any((e) =>
                                            e.factorRiesgoViviendaId ==
                                            factorRiesgoVivienda
                                                .factorRiesgoViviendaId) ??
                                        false,
                                    onChanged: (bool? value) {
                                      (value! &&
                                              formState.value != null &&
                                              formState.value!.length >= 3 &&
                                              factorRiesgoVivienda
                                                      .factorRiesgoViviendaId !=
                                                  otrosId)
                                          ? CustomSnackBar.showCustomDialog(
                                              context,
                                              'Error',
                                              'Máximo tres opciones',
                                              () => Navigator.pop(context),
                                              false)
                                          : setState(
                                              () {
                                                var selectedItems =
                                                    List<LstFactorRiesgo>.from(
                                                        formState.value ?? []);
                                                if (factorRiesgoVivienda
                                                        .factorRiesgoViviendaId ==
                                                    otrosId) {
                                                  selectedItems = [
                                                    LstFactorRiesgo(
                                                        factorRiesgoViviendaId:
                                                            factorRiesgoVivienda
                                                                .factorRiesgoViviendaId)
                                                  ];
                                                  _showOtroFactorRiesgo = true;
                                                } else if (value == true) {
                                                  selectedItems.removeWhere((e) =>
                                                      e.factorRiesgoViviendaId ==
                                                      otrosId);
                                                  selectedItems.add(LstFactorRiesgo(
                                                      factorRiesgoViviendaId:
                                                          factorRiesgoVivienda
                                                              .factorRiesgoViviendaId));
                                                  _showOtroFactorRiesgo = false;
                                                  _otroFactorRiesgo = null;
                                                } else {
                                                  selectedItems.removeWhere(
                                                    (e) =>
                                                        e.factorRiesgoViviendaId ==
                                                        factorRiesgoVivienda
                                                            .factorRiesgoViviendaId,
                                                  );
                                                }
                                                formState
                                                    .didChange(selectedItems);

                                                if (!_showOtroFactorRiesgo) {
                                                  dimViviendaBloc.add(
                                                      FactoresRiesgoViviendaChanged(
                                                          selectedItems));
                                                }
                                              },
                                            );
                                    }),
                                Flexible(
                                  child: Text(
                                    factorRiesgoVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    factoresRiesgoViviendaLoaded.length - 1)
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
                      if (_showOtroFactorRiesgo)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc
                                .state.lstFactorRiesgo?[0].otroFactorRiesgo,
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
                                _otroFactorRiesgo = value;
                              });

                              dimViviendaBloc
                                  .add(FactoresRiesgoViviendaChanged([
                                LstFactorRiesgo(
                                    factorRiesgoViviendaId: otrosId,
                                    otroFactorRiesgo: _otroFactorRiesgo)
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
          'Presencia de animales en la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<PresenciaAnimalViviendaCubit,
            PresenciaAnimalesViviendaState>(
          builder: (context, state) {
            if (state is PresenciaAnimalesViviendaLoaded) {
              final presenciaAnimalesViviendaLoaded =
                  state.presenciaAnimalesViviendaLoaded!;

              final otrosId = presenciaAnimalesViviendaLoaded
                  .firstWhere(
                    (e) => e.descripcion == 'Otros',
                    orElse: () => PresenciaAnimalViviendaModel(
                        presenciaAnimalViviendaId: 0,
                        descripcion: '',
                        departamentoIde: 0),
                  )
                  .presenciaAnimalViviendaId;

              return FormField<List<LstPresenciaAnimal>>(
                initialValue: dimViviendaBloc.state.lstPresenciaAnimal,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstPresenciaAnimal>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          presenciaAnimalesViviendaLoaded.length,
                          (index) {
                            final presenciaAnimalVivienda =
                                presenciaAnimalesViviendaLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                    value: formState.value?.any((e) =>
                                            e.presenciaAnimalViviendaId ==
                                            presenciaAnimalVivienda
                                                .presenciaAnimalViviendaId) ??
                                        false,
                                    onChanged: (bool? value) {
                                      (value! &&
                                              formState.value != null &&
                                              formState.value!.length >= 3 &&
                                              presenciaAnimalVivienda
                                                      .presenciaAnimalViviendaId !=
                                                  otrosId)
                                          ? CustomSnackBar.showCustomDialog(
                                              context,
                                              'Error',
                                              'Máximo tres opciones',
                                              () => Navigator.pop(context),
                                              false)
                                          : setState(
                                              () {
                                                var selectedItems = List<
                                                        LstPresenciaAnimal>.from(
                                                    formState.value ?? []);
                                                if (presenciaAnimalVivienda
                                                        .presenciaAnimalViviendaId ==
                                                    otrosId) {
                                                  selectedItems = [
                                                    LstPresenciaAnimal(
                                                        presenciaAnimalViviendaId:
                                                            presenciaAnimalVivienda
                                                                .presenciaAnimalViviendaId)
                                                  ];
                                                  _showOtroPresenciaAnimal =
                                                      true;
                                                } else if (value == true) {
                                                  selectedItems.removeWhere((e) =>
                                                      e.presenciaAnimalViviendaId ==
                                                      otrosId);
                                                  selectedItems.add(LstPresenciaAnimal(
                                                      presenciaAnimalViviendaId:
                                                          presenciaAnimalVivienda
                                                              .presenciaAnimalViviendaId));
                                                  _showOtroPresenciaAnimal =
                                                      false;
                                                  _otroPresenciaAnimal = null;
                                                } else {
                                                  selectedItems.removeWhere(
                                                    (e) =>
                                                        e.presenciaAnimalViviendaId ==
                                                        presenciaAnimalVivienda
                                                            .presenciaAnimalViviendaId,
                                                  );
                                                }
                                                formState
                                                    .didChange(selectedItems);

                                                if (!_showOtroPresenciaAnimal) {
                                                  dimViviendaBloc.add(
                                                      PresenciaAnimalesViviendaChanged(
                                                          selectedItems));
                                                }
                                              },
                                            );
                                    }),
                                Flexible(
                                  child: Text(
                                    presenciaAnimalVivienda.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    presenciaAnimalesViviendaLoaded.length - 1)
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
                      if (_showOtroPresenciaAnimal)
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            initialValue: dimViviendaBloc.state
                                .lstPresenciaAnimal?[0].otroPresenciaAnimal,
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
                                _otroPresenciaAnimal = value;
                              });

                              dimViviendaBloc
                                  .add(PresenciaAnimalesViviendaChanged([
                                LstPresenciaAnimal(
                                    presenciaAnimalViviendaId: otrosId,
                                    otroPresenciaAnimal: _otroPresenciaAnimal)
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
      ],
    );
  }
}
