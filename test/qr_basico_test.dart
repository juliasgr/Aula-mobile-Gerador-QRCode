import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  group('Geração de QR Code (qr_flutter)', () {
    test('aceita um link como conteúdo válido', () {
      final resultado = QrValidator.validate(
        data: 'https://github.com/juliasgr',
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );

      expect(resultado.status, QrValidationStatus.valid);
      expect(resultado.qrCode, isNotNull);
    });

    testWidgets('desenha o QR Code na tela', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrImageView(data: 'Olá, QR Code!', size: 200),
          ),
        ),
      );

      expect(find.byType(QrImageView), findsOneWidget);
    });
  });

  group('Formatação de data do histórico (intl)', () {
    test('formata como dd/MM/yyyy HH:mm', () {
      final data = DateTime(2026, 10, 27, 18, 2);

      expect(DateFormat('dd/MM/yyyy HH:mm').format(data), '27/10/2026 18:02');
    });
  });
}