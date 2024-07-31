import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cuidado_salud_cond_riesgo.dart';
import '../../../domain/entities/grupo_familiar.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../cubits/condicion_nutricional/condicion_nutricional_cubit.dart';
import '../../cubits/conducta_seguir/conducta_seguir_cubit.dart';
import '../../cubits/esquema_vacunacion/esquema_vacunacion_cubit.dart';
import '../../cubits/lugar_vacunacion/lugar_vacunacion_cubit.dart';
import '../../cubits/metodo_planificacion/metodo_planificacion_cubit.dart';
import '../../cubits/nombre_enfermedad/nombre_enfermedad_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/seguimiento_enfermedad/seguimiento_enfermedad_cubit.dart';
import '../../cubits/servicio_solicitado/servicio_solicitado_cubit.dart';
import '../../cubits/ultima_vez_inst_salud/ultima_vez_inst_salud_cubit.dart';
import '../widgets/cuidado_salud_cond_riesgo_form.dart';

class CuidadoSaludCondRiesgoPage extends StatefulWidget {
  const CuidadoSaludCondRiesgoPage({
    required this.formKey,
    required this.afiliado,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final GrupoFamiliarEntity afiliado;

  @override
  State<CuidadoSaludCondRiesgoPage> createState() =>
      _CuidadoSaludCondRiesgoPageState();
}

class _CuidadoSaludCondRiesgoPageState
    extends State<CuidadoSaludCondRiesgoPage> {
  @override
  void initState() {
    super.initState();

    getAccesoriasCuidadoSaludCondRiesgo();

    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);

    cuidadoSaludCondRiesgoBloc
        .add(GetCuidadoSaludCondRiesgo(widget.afiliado.afiliadoId!));
  }

  getAccesoriasCuidadoSaludCondRiesgo() {
    BlocProvider.of<UltimaVezInstSaludCubit>(context).getUltimaVezInstSaludDB();
    BlocProvider.of<ServicioSolicitadoCubit>(context).getServicioSolicitadoDB();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<NombreEnfermedadCubit>(context).getNombreEnfermedadDB();
    BlocProvider.of<SeguimientoEnfermedadCubit>(context)
        .getSeguimientoEnfermedadDB();
    BlocProvider.of<CondicionNutricionalCubit>(context)
        .getCondicionNutricionalDB();
    BlocProvider.of<EsquemaVacunacionCubit>(context).getEsquemaVacunacionDB();
    BlocProvider.of<LugarVacunacionCubit>(context).getLugarVacunacionDB();
    BlocProvider.of<MetodoPlanificacionCubit>(context)
        .getMetodoPlanificacionDB();
    BlocProvider.of<ConductaSeguirCubit>(context).getConductaSeguirDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CuidadoSaludCondRiesgoBloc,
        CuidadoSaludCondRiesgoEntity>(
      builder: (context, state) {
        if (state.formStatus is CuidadoSaludCondRiesgoFormEmpty ||
            state.formStatus is CuidadoSaludCondRiesgoFormLoaded) {
          return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.formKey,
              child: CuidadoSaludCondRiesgoForm(
                currentAfiliado: widget.afiliado,
                cuidadoSaludCondRiesgo: state,
              ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
