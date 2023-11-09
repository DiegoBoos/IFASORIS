import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import '../../cubits/costumbre_practica/costumbre_practica_cubit.dart';
import '../../cubits/evento_costumbre_participa/evento_costumbre_participa_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/religion_profesa/religion_profesa_cubit.dart';
import '../../cubits/sancion_justicia/sancion_justicia_cubit.dart';
import '../widgets/dimension_sociocultural_pueblos_indigenas_form.dart';

class DimensionSocioCulturalPueblosIndigenasPage extends StatefulWidget {
  const DimensionSocioCulturalPueblosIndigenasPage(
      {required this.formKey, required this.afiliado, super.key});

  final GlobalKey<FormState> formKey;
  final GrupoFamiliarEntity afiliado;

  @override
  State<DimensionSocioCulturalPueblosIndigenasPage> createState() =>
      _DimensionSocioCulturalPueblosIndigenasPageState();
}

class _DimensionSocioCulturalPueblosIndigenasPageState
    extends State<DimensionSocioCulturalPueblosIndigenasPage> {
  @override
  void initState() {
    super.initState();

    getAccesoriasDimensionSocioCulturalPueblosIndigenas();

    final dimensionSocioCulturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioCulturalPueblosIndigenasBloc>(context);

    dimensionSocioCulturalPueblosIndigenasBloc.add(
        GetDimensionSocioCulturalPueblosIndigenas(widget.afiliado.afiliadoId!));
  }

  getAccesoriasDimensionSocioCulturalPueblosIndigenas() {
    BlocProvider.of<ReligionProfesaCubit>(context).getReligionProfesaDB();
    BlocProvider.of<OpcionSiNoCubit>(context).getOpcionesSiNoDB();
    BlocProvider.of<EventoCostumbreParticipaCubit>(context)
        .getEventosCostumbresParticipaDB();
    BlocProvider.of<CostumbrePracticaCubit>(context).getCostumbrePracticaDB();
    BlocProvider.of<SancionJusticiaCubit>(context).getSancionJusticiaDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DimensionSocioCulturalPueblosIndigenasBloc,
        DimensionSocioCulturalPueblosIndigenasEntity>(
      builder: (context, state) {
        if (state.formStatus
                is DimensionSocioCulturalPueblosIndigenasFormEmpty ||
            state.formStatus
                is DimensionSocioCulturalPueblosIndigenasFormLoaded) {
          return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.formKey,
              child: DimensionSocioCulturalPueblosIndigenasForm(
                  currentAfiliado: widget.afiliado,
                  dimensionSocioCulturalPueblosIndigenas: state));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
