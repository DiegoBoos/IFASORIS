import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/estilo_vida_saludable.dart';
import '../../../domain/entities/grupo_familiar.dart';
import '../../blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';
import '../../cubits/actividad_fisica/actividad_fisica_cubit.dart';
import '../../cubits/alimentacion/alimentacion_cubit.dart';
import '../../cubits/cigarrillo_dia/cigarrillo_dia_cubit.dart';
import '../../cubits/consumo_alcohol/consumo_alcohol_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../widgets/estilos_vida_saludable_form.dart';

class EstilosVidaSaludablePage extends StatefulWidget {
  const EstilosVidaSaludablePage({
    required this.formKey,
    required this.afiliado,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final GrupoFamiliarEntity afiliado;

  @override
  State<EstilosVidaSaludablePage> createState() =>
      _EstilosVidaSaludablePageState();
}

class _EstilosVidaSaludablePageState extends State<EstilosVidaSaludablePage> {
  @override
  void initState() {
    super.initState();

    getAccesoriasEstilosVidaSaludable();

    final estiloVidaSaludableBloc =
        BlocProvider.of<EstiloVidaSaludableBloc>(context);

    estiloVidaSaludableBloc
        .add(GetEstiloVidaSaludable(widget.afiliado.afiliadoId!));
  }

  getAccesoriasEstilosVidaSaludable() {
    BlocProvider.of<ActividadFisicaCubit>(context).getActividadFisicaDB();
    BlocProvider.of<AlimentacionCubit>(context).getAlimentacionDB();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<CigarrilloDiaCubit>(context).getCigarrilloDiaDB();
    BlocProvider.of<ConsumoAlcoholCubit>(context).getConsumoAlcoholDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EstiloVidaSaludableBloc, EstiloVidaSaludableEntity>(
      builder: (context, state) {
        if (state.formStatus is EstiloVidaSaludableFormEmpty ||
            state.formStatus is EstiloVidaSaludableFormLoaded) {
          return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.formKey,
              child: EstilosVidaSaludableForm(
                  currentAfiliado: widget.afiliado,
                  estiloVidaSaludable: state));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
