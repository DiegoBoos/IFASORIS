import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/grupo_familiar.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../cubits/curso_vida/curso_vida_cubit.dart';
import '../../cubits/etnia/etnia_cubit.dart';
import '../../cubits/genero/genero_cubit.dart';
import '../../cubits/grupo_riesgo/grupo_riesgo_cubit.dart';
import '../../cubits/lengua_maneja/lengua_maneja_cubit.dart';
import '../../cubits/nivel_educativo/nivel_educativo_cubit.dart';
import '../../cubits/nombre_lengua_materna/nombre_lengua_materna_cubit.dart';
import '../../cubits/ocupacion/ocupacion_cubit.dart';
import '../../cubits/parentesco/parentesco_cubit.dart';
import '../../cubits/pueblo_indigena/pueblo_indigena_cubit.dart';
import '../../cubits/tipo_regimen/tipo_regimen_cubit.dart';
import '../../cubits/tipo_documento/tipo_documento_cubit.dart';
import '../../utils/custom_alerts.dart';
import '../../utils/input_decoration.dart';
import '../../utils/validators/form_validators.dart';

class GrupoFamiliarForm extends StatefulWidget {
  const GrupoFamiliarForm({
    super.key,
    required this.afiliadoGrupoFamiliar,
  });

  final GrupoFamiliarEntity afiliadoGrupoFamiliar;

  @override
  State<GrupoFamiliarForm> createState() => _GrupoFamiliarFormState();
}

class _GrupoFamiliarFormState extends State<GrupoFamiliarForm> {
  final _formKeyGrupoFamiliar = GlobalKey<FormState>();
  int? _tipoDocumentoId;
  String? _documento;
  String? _nombresApellidos;
  int? _generoId;
  DateTime? _fechaNacimiento;
  String formattedFechaNacimiento = '';
  int? _edad;
  int? _cursoVidaId;
  int? _parentescoId;
  int? _tipoRegimenId;
  String? _codTipoRegimenAfiliado;
  int? _nivelEducativoId;
  int? _ocupacionId;
  String? _otroOcupacion;
  bool _showOtroOcupacion = false;
  int? _grupoRiesgoId;
  int? _etniaId;
  int? _puebloIde;
  int? _lenguaManejaId;
  int? _lenguaMaternaId;

