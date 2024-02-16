import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/medio_comunicacion_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/estado_via/estado_via_exports.dart';
import '../../../domain/usecases/tipo_documento/tipo_documento_exports.dart';
import '../../../domain/usecases/via_acceso/via_acceso_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/resguardo/resguardo_cubit.dart';
import '../helpers/medios_comunicacion_helper.dart';

class DatosUbicacionForm extends StatefulWidget {
  const DatosUbicacionForm({super.key, required this.dimUbicacion});

  final DimUbicacionEntity dimUbicacion;

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
  int? _resguardoId;
  int? _autoridadIndigena;
  int? _viaAcceso;
  int? _estadoVia;

  @override
  void initState() {
    super.initState();

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
          widget.dimUbicacion.nombreRecibeVisita ?? '';
      _tipoDocumentoRecibeVisita = widget.dimUbicacion.tipoDocRecibeVisita;
      _documentoRecibeVisitaCtrl.text =
          widget.dimUbicacion.documentoRecibeVisita ?? '';
      _perteneceResguardo = widget.dimUbicacion.perteneceResguardo;
      _resguardoId = widget.dimUbicacion.resguardoId == 0
          ? null
          : widget.dimUbicacion.resguardoId;
      _autoridadIndigena = widget.dimUbicacion.autoridadIndigenaId;
      _viaAcceso = widget.dimUbicacion.viaAccesoId;
      _estadoVia = widget.dimUbicacion.estadoViaId;
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
        TextFormField(
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
          onChanged: (String? value) {
            dimUbicacionBloc.add(NombreRecibeVisitaChanged(value!));
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<TipoDocumentoCubit, TiposDocumentoState>(
          builder: (context, state) {
            if (state is TiposDocumentoLoaded) {
              final tiposDocumentoLoaded = state.tiposDocumentoLoaded!;

              return DropdownButtonFormField<String>(
                value: _tipoDocumentoRecibeVisita,
                items: tiposDocumentoLoaded
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
          keyboardType: TextInputType.number,
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
          onChanged: (String? value) {
            dimUbicacionBloc.add(DocumentoRecibeVisitaChanged(value!));
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          enabled: false,
          initialValue: formattedFechaDiligenciamiento,
          decoration: const InputDecoration(
            labelText: 'Fecha de Diligenciamiento',
            border: OutlineInputBorder(),
          ),
          onChanged: (String? value) {
            //TODO: dimUbicacionBloc.add(FechaDiligenciamientoChanged(newValue!));
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
        const Divider(),
        const Text(
          'Pertenece a algún resguardo indígena',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
          builder: (context, state) {
            if (state is OpcionesSiNoLoaded) {
              final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

              return FormField(
                initialValue: _perteneceResguardo,
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
                                      groupValue: _perteneceResguardo,
                                      onChanged: (int? newValue) {
                                        if (newValue == 2) {
                                          _resguardoId = null;
                                          dimUbicacionBloc
                                              .add(const ResguardoChanged(0));
                                        }
                                        setState(() {
                                          _perteneceResguardo = newValue!;
                                        });
                                        formstate.didChange(newValue);
                                        dimUbicacionBloc.add(
                                            PerteneceResguardoChanged(
                                                newValue!));
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
        if (_perteneceResguardo == 1)
          BlocBuilder<ResguardoCubit, ResguardosState>(
            builder: (context, state) {
              if (state is ResguardosLoaded) {
                final resguardosLoaded = state.resguardosLoaded!;

                return DropdownButtonFormField<int>(
                  isExpanded: true,
                  value: _resguardoId,
                  items: resguardosLoaded
                      .map(
                        (resguardo) => DropdownMenuItem<int>(
                          value: resguardo.resguardoId,
                          child: Text(resguardo.nombreResguardo),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                      labelText: 'Resguardo', border: OutlineInputBorder()),
                  onChanged: (int? newValue) {
                    setState(() {
                      _resguardoId = newValue;
                    });
                    dimUbicacionBloc.add(ResguardoChanged(newValue!));
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
        BlocBuilder<AutoridadIndigenaCubit, AutoridadesIndigenasState>(
          builder: (context, state) {
            if (state is AutoridadesIndigenasLoaded) {
              final autoridadesIndigenasLoaded = state.autoridadesIndigenas!;

              return DropdownButtonFormField<int>(
                value: _autoridadIndigena,
                items: autoridadesIndigenasLoaded
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
              final viasAccesoLoaded = state.viasAccesoLoaded!;

              return DropdownButtonFormField<int>(
                value: _viaAcceso,
                items: viasAccesoLoaded
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
              final estadosViasLoaded = state.estadosViasLoaded!;

              return DropdownButtonFormField<int>(
                value: _estadoVia,
                items: estadosViasLoaded
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
              final mediosComunicacionLoaded = state.mediosComunicacionLoaded!;
              int? ningunoId;

              for (var e in mediosComunicacionLoaded) {
                if (e.descripcion == 'Ninguno') {
                  ningunoId = e.medioComunicacionId;
                }
              }

              return FormField<List<LstMediosComunica>>(
                initialValue: dimUbicacionBloc.state.lstMediosComunica,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstMediosComunica>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          mediosComunicacionLoaded.length,
                          (index) {
                            final medioComunicacion =
                                mediosComunicacionLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((e) =>
                                          e.medioComunicacionId ==
                                          medioComunicacion
                                              .medioComunicacionId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    handleMediosComunicacionSelection(
                                        formState,
                                        ningunoId,
                                        context,
                                        value,
                                        medioComunicacion.medioComunicacionId,
                                        dimUbicacionBloc);
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    medioComunicacion.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index < mediosComunicacionLoaded.length - 1)
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
      ],
    );
  }
}
