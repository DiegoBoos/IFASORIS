import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
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
import '../../cubits/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_cubit.dart';
import '../../cubits/regimen/regimen_cubit.dart';
import '../../cubits/tipo_documento/tipo_documento_cubit.dart';

class GrupoFamiliarForm extends StatefulWidget {
  const GrupoFamiliarForm({
    super.key,
    this.afiliadoGrupoFamiliar,
  });

  final GrupoFamiliarEntity? afiliadoGrupoFamiliar;

  @override
  State<GrupoFamiliarForm> createState() => _GrupoFamiliarFormState();
}

class _GrupoFamiliarFormState extends State<GrupoFamiliarForm> {
  final _formKeyGrupoFamiliar = GlobalKey<FormState>();
  String? _tipoDocumento;
  String? _documento;
  String? _nombresApellidos;
  String? _genero;
  DateTime? _fechaNac;
  String formattedFechaNac = '';
  int? _edad;
  int? _cursoVidaId;
  int? _parentescoId;
  int? _tipoRegimenId;
  String? _codRegimenAfiliado;
  int? _nivelEducativoId;
  int? _ocupacionId;
  int? _grupoRiesgoId;
  int? _etniaId;
  int? _puebloIde;
  int? _lenguaManejaId;
  int? _lenguaMaternaId;

