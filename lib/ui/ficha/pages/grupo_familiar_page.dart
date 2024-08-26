import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/core/constants.dart';

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
import '../../../domain/entities/grupo_familiar.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import '../../blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../search/search_afiliados.dart';
import '../../utils/custom_alerts.dart';
import '../../utils/custom_svg.dart';
import '../widgets/grupo_familiar_form.dart';
import 'componentes_afiliado_page.dart';

class GrupoFamiliarPage extends StatefulWidget {
  const GrupoFamiliarPage({super.key});

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarState();
}

class _GrupoFamiliarState extends State<GrupoFamiliarPage> {
  @override
  void initState() {
    super.initState();

    final afiliadosGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    afiliadosGrupoFamiliarBloc
        .add(GetAfiliadosGrupoFamiliar(afiliado.familiaId!));

    getAccesoriasGrupoFamiliar();
  }

  getAccesoriasGrupoFamiliar() {
    BlocProvider.of<TipoDocumentoCubit>(context).getTiposDocumentoDB();
    BlocProvider.of<GeneroCubit>(context).getGenerosDB();
    BlocProvider.of<CursoVidaCubit>(context).getCursosVidaDB();
    BlocProvider.of<ParentescoCubit>(context).getParentescosDB();
    BlocProvider.of<TipoRegimenCubit>(context).getTipoRegimenesDB();
    BlocProvider.of<NivelEducativoCubit>(context).getNivelesEducativosDB();
    BlocProvider.of<OcupacionCubit>(context).getOcupacionesDB();
    BlocProvider.of<GrupoRiesgoCubit>(context).getGruposRiesgoDB();
    BlocProvider.of<EtniaCubit>(context).getEtniasDB();
    BlocProvider.of<PuebloIndigenaCubit>(context).getPueblosIndigenasDB();
    BlocProvider.of<LenguaManejaCubit>(context).getLenguasManejaDB();
    BlocProvider.of<NombreLenguaMaternaCubit>(context)
        .getNombresLenguasMaternaDB();
  }

  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    final grupoFamiliarBloc = BlocProvider.of<GrupoFamiliarBloc>(context);
    final estiloVidaSaludableBloc =
        BlocProvider.of<EstiloVidaSaludableBloc>(context);
    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);
    final dimensionSocioCulturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioCulturalPueblosIndigenasBloc>(context);
    final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    return MultiBlocListener(
        listeners: [
          BlocListener<AfiliadosGrupoFamiliarBloc, AfiliadosGrupoFamiliarState>(
            listener: (context, state) {
              // Si no hay afiliados en el grupo familiar, se redirige al formulario
              if (state is AfiliadosGrupoFamiliarLoaded &&
                  state.afiliadosGrupoFamiliarLoaded.isEmpty) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => GrupoFamiliarForm(
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
                        codTipoRegimenAfiliado: afiliado.codTipoRegimenAfiliado,
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(),
          ),
          BlocListener<GrupoFamiliarBloc, GrupoFamiliarEntity>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is GrupoFamiliarSubmissionSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ComponentesAfiliado(
                      afiliado: state,
                    ),
                  ),
                );
                grupoFamiliarBloc.add(GrupoFamiliarInit());
                estiloVidaSaludableBloc.add(EstiloVidaSaludableInit());
                cuidadoSaludCondRiesgoBloc.add(CuidadoSaludCondRiesgoInit());
                dimensionSocioCulturalPueblosIndigenasBloc
                    .add(DimensionSocioCulturalPueblosIndigenasInit());
                atencionSaludBloc.add(AtencionSaludInit());
              } else {
                if (formStatus is GrupoFamiliarSubmissionFailed) {
                  context.showErrorSnackBar(message: formStatus.message);
                }
              }
            },
          ),
        ],
        child: Column(
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
            BlocBuilder<AfiliadosGrupoFamiliarBloc,
                AfiliadosGrupoFamiliarState>(builder: (context, state) {
              if (state is AfiliadosGrupoFamiliarLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AfiliadosGrupoFamiliarLoaded) {
                final afiliadosGrupoFamiliarLoaded =
                    state.afiliadosGrupoFamiliarLoaded;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: afiliadosGrupoFamiliarLoaded.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildDismissibleListTile(
                        context, afiliadosGrupoFamiliarLoaded, index);
                  },
                );
              }
              return const Center(child: CustomSvg(title: 'No hay afiliados'));
            }),
          ],
        ));
  }

  Widget buildDismissibleListTile(BuildContext context,
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar, int index) {
    final grupoFamiliarBloc = BlocProvider.of<GrupoFamiliarBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    final afiliadoGrupoFamiliar = afiliadosGrupoFamiliar[index];

    final nombreCompleto =
        '${afiliadoGrupoFamiliar.nombre1} ${afiliadoGrupoFamiliar.nombre2} ${afiliadoGrupoFamiliar.apellido1} ${afiliadoGrupoFamiliar.apellido2}';

    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(afiliadoGrupoFamiliar.afiliadoId.toString()),
      confirmDismiss: (DismissDirection direction) {
        return CustomAlerts.showCustomDialog(context, 'Advertencia',
            '¿Está seguro que desea eliminar el afiliado $nombreCompleto?',
            () async {
          if (afiliadoGrupoFamiliar.afiliadoId == afiliado.afiliadoId) {
            Navigator.of(context).pop();
            context.showErrorSnackBar(
                message: 'No se puede eliminar el afiliado cabeza de familia');
          } else {
            await grupoFamiliarBloc
                .deleteAfiliadoGrupoFamiliar(afiliadoGrupoFamiliar.afiliadoId!,
                    afiliadoGrupoFamiliar.familiaId!)
                .then((value) {
              if (value != 0) {
                setState(() {
                  afiliadosGrupoFamiliar.removeAt(index);
                });

                context.showSnackBar(
                    message: value.toString(), backgroundColor: Colors.green);
              }
            });
          }
        });
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
            icon: const Icon(Icons.arrow_forward)),
      ),
    );
  }
}
