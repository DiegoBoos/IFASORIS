import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/dim_ubicacion/dim_ubicacion_exports.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';

class DatosUbicacionForm extends StatefulWidget {
  const DatosUbicacionForm({super.key});

  @override
  State<DatosUbicacionForm> createState() => DatosUbicacionFormState();
}

class DatosUbicacionFormState extends State<DatosUbicacionForm> {
  DateTime? _fechafiliacion;
  String? _nomDptoAfiliado;
  String? _nomMpioAfiliado;
  String? _direccion;
  String? _barrio;
  String? _codZonaAfiliado;
  String? _ipsPrimariaAfiliado;
  String? _documento;
  final _nombreRecibeVisitaCtrl = TextEditingController();
  final _telefonoFijoCtrl = TextEditingController();
  final _telefonocel1Ctrl = TextEditingController();
  final _telefonocel2Ctrl = TextEditingController();
  String? _perteneceResguardo;
  final _nombreResguardoIndigenaCtrl = TextEditingController();
  final _nombreAutoridadIndigenaCtrl = TextEditingController();
  String? _viaAccesoSeleccionada;
  String? _estadoViaSeleccionada;
  String? _medioComunicacion;

  @override
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );
    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    _fechafiliacion = afiliado.fechafiliacion;
    _nomDptoAfiliado = afiliado.nomDptoAfiliado;
    _nomMpioAfiliado = afiliado.nomMpioAfiliado;
    _direccion = afiliado.direccion;
    //TODO: _barrio = afiliado.barrio;
    _codZonaAfiliado = afiliado.codZonaAfiliado;
    _ipsPrimariaAfiliado = afiliado.ipsPrimariaAfiliado;
    _documento = afiliado.documento;
    _telefonoFijoCtrl.text = afiliado.telefonofijo;
    _telefonocel1Ctrl.text = afiliado.telefonocel1;
    _telefonocel2Ctrl.text = afiliado.telefonocel2;

    if (afiliado.familiaId != null) {
      getDimUbicacion(afiliado.familiaId!);
    }
  }

  getDimUbicacion(int familiaId) async {
    final dimUbicacionCubit = BlocProvider.of<DimUbicacionCubit>(
      context,
    );

    final dimUbicacion = await dimUbicacionCubit.getDimUbicacion(familiaId);

    setState(() {
      _nombreRecibeVisitaCtrl.text = dimUbicacion?.nombreRecibeVisita ?? '';
      _perteneceResguardo = dimUbicacion?.perteneceResguardo.toString();
      _viaAccesoSeleccionada = dimUbicacion?.viaAccesoId.toString();
      _estadoViaSeleccionada = dimUbicacion?.estadoViaId.toString();
      _medioComunicacion = dimUbicacion?.medioComunicacionId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionCubit = BlocProvider.of<DimUbicacionCubit>(context);
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
        const SizedBox(height: 20),
        DateTimeField(
          format: DateFormat("yyyy-MM-dd"),
          initialValue: _fechafiliacion,
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
                _fechafiliacion = date;
              });
              //TODO: dimUbicacionCubit.changeFecha(newValue);
            }
            return date;
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                enabled: false,
                initialValue: _nomDptoAfiliado,
                decoration: const InputDecoration(
                    labelText: 'Departamento', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                enabled: false,
                initialValue: _nomMpioAfiliado,
                decoration: const InputDecoration(
                    labelText: 'Municipio', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFormField(
          enabled: false,
          initialValue: _direccion,
          decoration: const InputDecoration(
              labelText: 'Dirección', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                enabled: false,
                initialValue: _barrio,
                decoration: const InputDecoration(
                    labelText: 'Barrio', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                enabled: false,
                initialValue: _codZonaAfiliado,
                decoration: const InputDecoration(
                    labelText: 'Zona', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFormField(
          enabled: false,
          initialValue: _ipsPrimariaAfiliado,
          decoration: const InputDecoration(
              labelText: 'IPS Primaria', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 20),
        TextFormField(
          enabled: false,
          initialValue: _documento,
          decoration: const InputDecoration(
              labelText: 'Numero de Documento', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 20),
        TextFormField(
            controller: _nombreRecibeVisitaCtrl,
            decoration: const InputDecoration(
                labelText: 'Nombre de quien recibe la visita',
                border: OutlineInputBorder()),
            onSaved: (String? newValue) {
              dimUbicacionCubit.changeNombreRecibeVisita(newValue);
            }),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: TextFormField(
              enabled: false,
              controller: _telefonoFijoCtrl,
              decoration: const InputDecoration(
                  labelText: 'Teléfono fijo', border: OutlineInputBorder()),
            )),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                enabled: false,
                controller: _telefonocel1Ctrl,
                decoration: const InputDecoration(
                    labelText: 'Celular 1', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                enabled: false,
                controller: _telefonocel2Ctrl,
                decoration: const InputDecoration(
                    labelText: 'Celular 2', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
          builder: (context, state) {
            if (state is OpcionesSiNoLoaded) {
              return Wrap(
                children: [
                  const Text('Pertenece a algún resguardo indígena'),
                  Wrap(
                      children: state.opcionesSiNoLoaded!
                          .map<Widget>(
                            (e) => SizedBox(
                              height: 50,
                              child: RadioListTile<String>(
                                title: Text(
                                  e.descripcion,
                                ),
                                value: e.opcionId.toString(),
                                groupValue: _perteneceResguardo,
                                onChanged: (String? value) {
                                  setState(() {
                                    _perteneceResguardo = value;
                                  });
                                  dimUbicacionCubit
                                      .changePerteneceResguardo(value!);
                                },
                              ),
                            ),
                          )
                          .toList())
                ],
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
            controller: _nombreResguardoIndigenaCtrl,
            decoration: const InputDecoration(
                labelText: 'Nombre del resguardo indígena',
                border: OutlineInputBorder()),
            onSaved: (String? newValue) {
              //TODO: dimUbicacionCubit.nombreResguardoIndigena(newValue);
            }),
        const SizedBox(height: 20),
        TextFormField(
            controller: _nombreAutoridadIndigenaCtrl,
            decoration: const InputDecoration(
                labelText: 'Nombre con el que conoce a la autoridad indígena',
                border: OutlineInputBorder()),
            onSaved: (String? newValue) {
              //TODO: dimUbicacionCubit.changeNombreAutoridadIndigena(newValue);
            }),
        const SizedBox(height: 20),
        BlocBuilder<ViaAccesoCubit, ViasAccesoState>(
          builder: (context, state) {
            if (state is ViasAccesoLoaded) {
              return DropdownButtonFormField<String>(
                value: _viaAccesoSeleccionada,
                items: state.viasAccesoLoaded!
                    .map((viaAcceso) => DropdownMenuItem<String>(
                          value: viaAcceso.viaAccesoId.toString(),
                          child: Text(viaAcceso.descripcion),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Vías de acceso que utiliza',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _viaAccesoSeleccionada = newValue;
                  });
                  dimUbicacionCubit.changeViaAccesoId(newValue!);
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
        BlocBuilder<EstadoViaCubit, EstadosViasState>(
          builder: (context, state) {
            if (state is EstadosViasLoaded) {
              return DropdownButtonFormField<String>(
                value: _estadoViaSeleccionada,
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
                onChanged: (String? newValue) {
                  setState(() {
                    _estadoViaSeleccionada = newValue;
                  });
                  dimUbicacionCubit.changeEstadoViaId(newValue!);
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
        BlocBuilder<MedioComunicacionCubit, MediosComunicacionState>(
          builder: (context, state) {
            if (state is MediosComunicacionLoaded) {
              return DropdownButtonFormField<String>(
                isExpanded: true,
                value: _medioComunicacion,
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
                onChanged: (newValue) {
                  setState(() {
                    _medioComunicacion = newValue;
                  });
                  dimUbicacionCubit.changeMedioComunicacionId(newValue!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Campo Requerido';
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
      ],
    );
  }
}