  @override
  void initState() {
    super.initState();

    setState(() {
      _tipoDocumento = widget.afiliadoGrupoFamiliar?.tipoDocumento;
      _documento = widget.afiliadoGrupoFamiliar?.documento;
      _nombresApellidos =
          '${widget.afiliadoGrupoFamiliar?.nombre1 ?? ''} ${widget.afiliadoGrupoFamiliar?.nombre2 ?? ''} ${widget.afiliadoGrupoFamiliar?.apellido1 ?? ''} ${widget.afiliadoGrupoFamiliar?.apellido2 ?? ''}';
      _genero = widget.afiliadoGrupoFamiliar?.genero;
      _fechaNac = widget.afiliadoGrupoFamiliar?.fechaNac;

      if (_fechaNac != null) {
        formattedFechaNac = DateFormat('dd-MM-yyyy').format(_fechaNac!);
      }

      _edad = widget.afiliadoGrupoFamiliar?.edad;
      if (_edad != null) {
        calculateCursoVida(_edad!);
      }

      _codRegimenAfiliado = widget.afiliadoGrupoFamiliar?.codRegimenAfiliado;
      if (_codRegimenAfiliado != null) {
        if (_codRegimenAfiliado == "S") {
          _tipoRegimenId = 1;
        } else if (_codRegimenAfiliado == "C") {
          _tipoRegimenId = 2;
        } else if (_codRegimenAfiliado == "U") {
          _tipoRegimenId = 3;
        }
        BlocProvider.of<GrupoFamiliarBloc>(context)
            .add(TipoRegimenChanged(_tipoRegimenId!));
      }

      _parentescoId = widget.afiliadoGrupoFamiliar?.parentescoId;
      _nivelEducativoId = widget.afiliadoGrupoFamiliar?.nivelEducativoId;
      _ocupacionId = widget.afiliadoGrupoFamiliar?.ocupacionId;
      _grupoRiesgoId = widget.afiliadoGrupoFamiliar?.grupoRiesgoId;
      _etniaId = widget.afiliadoGrupoFamiliar?.origenEtnico5602Id;
      //TODO: validation pending
      _puebloIde = widget.afiliadoGrupoFamiliar?.puebloIndigenaId == 0
          ? null
          : widget.afiliadoGrupoFamiliar?.puebloIndigenaId;
      _lenguaManejaId = widget.afiliadoGrupoFamiliar?.lenguaManejaId == 0
          ? null
          : widget.afiliadoGrupoFamiliar?.lenguaManejaId;
      _lenguaMaternaId = widget.afiliadoGrupoFamiliar?.lenguaMaternaId == 0
          ? null
          : widget.afiliadoGrupoFamiliar?.lenguaMaternaId;
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
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);

    final grupoFamiliarBloc =
        BlocProvider.of<GrupoFamiliarBloc>(context, listen: true);

    final afiliadoPrefsBloc =
        BlocProvider.of<AfiliadoPrefsBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha'),
      ),
      body: Form(
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TipoDocumentoCubit, TiposDocumentoState>(
              builder: (context, state) {
                if (state is TiposDocumentoLoaded) {
                  return DropdownButtonFormField<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _tipoDocumento,
                    items: state.tiposDocumento!
                        .map(
                          (tipoDocumento) => DropdownMenuItem<String>(
                            value: tipoDocumento.tipo,
                            child: Text(tipoDocumento.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Tipo documento',
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
                labelText: 'Apellidos y Nombres',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GeneroCubit, GenerosState>(
              builder: (context, state) {
                if (state is GenerosLoaded) {
                  return Column(
                    children: [
                      FormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _genero,
                        builder: (FormFieldState<String> formstate) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Género'),
                              Column(
                                children: state.generosLoaded!
                                    .map(
                                      (e) => RadioListTile<String>(
                                          title: Text(
                                            e.descripcion,
                                          ),
                                          value: e.tipo,
                                          groupValue: _genero,
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
              initialValue: formattedFechaNac,
              decoration: const InputDecoration(
                labelText: 'Fecha de Nacimiento',
                border: OutlineInputBorder(),
              ),
              onSaved: (String? value) {
                //TODO:  grupoFamiliarBloc.add(FechaNacChanged(newValue!));
              },
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
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _cursoVidaId,
                    items: state.cursosVidaLoaded!
                        .map(
                          (cursoVida) => DropdownMenuItem<int>(
                            value: cursoVida.cursoVidaId,
                            child: Text(cursoVida.descripcion),
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
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _parentescoId,
                    items: state.parentescosLoaded!
                        .map(
                          (parentesco) => DropdownMenuItem<int>(
                            value: parentesco.parentescoId,
                            child: Text(parentesco.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Parentesco', border: OutlineInputBorder()),
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
            BlocBuilder<RegimenCubit, RegimenesState>(
              builder: (context, state) {
                if (state is RegimenesLoaded) {
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _tipoRegimenId,
                    items: state.regimenesLoaded!
                        .map(
                          (regimen) => DropdownMenuItem<int>(
                            value: regimen.tipoRegimenId,
                            child: Text(regimen.descripcion),
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
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _nivelEducativoId,
                    items: state.nivelesEducativosLoaded!
                        .map(
                          (nivelEducativo) => DropdownMenuItem<int>(
                            value: nivelEducativo.nivelEducativoId,
                            child: Text(nivelEducativo.descripcion),
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
                      grupoFamiliarBloc.add(NivelEducativoChanged(newValue!));
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
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _ocupacionId,
                    items: state.ocupacionesLoaded!
                        .map(
                          (ocupacion) => DropdownMenuItem<int>(
                            value: ocupacion.ocupacionId,
                            child: Text(ocupacion.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Ocupación', border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _ocupacionId = newValue;
                      });
                      grupoFamiliarBloc.add(OcupacionChanged(newValue!));
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
              'GRUPO DE RIESGO',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<GrupoRiesgoCubit, GruposRiesgoState>(
              builder: (context, state) {
                if (state is GruposRiesgoLoaded) {
                  return DropdownButtonFormField<int>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _grupoRiesgoId,
                    items: state.gruposRiesgoLoaded!
                        .map(
                          (grupoRiesgo) => DropdownMenuItem<int>(
                            value: grupoRiesgo.grupoRiesgoId,
                            child: Text(grupoRiesgo.descripcion),
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
                      grupoFamiliarBloc.add(GrupoRiesgoChanged(newValue!));
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
                  return DropdownButtonFormField<int>(
                    isExpanded: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: _etniaId,
                    items: state.etniasLoaded!
                        .map(
                          (etnia) => DropdownMenuItem<int>(
                            value: etnia.etniaId,
                            child: Text(etnia.descripcion),
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Etnia', border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _etniaId = newValue;
                        if (_etniaId != 2) {
                          _puebloIde = null;
                          grupoFamiliarBloc.add(const PuebloIndigenaChanged(0));

                          _lenguaManejaId = null;
                          grupoFamiliarBloc.add(const LenguaManejaChanged(0));

                          _lenguaMaternaId = null;
                          grupoFamiliarBloc.add(const LenguaMaternaChanged(0));
                        }
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
                        return DropdownButtonFormField<int>(
                          isExpanded: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: _puebloIde,
                          items: state.pueblosIndigenasLoaded!
                              .map(
                                (puebloIndigena) => DropdownMenuItem<int>(
                                  value: puebloIndigena.puebloIde,
                                  child: Text(
                                      puebloIndigena.TPS_CMD_IND_RSG_NOMBRE),
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
                        return DropdownButtonFormField<int>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: _lenguaManejaId,
                          items: state.lenguasManejaLoaded!
                              .map(
                                (lenguaManeja) => DropdownMenuItem<int>(
                                  value: lenguaManeja.lenguaManejaId,
                                  child: Text(lenguaManeja.descripcion),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Lengua que maneja',
                              border: OutlineInputBorder()),
                          onChanged: (int? newValue) {
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
                        return DropdownButtonFormField<int>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          value: _lenguaMaternaId,
                          items: state.nombresLenguasMaternaLoaded!
                              .map(
                                (lenguaMaterna) => DropdownMenuItem<int>(
                                  value: lenguaMaterna.lenguaMaternaId,
                                  child: Text(lenguaMaterna.descripcion),
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
                            grupoFamiliarBloc
                                .add(LenguaMaternaChanged(newValue!));
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
            const SizedBox(height: 20),
            MaterialButton(
                elevation: 0,
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (_formKeyGrupoFamiliar.currentState!.validate()) {
                    _formKeyGrupoFamiliar.currentState!.save();

                    final newEditAfiliado = grupoFamiliarBloc.state.copyWith(
                        tipoDocumento:
                            widget.afiliadoGrupoFamiliar!.tipoDocumento,
                        documento: widget.afiliadoGrupoFamiliar!.documento,
                        nombre1: widget.afiliadoGrupoFamiliar!.nombre1,
                        nombre2: widget.afiliadoGrupoFamiliar!.nombre2,
                        apellido1: widget.afiliadoGrupoFamiliar!.apellido1,
                        apellido2: widget.afiliadoGrupoFamiliar!.apellido2,
                        genero: widget.afiliadoGrupoFamiliar!.genero,
                        fechaNac: widget.afiliadoGrupoFamiliar!.fechaNac,
                        edad: widget.afiliadoGrupoFamiliar!.edad,
                        codRegimenAfiliado:
                            widget.afiliadoGrupoFamiliar!.codRegimenAfiliado,
                        afiliadoId: widget.afiliadoGrupoFamiliar!.afiliadoId,
                        familiaId: afiliadoPrefsBloc.state.afiliado!.familiaId,
                        isCompleted: true);

                    afiliadosGrupoFamiliarBloc.add(
                        CreateOrUpdateAfiliadoGrupoFamiliar(newEditAfiliado));
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
      ),
    );
  }
}
