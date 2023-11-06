import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
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
import '../../cubits/pueblo_indigena/pueblo_indigena_cubit.dart';
import '../../cubits/regimen/regimen_cubit.dart';
import '../../cubits/tipo_documento/tipo_documento_cubit.dart';
import '../../search/search_afiliados.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/grupo_familiar_form.dart';

class GrupoFamiliarPage extends StatefulWidget {
  const GrupoFamiliarPage({super.key});

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarState();
}

class _GrupoFamiliarState extends State<GrupoFamiliarPage> {
  @override
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;
    BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context)
        .add(ExisteAfiliadoCabezaFamilia(afiliado.afiliadoId!));

    getAccesoriasGrupoFamiliar();
  }

  getAccesoriasGrupoFamiliar() {
    BlocProvider.of<TipoDocumentoCubit>(context).getTiposDocumentoDB();
    BlocProvider.of<GeneroCubit>(context).getGenerosDB();
    BlocProvider.of<CursoVidaCubit>(context).getCursosVidaDB();
    BlocProvider.of<ParentescoCubit>(context).getParentescosDB();
    BlocProvider.of<RegimenCubit>(context).getRegimenesDB();
    BlocProvider.of<NivelEducativoCubit>(context).getNivelesEducativosDB();
    BlocProvider.of<OcupacionCubit>(context).getOcupacionesDB();
    BlocProvider.of<GrupoRiesgoCubit>(context).getGruposRiesgoDB();
    BlocProvider.of<EtniaCubit>(context).getEtniasDB();
    BlocProvider.of<PuebloIndigenaCubit>(context).getPueblosIndigenasDB();
    BlocProvider.of<LenguaManejaCubit>(context).getLenguasManejaDB();
    BlocProvider.of<NombreLenguaMaternaCubit>(context)
        .getNombresLenguasMaternaDB();
  }

  void submitForm() {
    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(
      context,
    );

    final afiliadosGrupoFamiliar =
        afiliadosGrupoFamiliarBloc.state.afiliadosGrupoFamiliar;

    if (afiliadosGrupoFamiliar != null) {
      Navigator.pushReplacementNamed(context, 'estilo-vida-saludable');
    } else {
      afiliadosGrupoFamiliarBloc.add(const ErrorAfiliadosGrupoFamiliar(
          'No hay afiliados en el grupo familiar'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    return Column(
      children: [
        MaterialButton(
            elevation: 0,
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => showSearch(
                context: context,
                delegate: SearchAfiliados(
                    afiliadoBloc: afiliadoBloc, isGrupoFamiliar: true)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const Text(
                'Agregar afiliado al grupo familiar',
                style: TextStyle(color: Colors.white),
              ),
            )),
        const SizedBox(height: 10),
        BlocConsumer<AfiliadosGrupoFamiliarBloc, AfiliadosGrupoFamiliarState>(
            listener: (context, state) {
          if (state is AfiliadoCabezaFamiliaLoaded) {
            if (!state.existeAfiliadoCabezaFamilia) {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => GrupoFamiliarForm(
                    ocultarLeading: true,
                    afiliadoGrupoFamiliar: GrupoFamiliarEntity(
                      afiliadoId: afiliado.afiliadoId,
                      documento: afiliado.documento,
                      edad: afiliado.edad,
                      fechaNacimiento: afiliado.fecnac,
                      nombre1: afiliado.nombre1,
                      nombre2: afiliado.nombre2,
                      apellido1: afiliado.apellido1,
                      apellido2: afiliado.apellido2,
                      tipoDocAfiliado: afiliado.tipoDocAfiliado,
                      codGeneroAfiliado: afiliado.codGeneroAfiliado,
                      codRegimenAfiliado: afiliado.codRegimenAfiliado,
                    ),
                  ),
                ),
              );
            } else {
              BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context)
                  .add(GetAfiliadosGrupoFamiliar(afiliado.familiaId!));
            }
          }
        }, builder: (context, state) {
          if (state is AfiliadosGrupoFamiliarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AfiliadosGrupoFamiliarLoaded) {
            final afiliadosGrupoFamiliarLoaded =
                state.afiliadosGrupoFamiliarLoaded!;
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: afiliadosGrupoFamiliarLoaded.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildDismissibleListTile(
                        context, afiliadosGrupoFamiliarLoaded, index);
                  },
                ),
                MaterialButton(
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed:
                        state is GrupoFamiliarFormLoading ? null : submitForm,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: state is GrupoFamiliarFormLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Siguiente',
                              style: TextStyle(color: Colors.white),
                            ),
                    )),
              ],
            );
          }
          return const Center(child: Text('No hay afiliados'));
        })
      ],
    );
  }

  Widget buildDismissibleListTile(BuildContext context,
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar, int index) {
    final afiliadoGrupoFamiliar = afiliadosGrupoFamiliar[index];

    final nombreCompleto =
        '${afiliadoGrupoFamiliar.nombre1 ?? ''} ${afiliadoGrupoFamiliar.nombre2 ?? ''} ${afiliadoGrupoFamiliar.apellido1 ?? ''} ${afiliadoGrupoFamiliar.apellido2 ?? ''}';

    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(afiliadoGrupoFamiliar.afiliadoId.toString()),
      confirmDismiss: (DismissDirection direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Advertencia"),
              content: Text(
                  "¿Está seguro que desea eliminar el afiliado $nombreCompleto?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    final grupoFamiliarBloc =
                        BlocProvider.of<GrupoFamiliarBloc>(context);
                    final afiliadoPrefsBloc =
                        BlocProvider.of<AfiliadoPrefsBloc>(
                      context,
                    );

                    final afiliado = afiliadoPrefsBloc.state.afiliado!;

                    if (afiliadoGrupoFamiliar.afiliadoId ==
                        afiliado.afiliadoId) {
                      Navigator.of(context).pop();
                      CustomSnackBar.showSnackBar(
                          context,
                          'No se puede eliminar el afiliado cabeza de familia',
                          Colors.red);
                    } else {
                      await grupoFamiliarBloc
                          .deleteAfiliadoGrupoFamiliar(
                              afiliadoGrupoFamiliar.afiliadoId!,
                              afiliadoGrupoFamiliar.familiaId!)
                          .then((value) {
                        if (value != 0) {
                          setState(() {
                            afiliadosGrupoFamiliar.removeAt(index);
                          });

                          Navigator.of(context).pop();

                          CustomSnackBar.showSnackBar(context,
                              'Afiliado eliminado correctamente', Colors.green);
                        }
                      });
                    }
                  },
                  child: const Text("Eliminar"),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red, // Background color when swiping
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(nombreCompleto),
        trailing: IconButton(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => GrupoFamiliarForm(
                    afiliadoGrupoFamiliar: afiliadoGrupoFamiliar,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit)),
      ),
    );
  }
}
