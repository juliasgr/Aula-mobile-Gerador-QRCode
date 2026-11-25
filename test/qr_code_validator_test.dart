import 'package:flutter_test/flutter_test.dart';
import 'package:qr_gerador_flutter/utils/qr_code_validator.dart';

void main() {
  group('Validação do texto do QR Code', () {
    test('deve aceitar textos com até 500 caracteres', () {
      final text = 'A' * 500;

      expect(isValidQrText(text), true);
    });

    test('deve rejeitar textos com mais de 500 caracteres', () {
      final text = 'A' * 501;

      expect(isValidQrText(text), false);
    });
  });
}