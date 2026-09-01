# Gerador de QR Code (Flutter)

Aplicativo individual desenvolvido em Flutter para a atividade de uso de
bibliotecas externas do **pub.dev**.

## O que o app faz

- O usuário digita um texto ou link.
- Ao tocar em **"Gerar QR Code"**, o app desenha o QR Code correspondente
  na tela, em tempo real.
- O usuário pode salvar o QR Code gerado em um **histórico local**, que
  fica salvo mesmo depois de fechar o app.
- É possível tocar em um item do histórico para recarregá-lo na tela
  principal, ou limpar todo o histórico.

## Bibliotecas do pub.dev utilizadas

| Biblioteca | Uso no app |
|---|---|
| [`qr_flutter`](https://pub.dev/packages/qr_flutter) | **Biblioteca principal.** Gera e desenha o QR Code na tela através do widget `QrImageView`, a partir do texto digitado pelo usuário. Usada em `lib/screens/home_screen.dart`. |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Persiste o histórico de QR Codes gerados no armazenamento local do dispositivo. Usada em `lib/services/history_service.dart`. |
| [`intl`](https://pub.dev/packages/intl) | Formata as datas exibidas no histórico (`dd/MM/yyyy HH:mm`). Usada em `lib/widgets/history_tile.dart`. |

A biblioteca `qr_flutter` é o requisito central da atividade: sem ela, o
app não teria como gerar a imagem do QR Code — essa é a "funcionalidade
perceptível" pedida no enunciado. As outras duas (`shared_preferences` e
`intl`) são extras que tornam o app mais completo, mas não são obrigatórias.

## Estrutura do projeto

```
qr_gerador_flutter/
├── pubspec.yaml                     # dependências (bibliotecas do pub.dev)
├── lib/
│   ├── main.dart                    # ponto de entrada e tema do app
│   ├── models/
│   │   └── qr_history_item.dart     # modelo de um item do histórico
│   ├── services/
│   │   └── history_service.dart     # salvar/ler histórico (shared_preferences)
│   ├── screens/
│   │   └── home_screen.dart         # tela principal (campo + QR + histórico)
│   └── widgets/
│       └── history_tile.dart        # item visual da lista de histórico
```

## Como executar

1. Instale o [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Copie a pasta `qr_gerador_flutter` para sua máquina.
3. No terminal, dentro da pasta do projeto, rode:

   ```bash
   flutter pub get
   flutter run
   ```

4. Escolha um emulador/dispositivo conectado (Android, iOS, ou até
   `flutter run -d chrome` para testar no navegador).

## Checklist dos requisitos da atividade

- [x] Desenvolvido em Flutter
- [x] Usa biblioteca externa do pub.dev (`qr_flutter`, `shared_preferences`, `intl`)
- [x] Interface visual funcional (campo de texto, botão, cartão do QR Code, lista de histórico)
- [x] Funcionalidade real implementada com a biblioteca (geração visual do QR Code)
- [x] Interação com o usuário (gerar, salvar, reabrir, limpar histórico) e feedback (SnackBars)
- [x] Código organizado em camadas (models / services / screens / widgets), com comentários
- [x] Desenvolvimento individual
