/// Representa um QR Code gerado e salvo no histórico do usuário.
class QrHistoryItem {
  final String conteudo;
  final DateTime criadoEm;

  QrHistoryItem({
    required this.conteudo,
    required this.criadoEm,
  });

  /// Converte o item em um Map simples, usado para serializar em JSON
  /// e guardar no armazenamento local (shared_preferences).
  Map<String, dynamic> toMap() {
    return {
      'conteudo': conteudo,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }

  /// Reconstrói um [QrHistoryItem] a partir de um Map (vindo do JSON salvo).
  factory QrHistoryItem.fromMap(Map<String, dynamic> map) {
    return QrHistoryItem(
      conteudo: map['conteudo'] as String,
      criadoEm: DateTime.parse(map['criadoEm'] as String),
    );
  }
}
