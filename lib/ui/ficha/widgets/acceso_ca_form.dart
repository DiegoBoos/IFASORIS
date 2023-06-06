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
  List<LstDificultadAccesoAtencion> _selectedDificultadesAccesoCA = [];
  int? _costoDesplazamientoId;

  String? _validateDificultadesAccesoCA() {
    if (_selectedDificultadesAccesoCA.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedDificultadesAccesoCA.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _tiempoTardaId = widget.dimUbicacion?.tiempoTardaId;
      _medioUtilizaId = widget.dimUbicacion?.medioUtilizaId;
      _costoDesplazamientoId = widget.dimUbicacion?.costoDesplazamientoId;
    });
    getOptions();
  }

  Future<void> getOptions() async {
    final dificultadAccesoCACubit = BlocProvider.of<DificultadAccesoCACubit>(
      context,
    );
    _selectedDificultadesAccesoCA = await dificultadAccesoCACubit
        .getUbicacionDificultadesAccesoCADB(widget.dimUbicacion?.ubicacionId);
    setState(() {});
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedDificultadesAccesoCA,
                builder: (FormFieldState<List<LstDificultadAccesoAtencion>>
                    formstate) {
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
                                value: _selectedDificultadesAccesoCA.any(
                                    (element) =>
                                        element.dificultaAccesoId ==
                                        e.dificultaAccesoId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.dificultaAccesoId == 5) {
                                      _selectedDificultadesAccesoCA = [
                                        LstDificultadAccesoAtencion(
                                            dificultaAccesoId:
                                                e.dificultaAccesoId)
                                      ];
                                    } else if (value!) {
                                      _selectedDificultadesAccesoCA.removeWhere(
                                          ((element) =>
                                              element.dificultaAccesoId == 5));
                                      _selectedDificultadesAccesoCA.add(
                                          LstDificultadAccesoAtencion(
                                              dificultaAccesoId:
                                                  e.dificultaAccesoId));
                                    } else {
                                      _selectedDificultadesAccesoCA.removeWhere(
                                        (element) =>
                                            element.dificultaAccesoId ==
                                            e.dificultaAccesoId,
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
                                state.dificultadesAccesoCALoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      Text(
                        _validateDificultadesAccesoCA() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateDificultadesAccesoCA(),
                onSaved: (List<LstDificultadAccesoAtencion>? value) {
                  dimUbicacionBloc.add(DificultadesAccesoCAChanged(value!));
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
