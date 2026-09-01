import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/qr_history_item.dart';
import '../services/history_service.dart';
import '../widgets/history_tile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controladorTexto = TextEditingController();
  final _servicoHistorico = HistoryService();

  String _conteudoQr = '';
  List<QrHistoryItem> _historico = [];

  @override
  void initState() {
    super.initState();
    _carregarHistorico();
  }

  @override
  void dispose() {
    _controladorTexto.dispose();
    super.dispose();
  }

  Future<void> _carregarHistorico() async {
    final lista = await _servicoHistorico.carregarHistorico();
    setState(() => _historico = lista);
  }

  void _gerarQrCode() {
    final texto = _controladorTexto.text.trim();

    if (texto.isEmpty) {
      _mostrarAviso('Digite um texto ou link antes de gerar o QR Code.');
      return;
    }

    setState(() => _conteudoQr = texto);
  }

  Future<void> _salvarNoHistorico() async {
    if (_conteudoQr.isEmpty) {
      _mostrarAviso('Gere um QR Code antes de salvar.');
      return;
    }

    final novoItem = QrHistoryItem(
      conteudo: _conteudoQr,
      criadoEm: DateTime.now(),
    );

    await _servicoHistorico.adicionar(novoItem);
    await _carregarHistorico();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('QR Code salvo no histórico!')),
    );
  }

  Future<void> _limparHistorico() async {
    await _servicoHistorico.limparTudo();
    await _carregarHistorico();
  }

  void _mostrarAviso(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void _reabrirDoHistorico(QrHistoryItem item) {
    setState(() {
      _conteudoQr = item.conteudo;
      _controladorTexto.text = item.conteudo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de QR Code'),
        actions: [
          if (_historico.isNotEmpty)
            IconButton(
              tooltip: 'Limpar histórico',
              onPressed: _limparHistorico,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _controladorTexto,
                  decoration: const InputDecoration(
                    labelText: 'Texto ou link',
                    hintText: 'Ex: https://www.exemplo.com.br',
                    prefixIcon: Icon(Icons.edit_outlined),
                  ),
                  onSubmitted: (_) => _gerarQrCode(),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _gerarQrCode,
                  icon: const Icon(Icons.qr_code_2_rounded),
                  label: const Text('Gerar QR Code'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _AreaQrCode(
            conteudo: _conteudoQr,
            aoSalvar: _salvarNoHistorico,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Histórico',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          if (_historico.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Nenhum QR Code salvo ainda. Gere um acima e toque em '
                '"Salvar no histórico".',
                style: TextStyle(color: Colors.black54),
              ),
            )
          else
            ..._historico.map(
              (item) => HistoryTile(
                item: item,
                onTap: () => _reabrirDoHistorico(item),
              ),
            ),
        ],
      ),
    );
  }
}

class _AreaQrCode extends StatelessWidget {
  final String conteudo;
  final VoidCallback aoSalvar;

  const _AreaQrCode({
    required this.conteudo,
    required this.aoSalvar,
  });

  @override
  Widget build(BuildContext context) {
    final temConteudo = conteudo.isNotEmpty;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            if (temConteudo)
              QrImageView(
                data: conteudo,
                version: QrVersions.auto,
                size: 220,
                gapless: false,
              )
            else
              Container(
                width: 220,
                height: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.qr_code_2_outlined,
                  size: 64,
                  color: Colors.black26,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              temConteudo ? conteudo : 'Seu QR Code aparecerá aqui',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54),
            ),
            if (temConteudo) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: aoSalvar,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Salvar no histórico'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