  @override
  void initState() {
    super.initState();

    final tipoDocumentoCubit = BlocProvider.of<TipoDocumentoCubit>(context);
    final generoCubit = BlocProvider.of<GeneroCubit>(context);
    final grupoFamiliarBloc = BlocProvider.of<GrupoFamiliarBloc>(context);

    setState(() {
      if (widget.afiliadoGrupoFamiliar.tipoDocumentoId != null) {
        _tipoDocumentoId = widget.afiliadoGrupoFamiliar.tipoDocumentoId;
      } else {
        _tipoDocumentoId = tipoDocumentoCubit.state.tiposDocumento!
            .firstWhere((element) =>
                element.tipo == widget.afiliadoGrupoFamiliar.tipoDocAfiliado)
            .tipoDocumentoId;
      }

      if (widget.afiliadoGrupoFamiliar.generoId != null) {
        _generoId = widget.afiliadoGrupoFamiliar.generoId;
      } else {
        _generoId = generoCubit.state.generos!
            .firstWhere((element) =>
                element.tipo == widget.afiliadoGrupoFamiliar.codGeneroAfiliado)
            .generoId;
      }

      _documento = widget.afiliadoGrupoFamiliar.documento;
      _nombresApellidos =
          '${widget.afiliadoGrupoFamiliar.nombre1} ${widget.afiliadoGrupoFamiliar.nombre2} ${widget.afiliadoGrupoFamiliar.apellido1} ${widget.afiliadoGrupoFamiliar.apellido2}';
      _fechaNacimiento = widget.afiliadoGrupoFamiliar.fechaNacimiento;

      if (_fechaNacimiento != null) {
        formattedFechaNacimiento =
            DateFormat('dd-MM-yyyy').format(_fechaNacimiento!);
      }

      _edad = widget.afiliadoGrupoFamiliar.edad;
      if (_edad != null) {
        calculateCursoVida(_edad!);
      }

      _codTipoRegimenAfiliado =
          widget.afiliadoGrupoFamiliar.codTipoRegimenAfiliado;
      if (_codTipoRegimenAfiliado != null) {
        if (_codTipoRegimenAfiliado == "S") {
          _tipoRegimenId = 1;
        } else if (_codTipoRegimenAfiliado == "C") {
          _tipoRegimenId = 2;
        } else if (_codTipoRegimenAfiliado == "U") {
          _tipoRegimenId = 3;
        }
      } else {
        _tipoRegimenId = widget.afiliadoGrupoFamiliar.tipoRegimenId;
      }

      if (_tipoRegimenId != null) {
        grupoFamiliarBloc.add(TipoRegimenChanged(_tipoRegimenId!));
      }

      _parentescoId = widget.afiliadoGrupoFamiliar.parentescoId;
      if (_parentescoId != null) {
        grupoFamiliarBloc.add(ParentescoChanged(_parentescoId!));
      }

      _nivelEducativoId = widget.afiliadoGrupoFamiliar.nivelEducativoId;
      if (_nivelEducativoId != null) {
        grupoFamiliarBloc.add(NivelEducativoChanged(_nivelEducativoId!));
      }

      _ocupacionId = widget.afiliadoGrupoFamiliar.ocupacionId;
      if (_ocupacionId != null) {
        grupoFamiliarBloc.add(OcupacionChanged(_ocupacionId!));
      }

      _otroOcupacion = widget.afiliadoGrupoFamiliar.otroOcupacion;
      if (_otroOcupacion != null && _otroOcupacion!.isNotEmpty) {
        _showOtroOcupacion = true;
        grupoFamiliarBloc.add(OtroOcupacionChanged(_otroOcupacion));
      }

      _grupoRiesgoId = widget.afiliadoGrupoFamiliar.grupoRiesgoId;
      if (_grupoRiesgoId != null) {
        grupoFamiliarBloc.add(GrupoRiesgoChanged(_grupoRiesgoId!));
      }

      _etniaId = widget.afiliadoGrupoFamiliar.origenEtnico5602Id;
      if (_etniaId != null) {
        grupoFamiliarBloc.add(EtniaChanged(_etniaId!));
      }

      _puebloIde = widget.afiliadoGrupoFamiliar.puebloIndigenaId == 0
          ? null
          : widget.afiliadoGrupoFamiliar.puebloIndigenaId;
      if (_puebloIde != null) {
        grupoFamiliarBloc.add(PuebloIndigenaChanged(_puebloIde!));
      }

      _lenguaManejaId = widget.afiliadoGrupoFamiliar.lenguaManejaId == 0
          ? null
          : widget.afiliadoGrupoFamiliar.lenguaManejaId;
      if (_lenguaManejaId != null) {
        grupoFamiliarBloc.add(LenguaManejaChanged(_lenguaManejaId!));
      }

      _lenguaMaternaId = widget.afiliadoGrupoFamiliar.lenguaMaternaId == 0
          ? null
          : widget.afiliadoGrupoFamiliar.lenguaMaternaId;
      if (_lenguaMaternaId != null) {
        grupoFamiliarBloc.add(LenguaMaternaChanged(_lenguaMaternaId!));
      }
    });
  }

  void calculateCursoVida(int edad) {
    if (edad >= 0 && edad <= 5) {
      _cursoVidaId = 1;
    } else if (edad >= 6 && edad <= 11) {
      _cursoVidaId = 2;
    } else if (edad >= 12 && edad <= 18) {
      _cursoVidaId = 3;
    } else if (edad >= 14 && edad <= 26) {
      _cursoVidaId = 4;
    } else if (edad >= 27 && edad <= 59) {
      _cursoVidaId = 5;
    } else if (edad >= 60) {
      _cursoVidaId = 6;
    }
    BlocProvider.of<GrupoFamiliarBloc>(context)
        .add(CursoVidaChanged(_cursoVidaId!));
  }

