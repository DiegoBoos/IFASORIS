import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';

class DatosUbicacionForm extends StatefulWidget {
  const DatosUbicacionForm({super.key, this.dimUbicacion});

  final DimUbicacionEntity? dimUbicacion;

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
  int? _perteneceResguardo;
  final _nombreResguardoIndigenaCtrl = TextEditingController();
  int? _autoridadIndigena;
  int? _viaAcceso;
  int? _estadoVia;
  List<int> _selectedMediosComunicacion = [];

  String? _validateMediosComunicacion() {
    if (_selectedMediosComunicacion.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedMediosComunicacion.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

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
    _telefonoFijoCtrl.text = afiliado.telefonofijo ?? '';
    _telefonocel1Ctrl.text = afiliado.telefonocel1 ?? '';
    _telefonocel2Ctrl.text = afiliado.telefonocel2;

    setState(() {
      _nombreRecibeVisitaCtrl.text =
          widget.dimUbicacion?.nombreRecibeVisita ?? '';
      _perteneceResguardo = widget.dimUbicacion?.perteneceResguardo;
      _autoridadIndigena = widget.dimUbicacion?.autoridadIndigenaId;
      _viaAcceso = widget.dimUbicacion?.viaAccesoId;
      _estadoVia = widget.dimUbicacion?.estadoViaId;
      _selectedMediosComunicacion =
          widget.dimUbicacion?.mediosComunicacionIds ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          color: Theme.of(context).colorScheme.primary,
          child: const Text(
            'I. DATOS DE UBICACIÓN',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        DateTimeField(
          format: DateFormat("dd-MM-yyyy"),
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
              //TODO: dimUbicacionBloc.changeFecha(newValue);
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _nombreRecibeVisitaCtrl,
            decoration: const InputDecoration(
                labelText: 'Nombre de quien recibe la visita',
                border: OutlineInputBorder()),
            onSaved: (String? newValue) {
              dimUbicacionBloc.add(NombreRecibeVisitaChanged(newValue!));
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
              return Column(
                children: [
                  FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _perteneceResguardo,
                    builder: (FormFieldState<int> formstate) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pertenece a algún resguardo indígena'),
                          Column(
                            children: state.opcionesSiNoLoaded!
                                .map(
                                  (e) => RadioListTile(
                                    title: Text(
                                      e.descripcion,
                                    ),
                                    value: e.opcionId,
                                    groupValue: _perteneceResguardo,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _perteneceResguardo = value;
                                        formstate.didChange(value);
                                      });
                                    },
                                  ),
                                )
                                .toList(),
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
                    onSaved: (int? value) {
                      dimUbicacionBloc.add(PerteneceResguardoChanged(value!));
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _nombreResguardoIndigenaCtrl,
            decoration: const InputDecoration(
                labelText: 'Nombre del resguardo indígena',
                border: OutlineInputBorder()),
            onSaved: (String? newValue) {
              //TODO: dimUbicacionBloc.nombreResguardoIndigena(newValue);
            }),
        const SizedBox(height: 20),
        BlocBuilder<AutoridadIndigenaCubit, AutoridadesIndigenasState>(
          builder: (context, state) {
            if (state is AutoridadesIndigenasLoaded) {
              return DropdownButtonFormField<int>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _autoridadIndigena,
                items: state.autoridadesIndigenas!
                    .map(
                      (autoridadIndigena) => DropdownMenuItem<int>(
                        value: autoridadIndigena.autoridadIndigenaId,
                        child: Text(autoridadIndigena.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Nombre con el que se connoce a la autoridad indígena',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _autoridadIndigena = newValue;
                  });
                  dimUbicacionBloc.add(AutoridadIndigenaChanged(newValue!));
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
        BlocBuilder<ViaAccesoCubit, ViasAccesoState>(
          builder: (context, state) {
            if (state is ViasAccesoLoaded) {
              return DropdownButtonFormField<int>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _viaAcceso,
                items: state.viasAccesoLoaded!
                    .map((viaAcceso) => DropdownMenuItem<int>(
                          value: viaAcceso.viaAccesoId,
                          child: Text(viaAcceso.descripcion),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Vías de acceso que utiliza',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _viaAcceso = newValue;
                  });
                  dimUbicacionBloc.add(ViaAccesoChanged(newValue!));
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
              return DropdownButtonFormField<int>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _estadoVia,
                items: state.estadosViasLoaded!
                    .map(
                      (estadoVia) => DropdownMenuItem<int>(
                        value: estadoVia.estadoViaId,
                        child: Text(estadoVia.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Estado de las vías de acceso',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _estadoVia = newValue;
                  });
                  dimUbicacionBloc.add(EstadoViaChanged(newValue!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedMediosComunicacion,
                builder: (FormFieldState<List<int>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.mediosComunicacionLoaded!.length, (index) {
                        final e = state.mediosComunicacionLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedMediosComunicacion
                                    .contains(e.medioComunicacionId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.medioComunicacionId == 7) {
                                      _selectedMediosComunicacion = [
                                        e.medioComunicacionId
                                      ];
                                    } else if (value!) {
                                      _selectedMediosComunicacion.remove(7);
                                      _selectedMediosComunicacion
                                          .add(e.medioComunicacionId);
                                    } else {
                                      _selectedMediosComunicacion
                                          .remove(e.medioComunicacionId);
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
                                state.mediosComunicacionLoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      Text(
                        _validateMediosComunicacion() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateMediosComunicacion(),
                onSaved: (List<int>? value) {
                  dimUbicacionBloc.add(MediosComunicacionChanged(value!));
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
