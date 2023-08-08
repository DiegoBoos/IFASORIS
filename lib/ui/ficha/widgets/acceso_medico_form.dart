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
        _nombresMedTrad.add(LstNombreMedTradicional(nombreMedTradicional: ''));
      }
    });
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
            return FormField(
              initialValue: _existeMedTradicionalComunidad,
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

                                      setState(() {
                                        _existeMedTradicionalComunidad =
                                            newValue!;
                                      });

                                      dimUbicacionBloc.add(
                                          ExisteMedTradicionalComunidadChanged(
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
                  return FormField<List<LstEspMedTradicional>>(
                    initialValue: dimUbicacionBloc.state.lstEspMedTradicional,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      } else if (value.length > 5) {
                        return 'Máximo cinco opciones.';
                      }
                      return null;
                    },
                    builder:
                        (FormFieldState<List<LstEspMedTradicional>> formState) {
                      return Column(
                        children: [
                          Wrap(
                            children: List<Widget>.generate(
                              state.especialidadesMedTradicionalLoaded!.length,
                              (index) {
                                final e = state
                                    .especialidadesMedTradicionalLoaded![index];
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: formState.value?.any((element) =>
                                              element.especialidadMedTradId ==
                                              e.especialidadMedTradId) ??
                                          false,
                                      onChanged: (bool? value) {
                                        var selectedItems =
                                            formState.value ?? [];
                                        if (value == true) {
                                          selectedItems.add(
                                              LstEspMedTradicional(
                                                  especialidadMedTradId:
                                                      e.especialidadMedTradId));
                                        } else {
                                          selectedItems.removeWhere(
                                            (element) =>
                                                element.especialidadMedTradId ==
                                                e.especialidadMedTradId,
                                          );
                                        }
                                        formState.didChange(selectedItems);
                                        dimUbicacionBloc.add(
                                            EspecialidadesMedTradChanged(
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
            const SizedBox(height: 20),
            BlocBuilder<TiempoTardaMedTradicionalCubit,
                TiemposTardaMedTradicionalState>(
              builder: (context, state) {
                if (state is TiemposTardaMedTradicionalLoaded) {
                  return DropdownButtonFormField<int>(
                    value: _tiempoTardaMedTradId,
                    items: state.tiemposTardaMedTradicionalLoaded!
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
                  return FormField<List<LstMediosMedTradicional>>(
                    initialValue:
                        dimUbicacionBloc.state.lstMediosMedTradicional,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      } else if (value.length > 3) {
                        return 'Máximo tres opciones.';
                      }
                      return null;
                    },
                    builder: (FormFieldState<List<LstMediosMedTradicional>>
                        formState) {
                      return Column(
                        children: [
                          Wrap(
                            children: List<Widget>.generate(
                              state.mediosUtilizaMedTradicionalLoaded!.length,
                              (index) {
                                final e = state
                                    .mediosUtilizaMedTradicionalLoaded![index];
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: formState.value?.any((element) =>
                                              element.medioUtilizaMedTradId ==
                                              e.medioUtilizaMedTradId) ??
                                          false,
                                      onChanged: (bool? value) {
                                        var selectedItems =
                                            formState.value ?? [];
                                        if (value == true) {
                                          selectedItems.add(
                                              LstMediosMedTradicional(
                                                  medioUtilizaMedTradId:
                                                      e.medioUtilizaMedTradId));
                                        } else {
                                          selectedItems.removeWhere(
                                            (element) =>
                                                element.medioUtilizaMedTradId ==
                                                e.medioUtilizaMedTradId,
                                          );
                                        }
                                        formState.didChange(selectedItems);
                                        dimUbicacionBloc.add(
                                            MediosUtilizaMedTradChanged(
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
                                        state.mediosUtilizaMedTradicionalLoaded!
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
                  return FormField<List<LstDificultadAccesoMedTradicional>>(
                    initialValue: dimUbicacionBloc
                        .state.lstDificultadAccesoMedTradicional,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione al menos una opción.';
                      } else if (value.length > 3) {
                        return 'Máximo tres opciones.';
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
                              state.dificultadesAccesoMedTradicionalLoaded!
                                  .length,
                              (index) {
                                final e = state
                                        .dificultadesAccesoMedTradicionalLoaded![
                                    index];
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: formState.value?.any((element) =>
                                              element
                                                  .dificultadAccesoMedTradId ==
                                              e.dificultadAccesoMedTradId) ??
                                          false,
                                      onChanged: (bool? value) {
                                        var selectedItems =
                                            formState.value ?? [];

                                        if (e.dificultadAccesoMedTradId == 5) {
                                          selectedItems = [
                                            LstDificultadAccesoMedTradicional(
                                                dificultadAccesoMedTradId:
                                                    e.dificultadAccesoMedTradId)
                                          ];
                                        } else if (value == true) {
                                          selectedItems.removeWhere((element) =>
                                              element
                                                  .dificultadAccesoMedTradId ==
                                              5);
                                          selectedItems.add(
                                              LstDificultadAccesoMedTradicional(
                                                  dificultadAccesoMedTradId: e
                                                      .dificultadAccesoMedTradId));
                                        } else {
                                          selectedItems.removeWhere(
                                            (element) =>
                                                element
                                                    .dificultadAccesoMedTradId ==
                                                e.dificultadAccesoMedTradId,
                                          );
                                        }
                                        formState.didChange(selectedItems);
                                        dimUbicacionBloc.add(
                                            DificultadesAccesoMedTradicionalChanged(
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
                                        state.dificultadesAccesoMedTradicionalLoaded!
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
                  return DropdownButtonFormField<int>(
                    value: _costoDesplazamientoMedTradicional,
                    items: state.costosDesplazamientoLoaded!
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
                        onSaved: (String? value) {
                          _nombresMedTrad[index].nombreMedTradicional = value!;
                          dimUbicacionBloc.add(
                              NombresMedTradicionalChanged(_nombresMedTrad));
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        _removeFormField(index);
                      },
                    ),
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
}
