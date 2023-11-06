import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/home/pages/pdf_viewer_page.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/ficha/ficha_bloc.dart';
import '../../utils/pdf_api.dart';

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
    fichaBloc.add(LoadFichasSincronizadas(afiliado.familiaId!));
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
                  ?.where((element) => element.numFicha != '')
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
                      title: Text("Ficha No. ${ficha.numFicha!}"),
                      trailing: FutureBuilder<File>(
                        future: PDFApi.loadNetwork(
                            'https://2m4jlnxx-5005.use2.devtunnels.ms/api/reports/ficha/${ficha.numFicha}'),
                        builder: (BuildContext context,
                            AsyncSnapshot<File> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Icon(Icons.error);
                          } else {
                            return IconButton(
                              icon: const Icon(Icons.picture_as_pdf),
                              onPressed: () {
                                openPdf(context, snapshot.data!);
                              },
                            );
                          }
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

  void openPdf(BuildContext context, File file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PDFViewerPage(file: file),
      ),
    );
  }
}
