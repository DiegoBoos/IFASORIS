import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';

class DatosUbicacionForm extends StatefulWidget {
  const DatosUbicacionForm({
    Key? key,
  }) : super(key: key);

  @override
  State<DatosUbicacionForm> createState() => DatosUbicacionFormState();
}

class DatosUbicacionFormState extends State<DatosUbicacionForm> {
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
                isExpanded: true,
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
