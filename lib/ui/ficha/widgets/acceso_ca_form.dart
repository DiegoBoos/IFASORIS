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
import '../../utils/validators/form_validators.dart';
import '../helpers/dificultades_acceso_helper.dart';
import '../helpers/medios_utiliza_helper.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({super.key, required this.dimUbicacion});
  final DimUbicacionEntity dimUbicacion;

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
      _tiempoTardaId = widget.dimUbicacion.tiempoTardaId;
      _costoDesplazamientoId = widget.dimUbicacion.costoDesplazamientoId;
      _produccionMinera = widget.dimUbicacion.produccionMinera;
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
              final tiemposTardaCALoaded = state.tiemposTardaCALoaded!;

              return DropdownButtonFormField<int>(
                value: _tiempoTardaId,
                items: tiemposTardaCALoaded
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
              final mediosUtilizaCALoaded = state.mediosUtilizaCALoaded!;

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
                          mediosUtilizaCALoaded.length,
                          (index) {
                            final medioUtilizaCA = mediosUtilizaCALoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.medioUtilizaId ==
                                          medioUtilizaCA.medioUtilizaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    handleMedioUtilizaSelection(
                                        formState,
                                        context,
                                        value,
                                        medioUtilizaCA.medioUtilizaId,
                                        dimUbicacionBloc);
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    medioUtilizaCA.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index < mediosUtilizaCALoaded.length - 1)
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
              final dificultadesAccesoCALoaded =
                  state.dificultadesAccesoCALoaded!;
              int? ningunoId;

              for (var e in dificultadesAccesoCALoaded) {
                final optionType = FormValidators.optionType(e.descripcion);
                if (optionType == 'N') {
                  ningunoId = e.dificultaAccesoId;
                }
              }

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
                          dificultadesAccesoCALoaded.length,
                          (index) {
                            final dificultadAccesoCA =
                                dificultadesAccesoCALoaded[index];

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.dificultaAccesoId ==
                                          dificultadAccesoCA
                                              .dificultaAccesoId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    handleDificultadAccesoSelection(
                                        formState,
                                        ningunoId,
                                        context,
                                        value ?? false,
                                        dificultadAccesoCA.dificultaAccesoId,
                                        dimUbicacionBloc);
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    dificultadAccesoCA.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    dificultadesAccesoCALoaded.length - 1)
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
                value: _costoDesplazamientoId,
                items: costosDesplazamientoLoaded
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
              final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;
              return FormField(
                initialValue: _produccionMinera,
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
                                      groupValue: _produccionMinera,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          _produccionMinera = newValue!;
                                        });

                                        formstate.didChange(newValue);

                                        dimUbicacionBloc.add(
                                            ProduccionMineraChanged(newValue!));
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
