import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatosViviendaForm extends StatefulWidget {
  const DatosViviendaForm({super.key});

  @override
  State<DatosViviendaForm> createState() => _DatosViviendaFormState();
}

class _DatosViviendaFormState extends State<DatosViviendaForm> {
  bool _tipoVivienda = false;
  int? _dormitorioVivienda;
  bool _tenenciaVivienda = false;
  bool _pisoVivienda = false;
  bool _techoVivienda = false;
  bool _ventilacion = false;
  bool _iluminacion = false;
  bool _servicioPublico = false;
  bool _tratamientoAgua = false;
  bool _tipoSanitario = false;
  bool _tipoCombustible = false;
  bool _factorRiesgoVivienda = false;
  bool _presenciaAnimalVivienda = false;

  @override
  Widget build(BuildContext context) {
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
        /*  BlocBuilder<TipoViviendaCubit, TiposViviendaState>(
          builder: (context, state) {
            if (state is TiposViviendaLoaded) {
              return Wrap(
                  children: state.tiposViviendaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.tipoViviendaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _tipoVivienda = value!;
                        });
                        viviendaCubit.changeTipoVivienda(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /* BlocBuilder<DormitorioViviendaCubit, DormitoriosViviendaState>(
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
                  viviendaCubit.changeDormitorioViviendaId(newValue);
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
        /*  BlocBuilder<TenenciaViviendaCubit, TenenciasViviendaState>(
          builder: (context, state) {
            if (state is TenenciasViviendaLoaded) {
              return Wrap(
                  children: state.tenenciasViviendaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.tenenciaViviendaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _tenenciaVivienda = value!;
                        });
                        viviendaCubit.changeTenenciaVivienda(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const Divider(),
        const Text(
          'Piso de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        /*  BlocBuilder<PisoViviendaCubit, PisosViviendaState>(
          builder: (context, state) {
            if (state is PisosViviendaLoaded) {
              return Wrap(
                  children: state.pisosViviendaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.pisoViviendaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _pisoVivienda = value!;
                        });
                        viviendaCubit.changePisoVivienda(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const Divider(),
        const Text(
          'Techo de la vivienda',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        /*  BlocBuilder<TechoViviendaCubit, TechosViviendaState>(
          builder: (context, state) {
            if (state is TechosViviendaLoaded) {
              return Wrap(
                  children: state.techosViviendaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.techoViviendaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _techoVivienda = value!;
                        });
                        viviendaCubit.changeTechoVivienda(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /*  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'Ventilación',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                BlocBuilder<VentilacionCubit, VentilacionState>(
                  builder: (context, state) {
                    if (state is VentilacionsLoaded) {
                      return Wrap(
                          children: state.ventilacionLoaded!.map<Widget>(
                        (e) => Column(
                          children: [
                            Checkbox(
                              value: e.ventilacionId,
                              onChanged: (bool? value) {
                                setState(() {
                                  _ventilacion = value!;
                                });
                                viviendaCubit.changeVentilacion(value);
                              },
                            ),
                            Text(
                              e.descripcion,
                            ),
                          ],
                        ),
                      ));
                    }
                    return Container();
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Iluminación',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                BlocBuilder<IluminacionCubit, IluminacionState>(
                  builder: (context, state) {
                    if (state is IluminacionsLoaded) {
                      return Wrap(
                          children: state.iluminacionLoaded!.map<Widget>(
                        (e) => Column(
                          children: [
                            Checkbox(
                              value: e.iluminacionId,
                              onChanged: (bool? value) {
                                setState(() {
                                  _iluminacion = value!;
                                });
                                viviendaCubit.changeIluminacion(value);
                              },
                            ),
                            Text(
                              e.descripcion,
                            ),
                          ],
                        ),
                      ));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ],
        ), */
        const Divider(),
        const Text(
          'Servicios públicos',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        /*  BlocBuilder<ServicioPublicoCubit, ServiciosPublicosState>(
          builder: (context, state) {
            if (state is ServiciosPublicosLoaded) {
              return Wrap(
                  children: state.serviciosPublicosLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.servicioPublicoId,
                      onChanged: (bool? value) {
                        setState(() {
                          _servicioPublico = value!;
                        });
                        viviendaCubit.changeServicioPublico(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /*  BlocBuilder<TratamientoAguaCubit, TratamientosAguaState>(
          builder: (context, state) {
            if (state is TratamientosAguaLoaded) {
              return Wrap(
                  children: state.tratamientosAguaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.tratamientoAguaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _tratamientoAgua = value!;
                        });
                        viviendaCubit.changeTratamientoAgua(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /* BlocBuilder<TipoSanitarioCubit, TiposSanitariosState>(
          builder: (context, state) {
            if (state is TiposSanitariosLoaded) {
              return Wrap(
                  children: state.tiposSanitariosLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.tipoSanitarioId,
                      onChanged: (bool? value) {
                        setState(() {
                          _tipoSanitario = value!;
                        });
                        viviendaCubit.changeTipoSanitario(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /*  BlocBuilder<TipoCombustibleCubit, TiposCombustibleState>(
          builder: (context, state) {
            if (state is TiposCombustibleLoaded) {
              return Wrap(
                  children: state.tiposCombustibleLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.tipoCombustibleId,
                      onChanged: (bool? value) {
                        setState(() {
                          _tipoCombustible = value!;
                        });
                        viviendaCubit.changeTipoCombustible(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /*  BlocBuilder<FactorRiesgoViviendaCubit, FactoresRiesgoViviendaState>(
          builder: (context, state) {
            if (state is FactoresRiesgoViviendaLoaded) {
              return Wrap(
                  children: state.FactoresRiesgoViviendaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.factorRiesgoViviendaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _factorRiesgoVivienda = value!;
                        });
                        viviendaCubit.changeFactorRiesgoVivienda(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
        /* BlocBuilder<ViviendaCubit, PresenciaAnimalesViviendaState>(
          builder: (context, state) {
            if (state is PresenciaAnimalesViviendaLoaded) {
              return Wrap(
                  children: state.presenciaAnimalesViviendaLoaded!.map<Widget>(
                (e) => Column(
                  children: [
                    Checkbox(
                      value: e.presenciaAnimalViviendaId,
                      onChanged: (bool? value) {
                        setState(() {
                          _presenciaAnimalVivienda = value!;
                        });
                        viviendaCubit.changePresenciaAnimalVivienda(value);
                      },
                    ),
                    Text(
                      e.descripcion,
                    ),
                  ],
                ),
              ));
            }
            return Container();
          },
        ), */
        const SizedBox(height: 20),
      ],
    );
  }
}
