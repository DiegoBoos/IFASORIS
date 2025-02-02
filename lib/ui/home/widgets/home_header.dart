import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/afiliados/afiliados_bloc.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../cubits/afiliado/afiliado_cubit.dart';
import '../../search/search_afiliados.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        child: GestureDetector(
          onTap: () {
            final afiliadosBloc = BlocProvider.of<AfiliadosBloc>(context);
            final afiliadoCubit = BlocProvider.of<AfiliadoCubit>(context);
            final grupoFamiliarBloc =
                BlocProvider.of<GrupoFamiliarBloc>(context);
            showSearch(
              context: context,
              delegate: SearchAfiliados(
                  afiliadoCubit: afiliadoCubit,
                  afiliadosBloc: afiliadosBloc,
                  grupoFamiliarBloc: grupoFamiliarBloc),
            );
          },
          child: const TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Buscar afiliado',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none, // No underline
              prefixIcon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
