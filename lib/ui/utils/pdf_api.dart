import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFApi {
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = base64Decode(response.body);

    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = url.substring(url.lastIndexOf('/') + 1);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
