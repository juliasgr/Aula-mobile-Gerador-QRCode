import 'package:flutter_test/flutter_test.dart';
import 'package:qr_gerador_flutter/models/qr_history_item.dart';

void main() {
  group('QrHistoryItem', () {
    test('toMap guarda o conteúdo e a data em formato ISO 8601', () {
      final item = QrHistoryItem(
        conteudo: 'https://flutter.dev',
        criadoEm: DateTime(2026, 11, 9, 19, 30),
      );

      final mapa = item.toMap();

      expect(mapa['conteudo'], 'https://flutter.dev');
      expect(mapa['criadoEm'], DateTime(2026, 11, 9, 19, 30).toIso8601String());
    });

    test('fromMap reconstrói o item igual ao original (ida e volta)', () {
      final original = QrHistoryItem(
        conteudo: 'Olá, mundo! ção & ñ?x=1',
        criadoEm: DateTime(2026, 1, 15, 8, 5),
      );

      final copia = QrHistoryItem.fromMap(original.toMap());

      expect(copia.conteudo, original.conteudo);
      expect(copia.criadoEm, original.criadoEm);
    });

    test('fromMap lê um mapa vindo do JSON salvo', () {
      final item = QrHistoryItem.fromMap({
        'conteudo': 'texto qualquer',
        'criadoEm': '2026-10-27T18:02:00.000',
      });

      expect(item.conteudo, 'texto qualquer');
      expect(item.criadoEm, DateTime(2026, 10, 27, 18, 2));
    });
  });
}