import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/entities/grupo_familiar_entity.dart';

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
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
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
  int? _familiaRegistro;
  int? _tipoDocumento;
  String? _documento;
  String? _nombresApellidos;
  int? _genero;
  int? _cursoVidaId;
  String? formattedFechaNac;
  String? _edad;
  int? _parentescoId;
  int? _tipoRegimenId;
  int? _nivelEducativoId;
  int? _ocupacionId;
  int? _grupoRiesgoId;
  int? _etniaId;
  int? _puebloIndigenaId;
  int? _lenguaManejaId;
  int? _nombreLenguaMaternaId;

  @override
  Widget build(BuildContext context) {
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);

    /* Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(widget.afiliadoGrupoFamiliar!.afiliadoId.toString())),
          Center(
              child: TextButton(
                  onPressed: () {
                    afiliadosGrupoFamiliarBloc.add(UpdateAfiliadoGrupoFamiliar(
                        widget.afiliadoGrupoFamiliar!
                            .copyWith(isCompleted: true)));
                  },
                  child: const Text('Completar'))),
          Center(
              child: TextButton(
                  onPressed: () {
                    widget.afiliadoGrupoFamiliar!.isCompleted = false;
                    afiliadosGrupoFamiliarBloc.add(UpdateAfiliadoGrupoFamiliar(
                        widget.afiliadoGrupoFamiliar!
                            .copyWith(isCompleted: false)));
                  },
                  child: const Text('Desactivar')))), */

    final grupoFamiliarBloc = BlocProvider.of<GrupoFamiliarBloc>(context);

    return Column(
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
        BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
          builder: (context, state) {
            if (state is OpcionesSiNoLoaded) {
              return Column(
                children: [
                  FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _familiaRegistro,
                    builder: (FormFieldState<int> formstate) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              'Tiene miembros en la familia para registrar'),
                          Column(
                            children: state.opcionesSiNo!
                                .map(
                                  (e) => RadioListTile(
                                    title: Text(
                                      e.descripcion,
                                    ),
                                    value: e.opcionId,
                                    groupValue: _familiaRegistro,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _familiaRegistro = value;
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
                    onSaved: (int? newValue) {
                      grupoFamiliarBloc.add(FamiliaRegistroChanged(newValue!));
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<TipoDocumentoCubit, TiposDocumentoState>(
          builder: (context, state) {
            if (state is TiposDocumentoLoaded) {
              return DropdownButtonFormField<int>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _tipoDocumento,
                items: state.tiposDocumento!
                    .map(
                      (tipoDocumento) => DropdownMenuItem<int>(
                        value: tipoDocumento.tipoDocumentoId,
                        child: Text(tipoDocumento.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Tipo documento', border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _tipoDocumento = newValue;
                  });
                  grupoFamiliarBloc.add(TipoDocumentoChanged(newValue!));
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
          initialValue: _documento,
          decoration: const InputDecoration(
              labelText: 'Numero de Documento', border: OutlineInputBorder()),
          onSaved: (String? newValue) {
            grupoFamiliarBloc.add(DocumentoChanged(newValue!));
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
          initialValue: _nombresApellidos,
          decoration: const InputDecoration(
            labelText: 'Apellidos y Nombres',
            border: OutlineInputBorder(),
          ),
          onSaved: (String? newValue) {
            grupoFamiliarBloc.add(NombresApellidosChanged(newValue!));
          },
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
                    builder: (FormFieldState<int> formstate) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Género'),
                          Column(
                            children: state.generosLoaded!
                                .map(
                                  (e) => RadioListTile(
                                    title: Text(
                                      e.descripcion,
                                    ),
                                    value: e.generoId,
                                    groupValue: _genero,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _genero = value;
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
                      grupoFamiliarBloc.add(GeneroChanged(value!));
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
          initialValue: formattedFechaNac,
          decoration: const InputDecoration(
            labelText: 'Fecha de nacimiento',
            border: OutlineInputBorder(),
          ),
          onSaved: (String? newValue) {
            grupoFamiliarBloc.add(FechaNacChanged(newValue!));
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: _edad,
          decoration: const InputDecoration(
            labelText: 'Edad',
            border: OutlineInputBorder(),
          ),
          onSaved: (String? newValue) {
            grupoFamiliarBloc.add(EdadChanged(newValue!));
          },
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _cursoVidaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.cursosVidaLoaded!.length,
                          (index) {
                            final e = state.cursosVidaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _cursoVidaId == e.cursoVidaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _cursoVidaId =
                                          value! ? e.cursoVidaId : null;
                                      formstate.didChange(_cursoVidaId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index < state.cursosVidaLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(CursoVidaChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _parentescoId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.parentescosLoaded!.length,
                          (index) {
                            final e = state.parentescosLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _parentescoId == e.parentescoId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _parentescoId =
                                          value! ? e.parentescoId : null;
                                      formstate.didChange(_parentescoId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index < state.parentescosLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(ParentescoChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _tipoRegimenId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.regimenesLoaded!.length,
                          (index) {
                            final e = state.regimenesLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _tipoRegimenId == e.tipoRegimenId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _tipoRegimenId =
                                          value! ? e.tipoRegimenId : null;
                                      formstate.didChange(_tipoRegimenId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index < state.regimenesLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(RegimenChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _nivelEducativoId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.nivelesEducativosLoaded!.length,
                          (index) {
                            final e = state.nivelesEducativosLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value:
                                      _nivelEducativoId == e.nivelEducativoId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _nivelEducativoId =
                                          value! ? e.nivelEducativoId : null;
                                      formstate.didChange(_nivelEducativoId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.nivelesEducativosLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(NivelEducativoChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _ocupacionId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.ocupacionesLoaded!.length,
                          (index) {
                            final e = state.ocupacionesLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _ocupacionId == e.ocupacionId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _ocupacionId =
                                          value! ? e.ocupacionId : null;
                                      formstate.didChange(_ocupacionId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index < state.ocupacionesLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(OcupacionChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _grupoRiesgoId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.gruposRiesgoLoaded!.length,
                          (index) {
                            final e = state.gruposRiesgoLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _grupoRiesgoId == e.grupoRiesgoId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _grupoRiesgoId =
                                          value! ? e.grupoRiesgoId : null;
                                      formstate.didChange(_grupoRiesgoId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.gruposRiesgoLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(GrupoRiesgoChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _etniaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.etniasLoaded!.length,
                          (index) {
                            final e = state.etniasLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _etniaId == e.etniaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _etniaId = value! ? e.etniaId : null;
                                      formstate.didChange(_etniaId);
                                    });
                                  },
                                ),
                                Text(
                                  e.descripcion,
                                ),
                                if (index < state.etniasLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(EtniaChanged(value!));
                },
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'PUEBLO INDÍGENA QUE PERTENECE',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<PuebloIndigenaByDptoCubit, PueblosIndigenasByDptoState>(
          builder: (context, state) {
            if (state is PueblosIndigenasByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _puebloIndigenaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.pueblosIndigenasByDptoLoaded!.length,
                          (index) {
                            final e =
                                state.pueblosIndigenasByDptoLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value:
                                      _puebloIndigenaId == e.puebloIndigenaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _puebloIndigenaId =
                                          value! ? e.puebloIndigenaId : null;
                                      formstate.didChange(_puebloIndigenaId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.pueblosIndigenasByDptoLoaded!.length -
                                        1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(PuebloIndigenaChanged(value!));
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
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _lenguaManejaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.lenguasManejaLoaded!.length,
                          (index) {
                            final e = state.lenguasManejaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _lenguaManejaId == e.lenguaManejaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _lenguaManejaId =
                                          value! ? e.lenguaManejaId : null;
                                      formstate.didChange(_lenguaManejaId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.lenguasManejaLoaded!.length - 1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(LenguaManejaChanged(value!));
                },
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'NOMBRE LENGUA MATERNA',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<NombreLenguaMaternaCubit, NombresLenguasMaternaState>(
          builder: (context, state) {
            if (state is NombresLenguasMaternaLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _nombreLenguaMaternaId,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.nombresLenguasMaternaLoaded!.length,
                          (index) {
                            final e = state.nombresLenguasMaternaLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _nombreLenguaMaternaId ==
                                      e.lenguaMaternaId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _nombreLenguaMaternaId =
                                          value! ? e.lenguaMaternaId : null;
                                      formstate
                                          .didChange(_nombreLenguaMaternaId);
                                    });
                                  },
                                ),
                                Text(e.descripcion),
                                if (index <
                                    state.nombresLenguasMaternaLoaded!.length -
                                        1)
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
                onSaved: (int? value) {
                  grupoFamiliarBloc.add(NombreLenguaMaternaChanged(value!));
                },
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
