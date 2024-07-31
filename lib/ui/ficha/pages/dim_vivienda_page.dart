import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_vivienda.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../cubits/cuarto_vivienda/cuarto_vivienda_cubit.dart';
import '../../cubits/factor_riesgo_vivienda/factor_riesgo_vivienda_cubit.dart';
import '../../cubits/iluminacion_vivienda/iluminacion_vivienda_cubit.dart';
import '../../cubits/piso_vivienda/piso_vivienda_cubit.dart';
import '../../cubits/presencia_animal_vivienda/presencia_animal_vivienda_cubit.dart';
import '../../cubits/servicio_publico_vivienda/servicio_publico_vivienda_cubit.dart';
import '../../cubits/techo_vivienda/techo_vivienda_cubit.dart';
import '../../cubits/tenencia_vivienda/tenencia_vivienda_cubit.dart';
import '../../cubits/tipo_combustible_vivienda/tipo_combustible_vivienda_cubit.dart';
import '../../cubits/tipo_sanitario_vivienda/tipo_sanitario_vivienda_cubit.dart';
import '../../cubits/tipo_vivienda/tipo_vivienda_cubit.dart';
import '../../cubits/tratamiento_agua_vivienda/tratamiento_agua_vivienda_cubit.dart';
import '../../cubits/ventilacion_vivienda/ventilacion_vivienda_cubit.dart';
import '../widgets/datos_vivienda_form.dart';

class DimViviendaPage extends StatefulWidget {
  const DimViviendaPage(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  State<DimViviendaPage> createState() => _DimViviendaPageState();
}

class _DimViviendaPageState extends State<DimViviendaPage> {
  @override
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    BlocProvider.of<DimViviendaBloc>(context)
        .add(GetDimVivienda(afiliado.afiliadoId!, afiliado.familiaId!));

    getAccesoriasVivienda();
  }

  getAccesoriasVivienda() {
    BlocProvider.of<TipoViviendaCubit>(context).getTiposViviendaDB();
    BlocProvider.of<CuartoViviendaCubit>(context).getCuartosViviendaDB();
    BlocProvider.of<TenenciaViviendaCubit>(context).getTenenciasViviendaDB();
    BlocProvider.of<PisoViviendaCubit>(context).getPisosViviendaDB();
    BlocProvider.of<TechoViviendaCubit>(context).getTechosViviendaDB();
    BlocProvider.of<VentilacionViviendaCubit>(context)
        .getVentilacionesViviendaDB();
    BlocProvider.of<IluminacionViviendaCubit>(context)
        .getIluminacionesViviendaDB();
    BlocProvider.of<ServicioPublicoViviendaCubit>(context)
        .getServiciosPublicosDB();
    BlocProvider.of<TratamientoAguaViviendaCubit>(context)
        .getTratamientosAguaDB();
    BlocProvider.of<TipoSanitarioViviendaCubit>(context).getTiposSanitarioDB();
    BlocProvider.of<TipoCombustibleViviendaCubit>(context)
        .getTiposCombustibleDB();
    BlocProvider.of<FactorRiesgoViviendaCubit>(context).getFactoresRiesgoDB();
    BlocProvider.of<PresenciaAnimalViviendaCubit>(context)
        .getPresenciaAnimalesDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DimViviendaBloc, DimViviendaEntity>(
      builder: (context, state) {
        if (state.formStatus is DimViviendaFormEmpty ||
            state.formStatus is DimViviendaFormLoaded) {
          return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.formKey,
              child: DatosViviendaForm(
                dimVivienda: state,
              ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
