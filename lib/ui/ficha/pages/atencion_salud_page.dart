import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../cubits/enfermedad_acude/enfermedad_acude_cubit.dart';
import '../../cubits/enfermedad_tradicional/enfermedad_tradicional_cubit.dart';
import '../../cubits/enfermedad_tratamiento/enfermedad_tratamiento_cubit.dart';
import '../../cubits/especialidad_med_tradicional/especialidad_med_tradicional_cubit.dart';
import '../../cubits/lugar_atencion_medico/lugar_atencion_medico_cubit.dart';
import '../../cubits/lugar_planta_medicinal/lugar_planta_medicinal_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/planta_medicinal/planta_medicinal_cubit.dart';
import '../widgets/atencion_salud_form.dart';

class AtencionSaludPage extends StatefulWidget {
  const AtencionSaludPage({
    required this.formKey,
    required this.afiliado,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final GrupoFamiliarEntity afiliado;

  @override
  State<AtencionSaludPage> createState() => _AtencionSaludPageState();
}

class _AtencionSaludPageState extends State<AtencionSaludPage> {
  @override
  void initState() {
    super.initState();

    getAccesoriasAtencionSalud();

    final atencionSaludBloc = BlocProvider.of<AtencionSaludBloc>(context);
    atencionSaludBloc.add(GetAtencionSalud(widget.afiliado.afiliadoId!));
  }

  getAccesoriasAtencionSalud() {
    BlocProvider.of<EnfermedadAcudeCubit>(context).getEnfermedadAcudeDB();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<EspecialidadMedTradicionalCubit>(context)
        .getEspecialidadesMedTradicionalDB();
    BlocProvider.of<EnfermedadTradicionalCubit>(context)
        .getEnfermedadTradicionalDB();
    BlocProvider.of<LugarAtencionMedicoCubit>(context)
        .getLugaresAtencionMedicoDB();
    BlocProvider.of<EnfermedadTratamientoCubit>(context)
        .getEnfermedadTratamientoDB();
    BlocProvider.of<LugarPlantaMedicinalCubit>(context)
        .getLugarPlantaMedicinalDB();
    BlocProvider.of<PlantaMedicinalCubit>(context).getPlantasMedicinalesDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AtencionSaludBloc, AtencionSaludEntity>(
      builder: (context, state) {
        if (state.formStatus is AtencionSaludFormEmpty ||
            state.formStatus is AtencionSaludFormLoaded) {
          return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.formKey,
              child: AtencionSaludForm(
                  currentAfiliado: widget.afiliado, atencionSalud: state));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
