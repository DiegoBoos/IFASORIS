import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/ficha/ficha_bloc.dart';

class FichasSincronizadasPage extends StatefulWidget {
  const FichasSincronizadasPage({super.key});

  @override
  State<FichasSincronizadasPage> createState() =>
      _FichasSincronizadasPageState();
}

class _FichasSincronizadasPageState extends State<FichasSincronizadasPage> {
  @override
  void initState() {
    super.initState();
    final fichaBloc = BlocProvider.of<FichaBloc>(context);
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
    final afiliado = afiliadoPrefsBloc.state.afiliado!;
    fichaBloc.add(LoadFichasDiligenciadas(afiliado.familiaId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fichas Sincronizadas'),
      ),
      body: BlocBuilder<FichaBloc, FichasState>(
        builder: (context, state) {
          if (state is FichasLoaded) {
            return ListView.builder(
              itemCount: state.fichasLoaded!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(state.fichasLoaded![index].numFicha!),
                  trailing: IconButton(
                      icon: const Icon(Icons.picture_as_pdf), onPressed: () {}),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
