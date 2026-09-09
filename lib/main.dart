import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musicapp/config/environment.dart';

Future<void> main() async {
  try {
    await dotenv.load();
    Environment.clientId;
    Environment.secretClient;
  } catch (e) {
    log("Error al cargar las variables de entorno: $e");
    return;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Column(children: [Text("Spotify")])),
      ),
    );
  }
}
