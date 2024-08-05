import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/home/pages/pdf_viewer_page.dart';
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
    fichaBloc.add(LoadFichasSincronizadas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fichas Sincronizadas'),
      ),
      body: Center(
        child: BlocBuilder<FichaBloc, FichasState>(
          builder: (context, state) {
            if (state is FichasLoaded) {
              final fichasSincronizadas = state.fichasLoaded
                  ?.where((element) => element.numFicha != 
                  .toList();
              if (fichasSincronizadas == null || fichasSincronizadas.isEmpty) {
                return const Center(
                  child: Text('No hay fichas sincronizadas'),
                );
              } else {
                return ListView.builder(
                  itemCount: fichasSincronizadas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ficha = fichasSincronizadas[index];
                    return ListTile(
                      leading: Text("Ficha No. ${ficha.numFicha}"),
                      title: Text(ficha.familia!.apellidosFlia!),
                      trailing: IconButton(
                        icon: const Icon(Icons.picture_as_pdf),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PDFViewerPage(ficha: ficha),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
