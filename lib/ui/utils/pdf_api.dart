import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFApi {
  static Future<File> loadNetwork(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = base64Decode(response.body);

      return storeFile(url, bytes);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  static Future<File> storeFile(String url, List<int> bytes) async {
    final filename = url.substring(url.lastIndexOf('/') + 1);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File> fromAsset(String asset, String fileName) async {
    File file;
    try {
      var dir = await getApplicationDocumentsDirectory();
      file = File("${dir.path}/$fileName");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return file;
  }
}
