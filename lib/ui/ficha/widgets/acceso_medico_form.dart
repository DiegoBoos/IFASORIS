import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../../data/models/especialidad_med_tradicional_model.dart';
import '../../../data/models/medio_utiliza_med_tradicional_model.dart';
import '../../../data/models/nombre_med_tradicional_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional/especialidad_med_tradicional_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/validators/form_validators.dart';
import '../helpers/dificultades_acceso_med_trad_helper.dart';
import '../helpers/medios_utiliza_med_trad_helper.dart';

class AccesoMedicoForm extends StatefulWidget {
  const AccesoMedicoForm({super.key, this.dimUbicacion});

  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoMedicoForm> createState() => AccesoMedicoFormState();
}

class AccesoMedicoFormState extends State<AccesoMedicoForm> {
  int? _existeMedTradicionalComunidad;
  int? _tiempoTardaMedTradId;
  int? _costoDesplazamientoMedTradicional;
  List<LstNombreMedTradicional> _nombresMedTrad = [];

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

      _nombresMedTrad = widget.dimUbicacion?.lstNombreMedTradicional ?? [];

      if (_nombresMedTrad.isEmpty) {
        _nombresMedTrad = [LstNombreMedTradicional(nombreMedTradicional: '')];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);

    return Column(children: [
      const Divider(),
      const Text(
        'ACCESO AL MEDICO TRADICIONAL MAS CERCANO',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      const SizedBox(height: 20),
      const Text('Existe médico tradicional en la comunidad'),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _existeMedTradicionalComunidad,
              builder: (FormFieldState<int> formstate) => Column(
                children: [
                  Column(
                      children: opcionesSiNoLoaded
                          .map(
                            (e) => e.opcionId == 3
                                ? Container()
                                : RadioListTile(
                                    title: Text(e.descripcion),
                                    value: e.opcionId,
                                    groupValue: _existeMedTradicionalComunidad,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        dimUbicacionBloc.add(
                                            const EspecialidadesMedTradChanged(
                                                []));

                                        _tiempoTardaMedTradId = null;
                                        dimUbicacionBloc.add(
                                            const TiempoTardaMedTradChanged(0));

                                        dimUbicacionBloc.add(
                                            const MediosUtilizaMedTradChanged(
                                                []));

                                        dimUbicacionBloc.add(
                                            const DificultadesAccesoMedTradicionalChanged(
                                                []));

                                        _costoDesplazamientoMedTradicional =
                                            null;
                                        dimUbicacionBloc.add(
                                            const CostoDesplazamientoMedTradicionalChanged(
                                                0));

                                        setState(() => _nombresMedTrad = []);
                                        dimUbicacionBloc.add(
                                            const NombresMedTradicionalChanged(
                                                []));
                                      }

                                      if (_nombresMedTrad.isEmpty) {
                                        _nombresMedTrad.add(
                                            LstNombreMedTradicional(
                                                nombreMedTradicional: ''));
                                      }

                                      setState(() {
                                        _existeMedTradicionalComunidad =
                                            newValue!;
                                      });

                                      formstate.didChange(newValue);

                                      dimUbicacionBloc.add(
                                          ExisteMedTradicionalComunidadChanged(
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
            BlocBuilder<EspecialidadMedTradicionalCubit,
                EspecialidadesMedTradicionalState>(
              builder: (context, state) {
                if (state is EspecialidadesMedTradicionalLoaded) {
                  final especialidadesMedTradicionalLoaded =
                      state.especialidadesMedTradicionalLoaded!;

                  return FormField<List<LstEspMedTradicional>>(
                    initialValue: dimUbicacionBloc.state.lstEspMedTradicional,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      }
                      return null;
                    },
                    builder:
                        (FormFieldState<List<LstEspMedTradicional>> formState) {
                      return Column(
                        children: [
                          Wrap(
                            children: List<Widget>.generate(
                              especialidadesMedTradicionalLoaded.length,
                              (index) {
                                final especialidadMedTradicional = state
                                    .especialidadesMedTradicionalLoaded![index];

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
                                        setState(() {
                                          var selectedItems =
                                              List<LstEspMedTradicional>.from(
                                                  formState.value ?? []);
                                          if (value == true) {
                                            selectedItems.add(LstEspMedTradicional(
                                                especialidadMedTradId:
                                                    especialidadMedTradicional
                                                        .especialidadMedTradId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (e) =>
                                                  e.especialidadMedTradId ==
                                                  especialidadMedTradicional
                                                      .especialidadMedTradId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              EspecialidadesMedTradChanged(
                                                  selectedItems));
                                        });
                                      },
                                    ),
                                    Flexible(
                                      child: Text(
                                        especialidadMedTradicional.descripcion,
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
            const SizedBox(height: 20),
            BlocBuilder<TiempoTardaMedTradicionalCubit,
                TiemposTardaMedTradicionalState>(
              builder: (context, state) {
                if (state is TiemposTardaMedTradicionalLoaded) {
                  final tiemposTardaMedTradicionalLoaded =
                      state.tiemposTardaMedTradicionalLoaded!;

                  return DropdownButtonFormField<int>(
                    value: _tiempoTardaMedTradId,
                    items: tiemposTardaMedTradicionalLoaded
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
            BlocBuilder<MedioUtilizaMedTradicionalCubit,
                MediosUtilizaMedTradicionalState>(
              builder: (context, state) {
                if (state is MediosUtilizaMedTradicionalLoaded) {
                  final mediosUtilizaMedTradicionalLoaded =
                      state.mediosUtilizaMedTradicionalLoaded!;

                  return FormField<List<LstMediosMedTradicional>>(
                    initialValue:
                        dimUbicacionBloc.state.lstMediosMedTradicional,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      }
                      return null;
                    },
                    builder: (FormFieldState<List<LstMediosMedTradicional>>
                        formState) {
                      return Column(
                        children: [
                          Wrap(
                            children: List<Widget>.generate(
                              mediosUtilizaMedTradicionalLoaded.length,
                              (index) {
                                final medioUtilizaMedTrad = state
                                    .mediosUtilizaMedTradicionalLoaded![index];
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: formState.value?.any((e) =>
                                              e.medioUtilizaMedTradId ==
                                              medioUtilizaMedTrad
                                                  .medioUtilizaMedTradId) ??
                                          false,
                                      onChanged: (bool? value) {
                                        handleMedioUtilizaMedTradSelection(
                                            formState,
                                            context,
                                            value,
                                            medioUtilizaMedTrad
                                                .medioUtilizaMedTradId,
                                            dimUbicacionBloc);
                                      },
                                    ),
                                    Flexible(
                                      child: Text(
                                        medioUtilizaMedTrad.descripcion,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (index <
                                        mediosUtilizaMedTradicionalLoaded
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
              'Que dificultad de acceso tiene, para llegar donde el médico tradicional',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<DificultadAccesoMedTradicionalCubit,
                DificultadesAccesoMedTradicionalState>(
              builder: (context, state) {
                if (state is DificultadesAccesoMedTradicionalLoaded) {
                  final dificultadesAccesoMedTradicionalLoaded =
                      state.dificultadesAccesoMedTradicionalLoaded!;

                  int? optionId;

                  for (var e in dificultadesAccesoMedTradicionalLoaded) {
                    if (FormValidators.validateDescription(e.descripcion)) {
                      optionId = e.dificultadAccesoMedTradId;
                    }
                  }

                  return FormField<List<LstDificultadAccesoMedTradicional>>(
                    initialValue: dimUbicacionBloc
                        .state.lstDificultadAccesoMedTradicional,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      }
                      return null;
                    },
                    builder:
                        (FormFieldState<List<LstDificultadAccesoMedTradicional>>
                            formState) {
                      return Column(
                        children: [
                          Wrap(
                            children: List<Widget>.generate(
                              dificultadesAccesoMedTradicionalLoaded.length,
                              (index) {
                                final dificultadAccesoMedTradicional = state
                                        .dificultadesAccesoMedTradicionalLoaded![
                                    index];

                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: formState.value?.any((e) =>
                                              e.dificultadAccesoMedTradId ==
                                              dificultadAccesoMedTradicional
                                                  .dificultadAccesoMedTradId) ??
                                          false,
                                      onChanged: (bool? value) {
                                        handleDificultadAccesoMedTradSelection(
                                            formState,
                                            optionId,
                                            context,
                                            value,
                                            dificultadAccesoMedTradicional
                                                .dificultadAccesoMedTradId,
                                            dimUbicacionBloc);
                                      },
                                    ),
                                    Flexible(
                                      child: Text(
                                        dificultadAccesoMedTradicional
                                            .descripcion,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (index <
                                        dificultadesAccesoMedTradicionalLoaded
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
            const SizedBox(height: 20),
            BlocBuilder<CostoDesplazamientoCubit, CostosDesplazamientoState>(
              builder: (context, state) {
                if (state is CostosDesplazamientoLoaded) {
                  final costosDesplazamientoLoaded =
                      state.costosDesplazamientoLoaded!;

                  return DropdownButtonFormField<int>(
                    value: _costoDesplazamientoMedTradicional,
                    items: costosDesplazamientoLoaded
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
                        onChanged: (String? value) {
                          _nombresMedTrad[index].nombreMedTradicional = value!;
                          dimUbicacionBloc.add(
                              NombresMedTradicionalChanged(_nombresMedTrad));
                        },
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _removeFormField(index)),
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

  void _addFormField() {
    if (_nombresMedTrad.length < 5) {
      setState(() {
        _nombresMedTrad.add(LstNombreMedTradicional(nombreMedTradicional: ''));
      });
    } else {
      CustomSnackBar.showCustomDialog(
          context,
          'Límite excedido',
          'No puede agregar más de 5 campos.',
          () => Navigator.pop(context),
          false);
    }
  }

  void _removeFormField(int index) {
    if (_nombresMedTrad.length > 1) {
      setState(() {
        _nombresMedTrad.removeAt(index);
      });
    }
  }
}
