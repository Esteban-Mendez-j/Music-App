import 'package:flutter/material.dart';

class Notfound extends StatelessWidget {
  final String texto;

  const Notfound({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.search_off, color: Colors.white54, size: 60),
            SizedBox(height: 10),
            Text(texto, style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
