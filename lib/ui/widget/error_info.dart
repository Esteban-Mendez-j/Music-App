import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  final String meensajeError;
  final VoidCallback onPressed;

  const ErrorInfo({
    super.key,
    required this.meensajeError,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.error, color: Colors.redAccent, size: 50),
            Text(
              meensajeError,
              style: const TextStyle(color: Colors.redAccent),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("Reintentar"),
            ),
          ],
        ),
      ),
    );
  }
}
