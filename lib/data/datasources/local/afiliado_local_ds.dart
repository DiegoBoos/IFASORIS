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
      // Fetch the first query
      final ficha = await supabase.from('familia').select('''
      ficha()
  ''').eq('FK_Afiliado_id', afiliadoId);

// Fetch the second query
      final asp3GrupoFamiliar = await supabase.from('familia').select('''
    asp3_grupofamiliar()
  ''').eq('asp3_grupofamiliar.Afiliado_id', afiliadoId);

// Combine the results
      List<dynamic> combinedResults = [];

// Add results from the first query
      if (ficha is List) {
        combinedResults.addAll(ficha);
      }

// Add results from the second query
      if (asp3GrupoFamiliar is List) {
        combinedResults.addAll(asp3GrupoFamiliar);
      }

// Now combinedResults contains the union of both queries

      if (combinedResults.isEmpty) return null;
      final familia = FamiliaModel.fromJson(combinedResults[0]);
      combinedResults[0]['familia'] = familia.toJson();
      final result = FichaModel.fromJson(combinedResults[0]);

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
      // Fetch the first query
      final ficha = await supabase.from('familia').select('''
      ficha(NumFicha)
  ''').eq('FK_Afiliado_id', afiliadoId).eq('ficha.NumFicha', '<>');

// Fetch the second query
      final asp3GrupoFamiliar = await supabase
          .from('familia')
          .select('''
    ficha(NumFicha),
    asp3_grupofamiliar()
  ''')
          .eq('asp3_grupofamiliar.Afiliado_id', afiliadoId)
          .eq('ficha.NumFicha', '<>');

      // Combine the results
      List<dynamic> combinedResults = [];

// Add results from the first query
      if (ficha is List) {
        combinedResults.addAll(ficha);
      }

// Add results from the second query
      if (asp3GrupoFamiliar is List) {
        combinedResults.addAll(asp3GrupoFamiliar);
      }

// Now combinedResults contains the union of both queries

      if (combinedResults.isEmpty) return '';

      final numFicha = combinedResults[0].entries.first.value as String;
      return numFicha;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
