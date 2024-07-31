import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:path/path.dart';

import '../../../core/constants.dart';
import '../../../domain/entities/ficha.dart';
import '../../utils/pdf_api.dart';

class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({super.key, required this.ficha});

  final FichaEntity ficha;

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = '${indexPage + 1} de $pages';

    return FutureBuilder(
      future: PDFApi.loadNetwork(
          '${Constants.syncPublica}/reports/ficha/${widget.ficha.numFicha}'),
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.hasData) {
          final file = snapshot.data;
          final name = basename(file!.path);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(name),
              actions: pages >= 2
                  ? [
                      Center(child: Text(text)),
                      IconButton(
                          onPressed: () {
                            final page = indexPage == 0 ? pages : indexPage - 1;
                            controller?.setPage(page);
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 32,
                          )),
                      IconButton(
                          onPressed: () {
                            final page =
                                indexPage == pages - 1 ? 0 : indexPage + 1;
                            controller?.setPage(page);
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            size: 32,
                          ))
                    ]
                  : null,
            ),
            body: PDFView(
              filePath: file.path,
              onRender: (pages) => setState(() => this.pages = pages!),
              onViewCreated: (controller) =>
                  setState(() => this.controller = controller),
              onPageChanged: (indexPage, _) =>
                  setState(() => this.indexPage = indexPage!),
            ),
          );
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
