import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/encuesta/encuesta_bloc.dart';

class EstilosVidaSaludableForm extends StatefulWidget {
  const EstilosVidaSaludableForm({super.key});

  @override
  State<EstilosVidaSaludableForm> createState() =>
      _EstilosVidaSaludableFormState();
}

class _EstilosVidaSaludableFormState extends State<EstilosVidaSaludableForm> {
  final _nombresApellidosCtrl = TextEditingController();

  int? _actividadFisicaId;
  List<Map<String, dynamic>> actividadesFisicas = [
    {'actividadFisicaId': 1, 'descripcion': 'Gym'}
  ];

  int? _alimentacionId;
  List<Map<String, dynamic>> alimentaciones = [
    {'alimentacionId': 1, 'descripcion': 'Vegano'}
  ];

  int? _numeroCigarrillosDiaId;
  List<Map<String, dynamic>> numeroCigarrillos = [
    {'numeroCigarrilloId': 1, 'descripcion': '12'}
  ];

  int? _consumoAlcoholId;
  List<Map<String, dynamic>> consumoAlcohol = [
    {'consumoAlcoholId': 1, 'descripcion': 'Cada 8'}
  ];

  int? _consumoSustanciaId;
  List<Map<String, dynamic>> consumoSustancias = [
    {'consumoSustanciaId': 1, 'descripcion': 'SI'},
    {'consumoSustanciaId': 2, 'descripcion': 'NO'},
  ];

  int? _consumoCigarrilloId;
  List<Map<String, dynamic>> consumoCigarrillos = [
    {'consumoCigarrilloId': 1, 'descripcion': 'SI'},
    {'consumoCigarrilloId': 2, 'descripcion': 'NO'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Divider(),
      const Text(
        'IV. ESTILOS DE VIDA SALUDABLE',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      const SizedBox(height: 20),
      BlocBuilder<EncuestaBloc, EncuestaState>(
        builder: (context, state) {
          if (state.afiliados.isNotEmpty) {
            _nombresApellidosCtrl.text = state.afiliados[0].nombre1 ?? '';
            return TextFormField(
              enabled: false,
              controller: _nombresApellidosCtrl,
              decoration: const InputDecoration(
                labelText: 'Apellidos y Nombres',
                border: OutlineInputBorder(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      const SizedBox(height: 20),
      DropdownButtonFormField<int>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: _actividadFisicaId,
        items: actividadesFisicas
            .map(
              (actividadFisica) => DropdownMenuItem<int>(
                value: actividadFisica['actividadFisicaId'],
                child: Text(actividadFisica['descripcion']),
              ),
            )
            .toList(),
        decoration: const InputDecoration(
            labelText: 'Seleccione una opción', border: OutlineInputBorder()),
        onChanged: (int? newValue) {
          setState(() {
            _actividadFisicaId = newValue;
          });
          //dimUbicacionBloc.add(TiempoTardaChanged(newValue!));
        },
        validator: (value) {
          if (value == null) {
            return 'Campo Requerido';
          }
          return null;
        },
      ),
      const Divider(),
      const Text(
        'Alimentación',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      DropdownButtonFormField<int>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: _alimentacionId,
        items: alimentaciones
            .map(
              (alimentacion) => DropdownMenuItem<int>(
                value: alimentacion['alimentacionId'],
                child: Text(alimentacion['descripcion']),
              ),
            )
            .toList(),
        decoration: const InputDecoration(
            labelText: 'Seleccione una opción', border: OutlineInputBorder()),
        onChanged: (int? newValue) {
          setState(() {
            _alimentacionId = newValue;
          });
          //dimUbicacionBloc.add(TiempoTardaChanged(newValue!));
        },
        validator: (value) {
          if (value == null) {
            return 'Campo Requerido';
          }
          return null;
        },
      ),
      const Divider(),
      const Text(
        'Consumo de cigarrillo',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _consumoCigarrilloId,
        builder: (FormFieldState<int> formstate) {
          return Column(
            children: [
              Wrap(
                children: List<Widget>.generate(
                  consumoCigarrillos.length,
                  (index) {
                    final e = consumoCigarrillos[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value:
                              _consumoCigarrilloId == e['consumoCigarrilloId'],
                          onChanged: (bool? value) {
                            setState(() {
                              _consumoCigarrilloId =
                                  value! ? e['consumoCigarrilloId'] : null;
                              formstate.didChange(_consumoCigarrilloId);
                            });
                          },
                        ),
                        Text(e['descripcion']),
                        if (index < consumoCigarrillos.length - 1)
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
        onSaved: (int? value) {},
      ),
      const Divider(),
      const Text(
        'Número de cigarrillos por día',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      DropdownButtonFormField<int>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: _numeroCigarrillosDiaId,
        items: numeroCigarrillos
            .map(
              (numeroCigarrilloDia) => DropdownMenuItem<int>(
                value: numeroCigarrilloDia['numeroCigarrilloId'],
                child: Text(numeroCigarrilloDia['descripcion']),
              ),
            )
            .toList(),
        decoration: const InputDecoration(
            labelText: 'Seleccione una opción', border: OutlineInputBorder()),
        onChanged: (int? newValue) {
          setState(() {
            _numeroCigarrillosDiaId = newValue;
          });
          //dimUbicacionBloc.add(TiempoTardaChanged(newValue!));
        },
        validator: (value) {
          if (value == null) {
            return 'Campo Requerido';
          }
          return null;
        },
      ),
      const Divider(),
      const Text(
        'Consumo de alcohol',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      DropdownButtonFormField<int>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: _consumoAlcoholId,
        items: consumoAlcohol
            .map(
              (consumoAlcohol) => DropdownMenuItem<int>(
                value: consumoAlcohol['consumoAlcoholId'],
                child: Text(consumoAlcohol['descripcion']),
              ),
            )
            .toList(),
        decoration: const InputDecoration(
            labelText: 'Seleccione una opción', border: OutlineInputBorder()),
        onChanged: (int? newValue) {
          setState(() {
            _consumoAlcoholId = newValue;
          });
          //dimUbicacionBloc.add(TiempoTardaChanged(newValue!));
        },
        validator: (value) {
          if (value == null) {
            return 'Campo Requerido';
          }
          return null;
        },
      ),
      const Divider(),
      const Text(
        'Consumo de otras sustancias Psicoactivas',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _consumoSustanciaId,
        builder: (FormFieldState<int> formstate) {
          return Column(
            children: [
              Wrap(
                children: List<Widget>.generate(
                  consumoSustancias.length,
                  (index) {
                    final e = consumoSustancias[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _consumoSustanciaId == e['consumoSustanciaId'],
                          onChanged: (bool? value) {
                            setState(() {
                              _consumoSustanciaId =
                                  value! ? e['consumoSustanciaId'] : null;
                              formstate.didChange(_consumoSustanciaId);
                            });
                          },
                        ),
                        Text(e['descripcion']),
                        if (index < consumoSustancias.length - 1)
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
        onSaved: (int? value) {},
      ),
    ]);
  }
}
