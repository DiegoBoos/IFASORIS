import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/cubits/estado_via/estado_via_cubit.dart';
import 'package:ifasoris/ui/cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import 'package:ifasoris/ui/cubits/via_acceso/via_acceso_cubit.dart';
import 'package:intl/intl.dart';

import '../../cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import '../../cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import '../../cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';

class Screen1Page extends StatefulWidget {
  const Screen1Page({super.key});

  @override
  State<Screen1Page> createState() => _Screen1PageState();
}

class _Screen1PageState extends State<Screen1Page> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const Icon(Icons.image),
          title: const ListTile(
            title: Text(
              'IFASORIS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'SUBDIRECCION DE APOYO ORGANIZATIVO Y SOCIOCULTURAL',
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: const [
              _DatosUbicacionForm(),
              _AccesoCAForm(),
              _AccesoMedicoForm()
            ],
          ),
        ),
      ),
    );
  }
}

class _DatosUbicacionForm extends StatefulWidget {
  const _DatosUbicacionForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_DatosUbicacionForm> createState() => _DatosUbicacionFormState();
}

class _DatosUbicacionFormState extends State<_DatosUbicacionForm> {
  DateTime? _fechaSeleccionada;
  String? _departamentoSeleccionado;
  String? _municipioSeleccionado;
  String? _zonaSeleccionada;
  String? _opcionRadioSeleccionada;
  String? _viaAccesoSeleccionada;
  String? _estadoViaSeleccionada;
  String? _medioComunicacionSeleccionado;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          color: Theme.of(context).colorScheme.primary,
          child: const Text(
            'I. DATOS DE UBICACIÓN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        DateTimeField(
          format: DateFormat("yyyy-MM-dd"),
          initialValue: _fechaSeleccionada,
          decoration: const InputDecoration(
            labelText: 'Fecha de Diligenciamiento',
            border: OutlineInputBorder(),
          ),
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              initialDate: currentValue ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              setState(() {
                _fechaSeleccionada = date;
              });
            }
            return date;
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _departamentoSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _departamentoSeleccionado = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText: 'Departamento', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _municipioSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _municipioSeleccionado = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText: 'Municipio', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Dirección', border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Barrio', border: OutlineInputBorder()),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _zonaSeleccionada,
                onChanged: (newValue) {
                  setState(() {
                    _zonaSeleccionada = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText: 'Zona', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'IPS Primaria', border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _zonaSeleccionada,
                onChanged: (newValue) {
                  setState(() {
                    _zonaSeleccionada = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText: 'Zona', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Numero de Documento',
                    border: OutlineInputBorder()),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Nombre de quien recibe la visita',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Teléfono fijo', border: OutlineInputBorder()),
              onChanged: (value) {},
            )),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Celular 1', border: OutlineInputBorder()),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Celular 2', border: OutlineInputBorder()),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(child: Text('Pertenece a algún resguardo indígena')),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('SI'),
                value: 'si',
                groupValue: _opcionRadioSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionRadioSeleccionada = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('NO'),
                value: 'no',
                groupValue: _opcionRadioSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionRadioSeleccionada = value;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Nombre del resguardo indígena',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Nombre con el que conoce a la autoridad indígena',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        BlocBuilder<ViaAccesoCubit, ViasAccesoState>(
          builder: (context, state) {
            if (state is ViasAccesoLoaded) {
              return DropdownButtonFormField<String>(
                value: _viaAccesoSeleccionada,
                onChanged: (newValue) {
                  setState(() {
                    _viaAccesoSeleccionada = newValue;
                  });
                },
                items: state.viasAccesoLoaded!
                    .map((viaAcceso) => DropdownMenuItem<String>(
                          value: viaAcceso.viaAccesoId.toString(),
                          child: Text(viaAcceso.descripcion),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Vías de acceso que utiliza',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<EstadoViaCubit, EstadosViasState>(
          builder: (context, state) {
            if (state is EstadosViasLoaded) {
              return DropdownButtonFormField<String>(
                value: _estadoViaSeleccionada,
                onChanged: (newValue) {
                  setState(() {
                    _estadoViaSeleccionada = newValue;
                  });
                },
                items: state.estadosViasLoaded!
                    .map(
                      (estadoVia) => DropdownMenuItem<String>(
                        value: estadoVia.estadoViaId.toString(),
                        child: Text(estadoVia.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Estado de las vías de acceso',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<MedioComunicacionCubit, MediosComunicacionState>(
          builder: (context, state) {
            if (state is MediosComunicacionLoaded) {
              return DropdownButtonFormField<String>(
                value: _medioComunicacionSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _medioComunicacionSeleccionado = newValue;
                  });
                },
                items: state.mediosComunicacionLoaded!
                    .map(
                      (medioComunicacion) => DropdownMenuItem<String>(
                        value: medioComunicacion.medioComunicacionId.toString(),
                        child: Text(medioComunicacion.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Medios de comunicación que utiliza con mayor frecuencia',
                    border: OutlineInputBorder()),
              );
            } else {
              return Container();
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _AccesoCAForm extends StatefulWidget {
  const _AccesoCAForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_AccesoCAForm> createState() => _AccesoCAFormState();
}

class _AccesoCAFormState extends State<_AccesoCAForm> {
  String? _tiempoTardaCASeleccionado;
  String? _medioUtilizaCASeleccionado;
  String? _dificultadAccesoSeleccionado;
  String? _costoDesplazamientoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 30,
            color: Colors.yellow[200],
            child: const Text(
              'ACCESO AL CENTRO DE ATENCION DE SALUD MAS CERCANO',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        BlocBuilder<TiempoTardaCACubit, TiemposTardaCAState>(
          builder: (context, state) {
            if (state is TiemposTardaCALoaded) {
              return DropdownButtonFormField<String>(
                value: _tiempoTardaCASeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _tiempoTardaCASeleccionado = newValue;
                  });
                },
                items: state.tiemposTardaCALoaded!
                    .map(
                      (tiempoTardaCA) => DropdownMenuItem<String>(
                        value: tiempoTardaCA.tiempoTardaId.toString(),
                        child: Text(tiempoTardaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al centro de atención en Salud',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        BlocBuilder<MedioUtilizaCACubit, MediosUtilizaCAState>(
          builder: (context, state) {
            if (state is MediosUtilizaCALoaded) {
              return DropdownButtonFormField<String>(
                value: _medioUtilizaCASeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _medioUtilizaCASeleccionado = newValue;
                  });
                },
                items: state.mediosUtilizaCALoaded!
                    .map(
                      (medioUtilizaCA) => DropdownMenuItem<String>(
                        value: medioUtilizaCA.medioUtilizaId.toString(),
                        child: Text(medioUtilizaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Medios que utiliza para el desplazamiento al centro de atención',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<DificultadAccesoCACubit,
                  DificultadesAccesoCAState>(
                builder: (context, state) {
                  if (state is DificultadesAccesoCALoaded) {
                    return DropdownButtonFormField<String>(
                      value: _dificultadAccesoSeleccionado,
                      onChanged: (newValue) {
                        setState(() {
                          _dificultadAccesoSeleccionado = newValue;
                        });
                      },
                      items: state.dificultadesAccesoCALoaded!
                          .map(
                            (dificultadAccesoCA) => DropdownMenuItem<String>(
                              value: dificultadAccesoCA.dificultaAccesoId
                                  .toString(),
                              child: Text(dificultadAccesoCA.descripcion),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                          labelText: 'Dificultad de acceso',
                          border: OutlineInputBorder()),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _costoDesplazamientoSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _costoDesplazamientoSeleccionado = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al centro de atención en Salud',
                    border: OutlineInputBorder()),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _AccesoMedicoForm extends StatefulWidget {
  const _AccesoMedicoForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_AccesoMedicoForm> createState() => _AccesoMedicoFormState();
}

class _AccesoMedicoFormState extends State<_AccesoMedicoForm> {
  String? _opcionRadioSeleccionada;
  String? _especialidadMTSeleccionada;
  String? _tiempoTardaMTSeleccionado;
  String? _medioUtilizaSeleccionado;
  String? _dificultadAccesoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 30,
            color: Colors.yellow[200],
            child: const Text(
              'ACCESO AL MEDICO TRADICIONAL MAS CERCANO',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Row(
          children: [
            const Expanded(
                child: Text('Existe médico tradicional en su comunidad')),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('SI'),
                value: 'si',
                groupValue: _opcionRadioSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionRadioSeleccionada = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('NO'),
                value: 'no',
                groupValue: _opcionRadioSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionRadioSeleccionada = value;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _especialidadMTSeleccionada,
                onChanged: (newValue) {
                  setState(() {
                    _especialidadMTSeleccionada = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText: 'Especialidad del médico tradicional',
                    border: OutlineInputBorder()),
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _tiempoTardaMTSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _tiempoTardaMTSeleccionado = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al medico tradicional',
                    border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        DropdownButtonFormField<String>(
          value: _medioUtilizaSeleccionado,
          onChanged: (newValue) {
            setState(() {
              _medioUtilizaSeleccionado = newValue;
            });
          },
          items: [
            const DropdownMenuItem<String>(
              value: 'Option 1',
              child: Text('Option 1'),
            ),
            const DropdownMenuItem<String>(
              value: 'Option 2',
              child: Text('Option 2'),
            ),
          ],
          decoration: const InputDecoration(
              labelText:
                  'Medios que utiliza para el desplazamiento al médico tradicional',
              border: OutlineInputBorder()),
        ),
        DropdownButtonFormField<String>(
          value: _dificultadAccesoSeleccionado,
          onChanged: (newValue) {
            setState(() {
              _dificultadAccesoSeleccionado = newValue;
            });
          },
          items: [
            const DropdownMenuItem<String>(
              value: 'Option 1',
              child: Text('Option 1'),
            ),
            const DropdownMenuItem<String>(
              value: 'Option 2',
              child: Text('Option 2'),
            ),
          ],
          decoration: const InputDecoration(
              labelText:
                  'Que dificultad de acceso tiene, para llegar donde el médico tradicional',
              border: OutlineInputBorder()),
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Costo del desplazamiento a médico tradicional',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Nombre del médico tradicional',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
