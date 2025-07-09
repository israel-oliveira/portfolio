import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardHelper {
  /// Copia o texto para a área de transferência e mostra um snackbar
  static Future<void> copyToClipboard(
    BuildContext context,
    String text, {
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  successMessage ?? 'Copiado para a área de transferência',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  errorMessage ?? 'Erro ao copiar texto',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// Copia o email para a área de transferência
  static Future<void> copy(BuildContext context, String value) async {
    await copyToClipboard(context, value, successMessage: 'Copiado com sucesso!');
  }


}
