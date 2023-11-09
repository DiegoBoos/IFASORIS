import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/autoridad_indigena/autoridad_indigena_cubit.dart';
import '../../cubits/cereal/cereal_cubit.dart';
import '../../cubits/costo_desplazamiento/costo_desplazamiento_cubit.dart';
import '../../cubits/dificultad_acceso_ca/dificultad_acceso_ca_cubit.dart';
import '../../cubits/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_cubit.dart';
import '../../cubits/especialidad_med_tradicional/especialidad_med_tradicional_cubit.dart';
import '../../cubits/especie_animal/especie_animal_cubit.dart';
import '../../cubits/estado_via/estado_via_cubit.dart';
import '../../cubits/fruto/fruto_cubit.dart';
import '../../cubits/hortaliza/hortaliza_cubit.dart';
import '../../cubits/leguminosa/leguminosa_cubit.dart';
import '../../cubits/medio_comunicacion/medio_comunicacion_cubit.dart';
import '../../cubits/medio_utiliza_ca/medio_utiliza_ca_cubit.dart';
import '../../cubits/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/resguardo/resguardo_cubit.dart';
import '../../cubits/tiempo_tarda_ca/tiempo_tarda_ca_cubit.dart';
import '../../cubits/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_cubit.dart';
import '../../cubits/tipo_calendario/tipo_calendario_cubit.dart';
import '../../cubits/tipo_documento/tipo_documento_cubit.dart';
import '../../cubits/tuberculo_platano/tuberculo_platano_cubit.dart';
import '../../cubits/verdura/verdura_cubit.dart';
import '../../cubits/via_acceso/via_acceso_cubit.dart';
import '../widgets/acceso_ca_form.dart';
import '../widgets/acceso_medico_form.dart';
import '../widgets/aspectos_tierra.dart';
import '../widgets/datos_ubicacion_form.dart';

class DimUbicacionPage extends StatefulWidget {
  const DimUbicacionPage(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  State<DimUbicacionPage> createState() => _DimUbicacionPageState();
}

class _DimUbicacionPageState extends State<DimUbicacionPage> {
  @override
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    BlocProvider.of<DimUbicacionBloc>(context)
        .add(GetDimUbicacion(afiliado.afiliadoId!, afiliado.familiaId!));

    getAccesoriasUbicacion();
  }

  getAccesoriasUbicacion() {
    BlocProvider.of<TipoDocumentoCubit>(context).getTiposDocumentoDB();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<ResguardoCubit>(context).getResguardosDB();
    BlocProvider.of<AutoridadIndigenaCubit>(context)
        .getAutoridadesIndigenasDB();
    BlocProvider.of<ViaAccesoCubit>(context).getViasAccesoDB();
    BlocProvider.of<EstadoViaCubit>(context).getEstadosVias();
    BlocProvider.of<MedioComunicacionCubit>(context).getMediosComunicacionDB();
    BlocProvider.of<TiempoTardaCACubit>(context).getTiemposTardaCADB();
    BlocProvider.of<MedioUtilizaCACubit>(context).getMediosUtilizaCA();
    BlocProvider.of<DificultadAccesoCACubit>(context).getDificultadesAccesoCA();
    BlocProvider.of<CostoDesplazamientoCubit>(context)
        .getCostosDesplazamientoDB();
    BlocProvider.of<MedioUtilizaMedTradicionalCubit>(context)
        .getMediosUtilizaMedTradicional();
    BlocProvider.of<EspecialidadMedTradicionalCubit>(context)
        .getEspecialidadesMedTradicionalDB();
    BlocProvider.of<TiempoTardaMedTradicionalCubit>(context)
        .getTiemposTardaMedTradicionalDB();
    BlocProvider.of<DificultadAccesoMedTradicionalCubit>(context)
        .getDificultadesAccesoMedTradicional();
    BlocProvider.of<TuberculoPlatanoCubit>(context).getTuberculosPlatanosDB();
    BlocProvider.of<LeguminosaCubit>(context).getLeguminosasDB();
    BlocProvider.of<HortalizaCubit>(context).getHortalizasDB();
    BlocProvider.of<VerduraCubit>(context).getVerdurasDB();
    BlocProvider.of<FrutoCubit>(context).getFrutosDB();
    BlocProvider.of<CerealCubit>(context).getCerealesDB();
    BlocProvider.of<EspecieAnimalCubit>(context).getEspeciesAnimalesDB();
    BlocProvider.of<TipoCalendarioCubit>(context).getTiposCalendarioDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DimUbicacionBloc, DimUbicacionEntity>(
      builder: (context, state) {
        if (state.formStatus is DimUbicacionFormEmpty ||
            state.formStatus is DimUbicacionFormLoaded) {
          return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.formKey,
              child: ListView(
                children: [
                  DatosUbicacionForm(dimUbicacion: state),
                  AccesoCAForm(dimUbicacion: state),
                  AccesoMedicoForm(dimUbicacion: state),
                  AspectosTierraForm(dimUbicacion: state),
                ],
              ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
