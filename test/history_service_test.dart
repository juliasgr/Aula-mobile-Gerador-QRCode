import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_gerador_flutter/models/qr_history_item.dart';
import 'package:qr_gerador_flutter/services/history_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HistoryService service;

  setUp(() {
    // Simula um armazenamento vazio a cada teste.
    SharedPreferences.setMockInitialValues({});
    service = HistoryService();
  });

  group('HistoryService', () {
    test('o histórico começa vazio', () async {
      final itens = await service.carregarHistorico();

      expect(itens, isEmpty);
    });

    test('adicionar salva o item e carregarHistorico devolve ele', () async {
      await service.adicionar(
        QrHistoryItem(
          conteudo: 'https://dart.dev',
          criadoEm: DateTime(2026, 11, 9),
        ),
      );

      final itens = await service.carregarHistorico();

      expect(itens.length, 1);
      expect(itens.first.conteudo, 'https://dart.dev');
      expect(itens.first.criadoEm, DateTime(2026, 11, 9));
    });

    test('carregarHistorico devolve os mais recentes primeiro', () async {
      await service.adicionar(
        QrHistoryItem(conteudo: 'primeiro', criadoEm: DateTime(2026, 1, 1)),
      );
      await service.adicionar(
        QrHistoryItem(conteudo: 'segundo', criadoEm: DateTime(2026, 1, 2)),
      );
      await service.adicionar(
        QrHistoryItem(conteudo: 'terceiro', criadoEm: DateTime(2026, 1, 3)),
      );

      final itens = await service.carregarHistorico();

      expect(
        itens.map((i) => i.conteudo).toList(),
        ['terceiro', 'segundo', 'primeiro'],
      );
    });

    test('o histórico continua salvo para uma nova instância do serviço',
        () async {
      await service.adicionar(
        QrHistoryItem(conteudo: 'persistido', criadoEm: DateTime(2026, 5, 5)),
      );

      final outroServico = HistoryService();
      final itens = await outroServico.carregarHistorico();

      expect(itens.length, 1);
      expect(itens.first.conteudo, 'persistido');
    });

    test('limparTudo remove todos os itens', () async {
      await service.adicionar(
        QrHistoryItem(conteudo: 'a', criadoEm: DateTime(2026, 1, 1)),
      );
      await service.adicionar(
        QrHistoryItem(conteudo: 'b', criadoEm: DateTime(2026, 1, 2)),
      );

      await service.limparTudo();
      final itens = await service.carregarHistorico();

      expect(itens, isEmpty);
    });
  });
}