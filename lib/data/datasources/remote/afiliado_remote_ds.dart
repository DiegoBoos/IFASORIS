import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/error/failure.dart';
import '../../models/afiliado_response_model.dart';

abstract class AfiliadoRemoteDataSource {
  Future<AfiliadoResponseModel> getAfiliados(int dtoId);
}

class AfiliadoRemoteDataSourceImpl implements AfiliadoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  AfiliadoRemoteDataSourceImpl({required this.client});

  @override
  Future<AfiliadoResponseModel> getAfiliados(int dtoId) async {
    int limit = 25000;
    List<dynamic> afiliadosMap = [];

    final requestUrl = Uri.parse(
        'https://kg4btst7-8000.use2.devtunnels.ms/api/afiliados/$dtoId/$limit');

    try {
      final reqRes = await http.get(requestUrl);

      if (reqRes.statusCode == 200) {
        final decodedReq = json.decode(reqRes.body);
        final int totalRecords = decodedReq['totalRecords'];
        final int loopValue = decodedReq['loopValue'];

        for (var i = 0; i < loopValue; i++) {
          final afiliadosUrl = Uri.parse(
              'https://kg4btst7-8000.use2.devtunnels.ms/api/afiliados/afiliadosbydpto?limit=25000&page=$i&dptoId=$dtoId');
          final afiliadosRes = await http.get(afiliadosUrl);
          if (afiliadosRes.statusCode == 200) {
            final decodeReq = json.decode(afiliadosRes.body);
            afiliadosMap.addAll(decodeReq);
            // final afiliadosContent =
            //     await saveBase64AsJson(afiliadosRes.body, 1);
            // if (afiliadosContent.isNotEmpty) {
            //   afiliadosMap.addAll(afiliadosContent);
            // }
          } else {
            throw const ServerFailure(['Excepción no controlada']);
          }
          // final base64Url = Uri.parse(
          //     'https://kg4btst7-8000.use2.devtunnels.ms/api/afiliados/afiliadosbydpto?limit=25000&page=$i&dptoId=$dtoId');
          // final base64Res = await http.get(base64Url);

          // if (base64Res.statusCode == 200) {
          //   final afiliadosContent = await saveBase64AsJson(base64Res.body, 1);
          //   if (afiliadosContent.isNotEmpty) {
          //     afiliadosMap.addAll(afiliadosContent);
          //   }
          // } else {
          //   throw const ServerFailure(['Excepción no controlada']);
          // }
        }
        List<Map<String, dynamic>> combinedList =
            afiliadosMap.map((e) => e as Map<String, dynamic>).toList();

        final afiliadoResp = {
          "totalRecords": totalRecords,
          "afiliados": combinedList
        };

        final result = AfiliadoResponseModel.fromJson(afiliadoResp);
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<List<dynamic>> saveBase64AsJson(String base64String, int i) async {
    Uint8List bytes = base64.decode(base64String);
    try {
      // Get the application documents directory where the file will be saved.
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/afiliado$i.json');

      // Write the JSON string to the file.
      final savedFile = await file.writeAsBytes(bytes);
      return convertToJson(savedFile);
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> convertToJson(File base64File) async {
    final readedFile = await base64File.readAsString();
    final jsonList = json.decode(readedFile);
    return jsonList;
  }
}
