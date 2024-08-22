import 'package:ifasoris/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../domain/entities/afiliado.dart';
import '../../models/afiliado.dart';
import '../../models/familia.dart';
import '../../models/ficha.dart';

abstract class AfiliadoLocalDataSource {
  Future<List<AfiliadoModel>> getAfiliados(String query);
  Future<void> saveAfiliado(AfiliadoEntity afiliado);
  Future<FichaModel?> afiliadoTieneFicha(int afiliadoId);
  Future<String> afiliadoTieneFichaReportada(int afiliadoId);
}

class AfiliadoLocalDataSourceImpl implements AfiliadoLocalDataSource {
  @override
  Future<List<AfiliadoModel>> getAfiliados(String query) async {
    try {
      final res = await supabase
          .from('afiliado')
          .select()
          .filter('documento', 'eq', query);
      final result =
          List<AfiliadoModel>.from(res.map((m) => AfiliadoModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<void> saveAfiliado(AfiliadoEntity afiliado) async {
    try {
      final afiliadoModel = AfiliadoModel.fromEntity(afiliado);
      await supabase.from('afiliado').upsert(afiliadoModel.toJson());
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  Future<List<AfiliadoModel>> getAfiliadosByDocumento(String query) async {
    try {
      final res = await supabase
          .from('afiliado')
          .select('documento')
          .eq('documento', query);
      final result =
          List<AfiliadoModel>.from(res.map((m) => AfiliadoModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<FichaModel?> afiliadoTieneFicha(int afiliadoId) async {
    try {
      final res = await supabase.from('familia').select('''
        Ficha.*, Familia.*
        FROM Familia
        JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
        WHERE Familia.FK_Afiliado_id = $afiliadoId

        UNION ALL

        SELECT Ficha.*, Familia.*
        FROM Familia
        JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.Familia_id
        JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
        WHERE Asp3_GrupoFamiliar.Afiliado_id = $afiliadoId
      ''');

      if (res.data != null) return null;
      final familia = FamiliaModel.fromJson(res);
      res['familia'] = familia.toJson();
      final result = FichaModel.fromJson(res);

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<String> afiliadoTieneFichaReportada(int afiliadoId) async {
    try {
      final res = await supabase.from('familia').select('''
    SELECT Ficha.NumFicha FROM Familia 
    JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
    WHERE Familia.FK_Afiliado_id = $afiliadoId AND Ficha.NumFicha <> ''
    UNION ALL
    SELECT Ficha.NumFicha FROM Familia 
    JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.GrupoFamiliar_id
    JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
    WHERE Asp3_GrupoFamiliar.Afiliado_id  = $afiliadoId AND Ficha.NumFicha <> ''
  ''');

      if (res.isEmpty) return '';

      final numFicha = res[0].entries.first.value as String;
      return numFicha;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
