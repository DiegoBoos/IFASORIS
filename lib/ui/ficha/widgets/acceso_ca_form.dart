import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/dificultad_acceso_ca_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({super.key, this.dimUbicacion});
  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoCAForm> createState() => AccesoCAFormState();
}

class AccesoCAFormState extends State<AccesoCAForm> {
  int? _tiempoTardaId;
  int? _medioUtilizaId;
  int? _costoDesplazamientoId;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tiempoTardaId = widget.dimUbicacion?.tiempoTardaId;
      _medioUtilizaId = widget.dimUbicacion?.medioUtilizaId;
      _costoDesplazamientoId = widget.dimUbicacion?.costoDesplazamientoId;
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
              return DropdownButtonFormField<int>(
                value: _medioUtilizaId,
                items: state.mediosUtilizaCALoaded!
                    .map(
                      (medioUtiliza) => DropdownMenuItem<int>(
                        value: medioUtiliza.medioUtilizaId,
                        child: Text(medioUtiliza.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Medio que utiliza para ir desde su casa al centro de atención en Salud',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _medioUtilizaId = newValue;
                  });
                  dimUbicacionBloc.add(MedioUtilizaCAChanged(newValue!));
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
                  } else if (value.length > 3) {
                    return 'Máximo tres opciones.';
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
                                    var selectedItems =
                                        List<LstDificultadAccesoAtencion>.from(
                                            formState.value ?? []);

                                    if (e.dificultaAccesoId == 5) {
                                      selectedItems = [
                                        LstDificultadAccesoAtencion(
                                            dificultaAccesoId:
                                                e.dificultaAccesoId)
                                      ];
                                    } else if (value == true) {
                                      selectedItems.removeWhere(((element) =>
                                          element.dificultaAccesoId == 5));
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
        const SizedBox(height: 20),
      ],
    );
  }
}
