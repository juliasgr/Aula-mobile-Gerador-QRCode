import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/qr_history_item.dart';

/// Serviço responsável por persistir o histórico de QR Codes gerados
/// usando a biblioteca `shared_preferences`, que guarda dados simples
/// diretamente no armazenamento local do dispositivo.
class HistoryService {
  static const _chaveHistorico = 'qr_history';

  /// Retorna a lista de itens salvos, mais recentes primeiro.
  Future<List<QrHistoryItem>> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    final dadosSalvos = prefs.getStringList(_chaveHistorico) ?? [];

    return dadosSalvos
        .map((item) => QrHistoryItem.fromMap(jsonDecode(item)))
        .toList()
        .reversed
        .toList();
  }

  /// Adiciona um novo QR Code ao histórico e persiste a lista atualizada.
  Future<void> adicionar(QrHistoryItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final dadosSalvos = prefs.getStringList(_chaveHistorico) ?? [];

    dadosSalvos.add(jsonEncode(item.toMap()));
    await prefs.setStringList(_chaveHistorico, dadosSalvos);
  }

  /// Remove todo o histórico salvo.
  Future<void> limparTudo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveHistorico);
  }
}
