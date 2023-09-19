import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/dificultad_acceso_ca_model.dart';
import '../../../data/models/medio_utiliza_ca_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../utils/custom_snack_bar.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({super.key, this.dimUbicacion});
  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoCAForm> createState() => AccesoCAFormState();
}

class AccesoCAFormState extends State<AccesoCAForm> {
  int? _tiempoTardaId;
  int? _costoDesplazamientoId;
  int? _produccionMinera;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tiempoTardaId = widget.dimUbicacion?.tiempoTardaId;
      _costoDesplazamientoId = widget.dimUbicacion?.costoDesplazamientoId;
      _produccionMinera = widget.dimUbicacion?.produccionMinera;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);

    return Column(
      children: [
        const Divider(),
        const Text(
          'ACCESO AL CENTRO DE ATENCION DE SALUD MAS CERCANO',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        const SizedBox(height: 20),
        BlocBuilder<TiempoTardaCACubit, TiemposTardaCAState>(
          builder: (context, state) {
            if (state is TiemposTardaCALoaded) {
              return DropdownButtonFormField<int>(
                value: _tiempoTardaId,
                items: state.tiemposTardaCALoaded!
                    .map(
                      (tiempoTardaCA) => DropdownMenuItem<int>(
                        value: tiempoTardaCA.tiempoTardaId,
                        child: Text(tiempoTardaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al centro de atención en Salud',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _tiempoTardaId = newValue;
                  });
                  dimUbicacionBloc.add(TiempoTardaChanged(newValue!));
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
          'Medios que utiliza para el desplazamiento al centro de atención',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<MedioUtilizaCACubit, MediosUtilizaCAState>(
          builder: (context, state) {
            if (state is MediosUtilizaCALoaded) {
              return FormField<List<LstMediosUtilizaCA>>(
                initialValue: dimUbicacionBloc.state.lstMediosUtilizaCA,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstMediosUtilizaCA>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.mediosUtilizaCALoaded!.length,
                          (index) {
                            final e = state.mediosUtilizaCALoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.medioUtilizaId ==
                                          e.medioUtilizaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 3)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo tres opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            var selectedItems =
                                                List<LstMediosUtilizaCA>.from(
                                                    formState.value ?? []);

                                            if (value == true) {
                                              selectedItems.add(
                                                  LstMediosUtilizaCA(
                                                      medioUtilizaId:
                                                          e.medioUtilizaId));
                                            } else {
                                              selectedItems.removeWhere(
                                                (element) =>
                                                    element.medioUtilizaId ==
                                                    e.medioUtilizaId,
                                              );
                                            }
                                            formState.didChange(selectedItems);
                                            dimUbicacionBloc.add(
                                                MediosUtilizaCAChanged(
                                                    selectedItems));
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
                                    state.mediosUtilizaCALoaded!.length - 1)
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
          'Dificultad de acceso',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<DificultadAccesoCACubit, DificultadesAccesoCAState>(
          builder: (context, state) {
            if (state is DificultadesAccesoCALoaded) {
              return FormField<List<LstDificultadAccesoAtencion>>(
                initialValue:
                    dimUbicacionBloc.state.lstDificultadAccesoAtencion,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstDificultadAccesoAtencion>>
                    formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.dificultadesAccesoCALoaded!.length,
                          (index) {
                            final e = state.dificultadesAccesoCALoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.dificultaAccesoId ==
                                          e.dificultaAccesoId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    (value! &&
                                            formState.value != null &&
                                            formState.value!.length >= 3 &&
                                            e.dificultaAccesoId != 5)
                                        ? CustomSnackBar.showCustomDialog(
                                            context,
                                            'Error',
                                            'Máximo tres opciones',
                                            () => Navigator.pop(context),
                                            false)
                                        : setState(() {
                                            var selectedItems = List<
                                                    LstDificultadAccesoAtencion>.from(
                                                formState.value ?? []);

                                            if (e.dificultaAccesoId == 5) {
                                              selectedItems = [
                                                LstDificultadAccesoAtencion(
                                                    dificultaAccesoId:
                                                        e.dificultaAccesoId)
                                              ];
                                            } else if (value == true) {
                                              selectedItems.removeWhere(
                                                  ((element) =>
                                                      element
                                                          .dificultaAccesoId ==
                                                      5));
                                              selectedItems.add(
                                                  LstDificultadAccesoAtencion(
                                                      dificultaAccesoId:
                                                          e.dificultaAccesoId));
                                            } else {
                                              selectedItems.removeWhere(
                                                (element) =>
                                                    element.dificultaAccesoId ==
                                                    e.dificultaAccesoId,
                                              );
                                            }
                                            formState.didChange(selectedItems);
                                            dimUbicacionBloc.add(
                                                DificultadesAccesoCAChanged(
                                                    selectedItems));
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
                                    state.dificultadesAccesoCALoaded!.length -
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
                value: _costoDesplazamientoId,
                items: state.costosDesplazamientoLoaded!
                    .map(
                      (costoDesplazamiento) => DropdownMenuItem<int>(
                        value: costoDesplazamiento.costoDesplazamientoId,
                        child: Text(costoDesplazamiento.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Costo desplazamiento',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _costoDesplazamientoId = newValue;
                  });
                  dimUbicacionBloc.add(CostoDesplazamientoChanged(newValue!));
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
          'Realiza producción minera',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
          builder: (context, state) {
            if (state is OpcionesSiNoLoaded) {
              return FormField(
                initialValue: _produccionMinera,
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
                                      groupValue: _produccionMinera,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          _produccionMinera = newValue!;
                                        });

                                        dimUbicacionBloc.add(
                                            ProduccionMineraChanged(newValue!));

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
      ],
    );
  }
}
