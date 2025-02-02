import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TycPage extends StatefulWidget {
  const TycPage({super.key});

  @override
  State<TycPage> createState() => _TycPageState();
}

class _TycPageState extends State<TycPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Excepción no controlada: $error')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://mallamaseps.com/documentos/tratamientodatos.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y condiciones'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
