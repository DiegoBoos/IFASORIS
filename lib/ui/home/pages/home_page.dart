import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifasoris/domain/entities/familia_entity.dart';
import 'package:ifasoris/domain/entities/ficha_entity.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';
import 'package:ifasoris/ui/blocs/auth/auth_bloc.dart';
import 'package:ifasoris/ui/utils/custom_snack_bar.dart';

import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/familia/familia_cubit.dart';
import '../../cubits/ficha/ficha_cubit.dart';
import '../widgets/buttons.dart';
import '../widgets/headers.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    afiliadoPrefsBloc.add(LoadAfiliado());
  }

  @override
  Widget build(BuildContext context) {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;
    return MultiBlocListener(
        listeners: [
          BlocListener<AfiliadoPrefsBloc, AfiliadoPrefsState>(
            listener: (context, state) {
              if (state is AfiliadoError) {
                CustomSnackBar.showSnackBar(
                    context, 'Error al cargar el afiliado', Colors.red);
              }
            },
          ),
          BlocListener<FichaCubit, FichaState>(
            listener: (context, state) {
              if (state is FichaError) {
                CustomSnackBar.showSnackBar(
                    context, 'Error al crear ficha', Colors.red);
              }
              if (state is FichaCreated) {
                final afiliadoPrefsBloc =
                    BlocProvider.of<AfiliadoPrefsBloc>(context);
                final familiaCubit = BlocProvider.of<FamiliaCubit>(context);
                final afiliado = afiliadoPrefsBloc.state.afiliado!;

                final newFamilia = FamiliaEntity(
                    fichaId: state.fichaCreated!.fichaId!,
                    apellidosFlia:
                        '${afiliado.apellido1}  ${afiliado.apellido2}',
                    afiliadoId: afiliado.afiliadoId!);

                familiaCubit.createFamiliaDB(newFamilia);
              }
            },
          ),
          BlocListener<FamiliaCubit, FamiliaState>(
            listener: (context, state) {
              if (state is FamiliaCreated) {
                CustomSnackBar.showSnackBar(
                    context, 'Ficha creada correctamente', Colors.green);

                final updateAfiliado = afiliadoPrefsBloc.state.afiliado!
                    .copyWith(familiaId: state.familiaCreated.familiaId);

                afiliadoPrefsBloc.add(SaveAfiliado(updateAfiliado));

                BlocProvider.of<DimUbicacionBloc>(context)
                    .add(DimUbicacionInit());
              }
            },
          ),
        ],
        child: Scaffold(
            appBar: size.width > 500
                ? PreferredSize(
                    preferredSize: size,
                    child: const NavBar(),
                  )
                : PreferredSize(
                    preferredSize: Size.fromHeight(size.height * 0.08),
                    child: const MobileAppBar()),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AfiliadoPrefsBloc, AfiliadoPrefsState>(
                    builder: (context, state) {
                  if (state is AfiliadoLoaded) {
                    return Column(
                      children: [
                        _Header(
                          afiliado: state.afiliado,
                        ),
                        FadeInLeft(
                            child: CustomButton(
                                icon: FontAwesomeIcons.dochub,
                                texto: state.afiliado!.familiaId == null
                                    ? 'Crear ficha'
                                    : 'Diligenciar ficha',
                                color1: Theme.of(context).colorScheme.primary,
                                color2: Theme.of(context).colorScheme.secondary,
                                onPress: () {
                                  if (state.afiliado!.familiaId == null) {
                                    final fichaCubit =
                                        BlocProvider.of<FichaCubit>(context);
                                    final newFicha = FichaEntity(
                                        fechaCreacion: DateTime.now(),
                                        //TODO: ???
                                        numFicha: '1',
                                        userName:
                                            authBloc.state.usuario!.userName,
                                        ultimaActualizacion: DateTime.now());
                                    fichaCubit.createFichaDB(newFicha);
                                  } else {
                                    Navigator.pushNamed(context, 'ficha');
                                  }
                                })),
                      ],
                    );
                  }
                  return _EmptyHeader();
                }),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: const [
                      Text('IFASORIS'),
                      Text('MALLAMAS EPS INDIGENA')
                    ],
                  ),
                )
              ],
            )));
  }
}

class _Header extends StatelessWidget {
  final AfiliadoEntity? afiliado;

  const _Header({this.afiliado});
  @override
  Widget build(BuildContext context) {
    return IconHeader(
        icon: FontAwesomeIcons.userCheck,
        title:
            '${afiliado?.nombre1 ?? ''} ${afiliado?.nombre2 ?? ''} ${afiliado?.apellido1 ?? ''} ${afiliado?.apellido2 ?? ''}',
        subtitle: afiliado?.documento ?? '',
        color1: Theme.of(context).colorScheme.primary,
        color2: Colors.green);
  }
}

class _EmptyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconHeader(
        icon: FontAwesomeIcons.userCheck,
        color1: Theme.of(context).colorScheme.primary,
        color2: Colors.green);
  }
}