  @override
  Widget build(BuildContext context) {
    final grupoFamiliarBloc =
        BlocProvider.of<GrupoFamiliarBloc>(context, listen: true);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Ficha'),
              leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => CustomAlerts.showCustomDialog(
                          context, 'Salir', '¿Desea salir de la ficha?', () {
                        Navigator.pushReplacementNamed(context, 'home');
                      })),
            ),
            body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKeyGrupoFamiliar,
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'III. GRUPO FAMILIAR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TipoDocumentoCubit, TiposDocumentoState>(
                    builder: (context, state) {
                      if (state is TiposDocumentoLoaded) {
                        final tiposDocumentoLoaded =
                            state.tiposDocumentoLoaded!;
                        return DropdownButtonFormField<int>(
                          value: _tipoDocumentoId,
                          items: tiposDocumentoLoaded
                              .map(
                                (tipoDocumento) => DropdownMenuItem<int>(
                                  value: tipoDocumento.tipoDocumentoId,
                                  child: Text(tipoDocumento.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Tipo documento',
                              border: OutlineInputBorder()),
                          onChanged: null,
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: false,
                    initialValue: _documento,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Numero de Documento',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Campo requerido';
                      }

                      final number = int.tryParse(value!);

                      if (number == null) {
                        return 'Sólo números';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    'DATOS DEL USUARIO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: false,
                    initialValue: _nombresApellidos,
                    decoration: const InputDecoration(
                      labelText: 'Integrante Grupo Familiar',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<GeneroCubit, GenerosState>(
                    builder: (context, state) {
                      if (state is GenerosLoaded) {
                        final generosLoaded = state.generosLoaded!;
                        return Column(
                          children: [
                            FormField(
                              initialValue: _generoId,
                              builder: (FormFieldState<int> formstate) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Género'),
                                    Column(
                                      children: generosLoaded
                                          .map(
                                            (e) => RadioListTile<int?>(
                                                title: Text(
                                                  e.descripcion ?? '',
                                                ),
                                                value: e.generoId,
                                                groupValue: _generoId,
                                                onChanged: null),
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
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: false,
                    initialValue: formattedFechaNacimiento,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: false,
                    initialValue: _edad.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Edad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'CURSO DE VIDA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<CursoVidaCubit, CursosVidaState>(
                    builder: (context, state) {
                      if (state is CursosVidaLoaded) {
                        final cursosVidaLoaded = state.cursosVidaLoaded!;
                        return DropdownButtonFormField<int>(
                          value: _cursoVidaId,
                          items: cursosVidaLoaded
                              .map(
                                (cursoVida) => DropdownMenuItem<int>(
                                  value: cursoVida.cursoVidaId,
                                  child: Text(cursoVida.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Curso de vida',
                              border: OutlineInputBorder()),
                          onChanged: null,
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
                  const Divider(),
                  const Text(
                    'PARENTESCO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<ParentescoCubit, ParentescosState>(
                    builder: (context, state) {
                      if (state is ParentescosLoaded) {
                        final parentescosLoaded = state.parentescosLoaded!;
                        return DropdownButtonFormField<int>(
                          value: _parentescoId,
                          items: parentescosLoaded
                              .map(
                                (parentesco) => DropdownMenuItem<int>(
                                  value: parentesco.parentescoId,
                                  child: Text(parentesco.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Parentesco',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _parentescoId = newValue;
                            });
                            grupoFamiliarBloc.add(ParentescoChanged(newValue!));
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
                    'TIPO DE RÉGIMEN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<TipoRegimenCubit, TipoRegimenesState>(
                    builder: (context, state) {
                      if (state is TipoRegimenesLoaded) {
                        final tiporegimenesLoaded = state.tiporegimenesLoaded!;

                        return DropdownButtonFormField<int>(
                          value: _tipoRegimenId,
                          items: tiporegimenesLoaded
                              .map(
                                (tiporegimen) => DropdownMenuItem<int>(
                                  value: tiporegimen.regimenId,
                                  child: Text(tiporegimen.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Tipo régimen',
                              border: OutlineInputBorder()),
                          onChanged: null,
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
                    'NIVEL EDUCATIVO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<NivelEducativoCubit, NivelesEducativosState>(
                    builder: (context, state) {
                      if (state is NivelesEducativosLoaded) {
                        final nivelesEducativosLoaded =
                            state.nivelesEducativosLoaded!;

                        return DropdownButtonFormField<int>(
                          value: _nivelEducativoId,
                          items: nivelesEducativosLoaded
                              .map(
                                (nivelEducativo) => DropdownMenuItem<int>(
                                  value: nivelEducativo.nivelEducativoId,
                                  child: Text(nivelEducativo.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Nivel educativo',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _nivelEducativoId = newValue;
                            });
                            grupoFamiliarBloc
                                .add(NivelEducativoChanged(newValue!));
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
                    'OCUPACIÓN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<OcupacionCubit, OcupacionesState>(
                    builder: (context, state) {
                      if (state is OcupacionesLoaded) {
                        final ocupacionesLoaded = state.ocupacionesLoaded!;

                        int? otroId;

                        for (var e in ocupacionesLoaded) {
                          final optionType =
                              FormValidators.optionType(e.descripcion ?? '');
                          if (optionType == 'O') {
                            otroId = e.ocupacionId;
                          }
                        }

                        return DropdownButtonFormField<int>(
                          value: _ocupacionId,
                          items: ocupacionesLoaded
                              .map(
                                (ocupacion) => DropdownMenuItem<int>(
                                  value: ocupacion.ocupacionId,
                                  child: Text(ocupacion.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Ocupación',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _ocupacionId = newValue;
                              if (newValue == otroId) {
                                _showOtroOcupacion = true;
                              } else {
                                _showOtroOcupacion = false;
                                _otroOcupacion = null;
                                grupoFamiliarBloc
                                    .add(const OtroOcupacionChanged(''));
                              }
                            });

                            grupoFamiliarBloc.add(OcupacionChanged(
                              newValue!,
                            ));
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
                  if (_showOtroOcupacion)
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: TextFormField(
                        initialValue:
                            grupoFamiliarBloc.state.otroOcupacion ?? '',
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cuál', labelText: 'Cuál'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          setState(() {
                            _otroOcupacion = value;
                          });

                          grupoFamiliarBloc
                              .add(OtroOcupacionChanged(_otroOcupacion));
                        },
                      ),
                    ),
                  const Divider(),
                  const Text(
                    'GRUPO DE RIESGO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<GrupoRiesgoCubit, GruposRiesgoState>(
                    builder: (context, state) {
                      if (state is GruposRiesgoLoaded) {
                        final gruposRiesgoLoaded = state.gruposRiesgoLoaded!;

                        return DropdownButtonFormField<int>(
                          value: _grupoRiesgoId,
                          items: gruposRiesgoLoaded
                              .map(
                                (grupoRiesgo) => DropdownMenuItem<int>(
                                  value: grupoRiesgo.grupoRiesgoId,
                                  child: Text(grupoRiesgo.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Grupo de riesgo',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            setState(() {
                              _grupoRiesgoId = newValue;
                            });
                            grupoFamiliarBloc
                                .add(GrupoRiesgoChanged(newValue!));
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
                    'ETNIA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<EtniaCubit, EtniasState>(
                    builder: (context, state) {
                      if (state is EtniasLoaded) {
                        final etniasLoaded = state.etniasLoaded!;

                        return DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: _etniaId,
                          items: etniasLoaded
                              .map(
                                (etnia) => DropdownMenuItem<int>(
                                  value: etnia.etniaId,
                                  child: Text(etnia.descripcion ?? ''),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Etnia', border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
                            if (newValue != 2) {
                              setState(() {
                                _puebloIde = null;
                                _lenguaManejaId = null;
                                _lenguaMaternaId = null;
                              });

                              grupoFamiliarBloc
                                  .add(const PuebloIndigenaChanged(0));
                              grupoFamiliarBloc
                                  .add(const LenguaManejaChanged(0));
                              grupoFamiliarBloc
                                  .add(const LenguaMaternaChanged(0));
                            }

                            setState(() {
                              _etniaId = newValue;
                            });

                            grupoFamiliarBloc.add(EtniaChanged(newValue!));
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
                  if (_etniaId == 2)
                    Column(
                      children: [
                        const Divider(),
                        const Text(
                          'PUEBLO INDÍGENA QUE PERTENECE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(),
                        BlocBuilder<PuebloIndigenaCubit, PueblosIndigenasState>(
                          builder: (context, state) {
                            if (state is PueblosIndigenasLoaded) {
                              final pueblosIndigenasLoaded =
                                  state.pueblosIndigenasLoaded!;

                              return DropdownButtonFormField<int>(
                                isExpanded: true,
                                value: _puebloIde,
                                items: pueblosIndigenasLoaded
                                    .map(
                                      (puebloIndigena) => DropdownMenuItem<int>(
                                        value: puebloIndigena.puebloIde,
                                        child: Text(
                                            puebloIndigena.descripcion ?? ''),
                                      ),
                                    )
                                    .toList(),
                                decoration: const InputDecoration(
                                    labelText: 'Pueblo indígena',
                                    border: OutlineInputBorder()),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _puebloIde = newValue;
                                  });
                                  grupoFamiliarBloc
                                      .add(PuebloIndigenaChanged(newValue!));
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
                          'LENGUA QUE MANEJA',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(),
                        BlocBuilder<LenguaManejaCubit, LenguasManejaState>(
                          builder: (context, state) {
                            if (state is LenguasManejaLoaded) {
                              final lenguasManejaLoaded =
                                  state.lenguasManejaLoaded!;

                              return DropdownButtonFormField<int>(
                                value: _lenguaManejaId,
                                items: lenguasManejaLoaded
                                    .map(
                                      (lenguaManeja) => DropdownMenuItem<int>(
                                        value: lenguaManeja.lenguaManejaId,
                                        child: Text(
                                            lenguaManeja.descripcion ?? ''),
                                      ),
                                    )
                                    .toList(),
                                decoration: const InputDecoration(
                                    labelText: 'Lengua que maneja',
                                    border: OutlineInputBorder()),
                                onChanged: (int? newValue) {
                                  if (newValue == 2) {
                                    setState(() {
                                      _lenguaMaternaId = null;
                                    });

                                    grupoFamiliarBloc
                                        .add(const LenguaMaternaChanged(0));
                                  }
                                  setState(() {
                                    _lenguaManejaId = newValue;
                                  });
                                  grupoFamiliarBloc
                                      .add(LenguaManejaChanged(newValue!));
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
                        if (_lenguaManejaId != 2)
                          Column(
                            children: [
                              const Divider(),
                              const Text(
                                'LENGUA MATERNA',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const Divider(),
                              BlocBuilder<NombreLenguaMaternaCubit,
                                  NombresLenguasMaternaState>(
                                builder: (context, state) {
                                  if (state is NombresLenguasMaternaLoaded) {
                                    final nombresLenguasMaternaLoaded =
                                        state.nombresLenguasMaternaLoaded!;

                                    return DropdownButtonFormField<int>(
                                      value: _lenguaMaternaId,
                                      items: nombresLenguasMaternaLoaded
                                          .map(
                                            (lenguaMaterna) =>
                                                DropdownMenuItem<int>(
                                              value:
                                                  lenguaMaterna.lenguaMaternaId,
                                              child: Text(
                                                  lenguaMaterna.descripcion ??
                                                      ''),
                                            ),
                                          )
                                          .toList(),
                                      decoration: const InputDecoration(
                                          labelText: 'Lengua materna',
                                          border: OutlineInputBorder()),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          _lenguaMaternaId = newValue;
                                        });
                                        grupoFamiliarBloc.add(
                                            LenguaMaternaChanged(newValue!));
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
                            ],
                          ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  MaterialButton(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        if (_formKeyGrupoFamiliar.currentState!.validate()) {
                          _formKeyGrupoFamiliar.currentState!.save();

                          final afiliadoPrefsBloc =
                              BlocProvider.of<AfiliadoPrefsBloc>(context);

                          final newEditAfiliado =
                              grupoFamiliarBloc.state.copyWith(
                            grupoFamiliarId:
                                widget.afiliadoGrupoFamiliar.grupoFamiliarId,
                            familiaId:
                                afiliadoPrefsBloc.state.afiliado?.familiaId,
                            afiliadoId: widget.afiliadoGrupoFamiliar.afiliadoId,
                            tipoDocumentoId: _tipoDocumentoId,
                            documento: _documento,
                            generoId: _generoId,
                            fechaNacimiento: _fechaNacimiento,
                            edad: _edad,
                            nombre1: widget.afiliadoGrupoFamiliar.nombre1,
                            nombre2: widget.afiliadoGrupoFamiliar.nombre2,
                            apellido1: widget.afiliadoGrupoFamiliar.apellido1,
                            apellido2: widget.afiliadoGrupoFamiliar.apellido2,
                            tipoDocAfiliado:
                                widget.afiliadoGrupoFamiliar.tipoDocAfiliado,
                            codGeneroAfiliado:
                                widget.afiliadoGrupoFamiliar.codGeneroAfiliado,
                            codTipoRegimenAfiliado: widget
                                .afiliadoGrupoFamiliar.codTipoRegimenAfiliado,
                          );

                          grupoFamiliarBloc.add(
                            SaveAfiliadoGrupoFamiliar(newEditAfiliado),
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: const Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            )));
  }
}
