import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/medio_comunicacion_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/tipo_documento/tipo_documento_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';

class DatosUbicacionForm extends StatefulWidget {
  const DatosUbicacionForm({super.key, this.dimUbicacion});

  final DimUbicacionEntity? dimUbicacion;

  @override
  State<DatosUbicacionForm> createState() => DatosUbicacionFormState();
}

class DatosUbicacionFormState extends State<DatosUbicacionForm> {
  final DateTime _fechaDiligenciamiento = DateTime.now();
  String formattedFechaDiligenciamiento = '';
  String? _nomDptoAfiliado;
  String? _nomMpioAfiliado;
  String? _direccion;
  String? _codZonaAfiliado;
  String? _ipsPrimariaAfiliado;
  String? _documento;
  final _nombreRecibeVisitaCtrl = TextEditingController();
  String? _tipoDocumentoRecibeVisita;
  final _documentoRecibeVisitaCtrl = TextEditingController();
  final _telefonoFijoCtrl = TextEditingController();
  final _telefonocel1Ctrl = TextEditingController();
  final _telefonocel2Ctrl = TextEditingController();
  int? _perteneceResguardo;
  final _nombreResguardoIndigenaCtrl = TextEditingController();
  int? _autoridadIndigena;
  int? _viaAcceso;
  int? _estadoVia;
  List<LstMediosComunica> _selectedMediosComunicacion = [];

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

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario!;

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    setState(() {
      formattedFechaDiligenciamiento =
          DateFormat('dd-MM-yyyy').format(_fechaDiligenciamiento);
      _nomDptoAfiliado = afiliado.nomDptoAfiliado;
      _nomMpioAfiliado = afiliado.nomMpioAfiliado;
      _direccion = afiliado.direccion;
      _codZonaAfiliado = afiliado.codZonaAfiliado;
      _ipsPrimariaAfiliado = afiliado.ipsPrimariaAfiliado;
      _documento = afiliado.documento;
      _telefonoFijoCtrl.text = afiliado.telefonofijo ?? '';
      _telefonocel1Ctrl.text = afiliado.telefonocel1 ?? '';
      _telefonocel2Ctrl.text = afiliado.telefonocel2 ?? '';

      _nombreRecibeVisitaCtrl.text =
          widget.dimUbicacion?.nombreRecibeVisita ?? usuario.userName;
      _tipoDocumentoRecibeVisita = widget.dimUbicacion?.tipoDocRecibeVisita;
      _documentoRecibeVisitaCtrl.text =
          widget.dimUbicacion?.documentoRecibeVisita ?? '';
      _perteneceResguardo = widget.dimUbicacion?.perteneceResguardo;
      _autoridadIndigena = widget.dimUbicacion?.autoridadIndigenaId;
      _viaAcceso = widget.dimUbicacion?.viaAccesoId;
      _estadoVia = widget.dimUbicacion?.estadoViaId;
    });
    getOptions();
  }

  Future<void> getOptions() async {
    final medioComunicacionCubit = BlocProvider.of<MedioComunicacionCubit>(
      context,
    );
    _selectedMediosComunicacion = await medioComunicacionCubit
        .getUbicacionMediosComunicacionDB(widget.dimUbicacion?.ubicacionId);

    if (mounted) {
      setState(() {});
    }
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
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _nombreRecibeVisitaCtrl,
          decoration: const InputDecoration(
            labelText: 'Nombre de quien recibe la visita',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo Requerido';
            }
            return null;
          },
          onSaved: (String? value) {
            dimUbicacionBloc.add(NombreRecibeVisitaChanged(value!));
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<TipoDocumentoCubit, TiposDocumentoState>(
          builder: (context, state) {
            if (state is TiposDocumentoLoaded) {
              return DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _tipoDocumentoRecibeVisita,
                items: state.tiposDocumento!
                    .map(
                      (tipoDocumento) => DropdownMenuItem<String>(
                        value: tipoDocumento.tipo,
                        child: Text(tipoDocumento.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Tipo documento de quien recibe la visita',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoDocumentoRecibeVisita = newValue;
                  });
                  dimUbicacionBloc.add(TipoDocRecibeVisitaChanged(newValue!));
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
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _documentoRecibeVisitaCtrl,
          decoration: const InputDecoration(
            labelText: 'Documento de quien recibe la visita',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo Requerido';
            }
            return null;
          },
          onSaved: (String? value) {
            dimUbicacionBloc.add(DocumentoRecibeVisitaChanged(value!));
          },
        ),
        /*  const SizedBox(height: 20),
        TextFormField(
          enabled: false,
          initialValue: formattedFechaDiligenciamiento,
          decoration: const InputDecoration(
            labelText: 'Fecha de Diligenciamiento',
            border: OutlineInputBorder(),
          ),
          onSaved: (String? value) {
            //TODO: dimUbicacionBloc.add(FechaDiligenciamientoChanged(newValue!));
          },
        ), */
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
        TextFormField(
          enabled: false,
          initialValue: _codZonaAfiliado,
          decoration: const InputDecoration(
              labelText: 'Zona', border: OutlineInputBorder()),
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
        const Text('Pertenece a algún resguardo indígena'),
        RadioListTile(
          title: const Text('Si'),
          value: 0,
          groupValue: _perteneceResguardo,
          onChanged: (int? value) {
            setState(() {
              _perteneceResguardo = value!;
              dimUbicacionBloc.add(PerteneceResguardoChanged(value));
            });
          },
        ),
        RadioListTile(
          title: const Text('No'),
          value: 1,
          groupValue: _perteneceResguardo,
          onChanged: (int? value) {
            setState(() {
              _perteneceResguardo = value!;
              dimUbicacionBloc.add(PerteneceResguardoChanged(value));
            });
          },
        ),

        /*  const SizedBox(height: 20),
        TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _nombreResguardoIndigenaCtrl,
            decoration: const InputDecoration(
                labelText: 'Nombre del resguardo indígena',
                border: OutlineInputBorder()),
            onSaved: (String? newValue) {
              //TODO: dimUbicacionBloc.add(NombreResguardoChanged(newValue!));
            }), */
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
        const Divider(),
        const Text(
          'MEDIOS COMUNICACIÓN',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<MedioComunicacionCubit, MediosComunicacionState>(
          builder: (context, state) {
            if (state is MediosComunicacionLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedMediosComunicacion,
                builder: (FormFieldState<List<LstMediosComunica>> formstate) {
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
                                value: _selectedMediosComunicacion.any(
                                    (element) =>
                                        element.medioComunicacionId ==
                                        e.medioComunicacionId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.medioComunicacionId == 7) {
                                      _selectedMediosComunicacion = [
                                        LstMediosComunica(
                                            medioComunicacionId:
                                                e.medioComunicacionId)
                                      ];
                                    } else if (value!) {
                                      _selectedMediosComunicacion.removeWhere(
                                          (element) =>
                                              element.medioComunicacionId == 7);
                                      _selectedMediosComunicacion.add(
                                          LstMediosComunica(
                                              medioComunicacionId:
                                                  e.medioComunicacionId));
                                    } else {
                                      _selectedMediosComunicacion.removeWhere(
                                          (element) =>
                                              element.medioComunicacionId ==
                                              e.medioComunicacionId);
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
                onSaved: (List<LstMediosComunica>? value) {
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
