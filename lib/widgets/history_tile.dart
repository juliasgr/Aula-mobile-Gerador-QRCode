import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/qr_history_item.dart';

/// Um item da lista de histórico, mostrando o texto original
/// e a data/hora em que o QR Code foi gerado.
class HistoryTile extends StatelessWidget {
  final QrHistoryItem item;
  final VoidCallback onTap;

  const HistoryTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatoData = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.qr_code_2_rounded),
        title: Text(
          item.conteudo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(formatoData.format(item.criadoEm)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
