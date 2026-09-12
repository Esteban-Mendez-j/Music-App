import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musicapp/config/environment.dart';
// Asegúrate de que la ruta coincida con tu estructura de carpetas
import 'package:musicapp/ui/screens/home_screen.dart'; 

Future<void> main() async {
  try {
    await dotenv.load();
    // Validamos que las variables existan
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
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false, // Oculta la etiqueta roja de debug
      // Como vamos a hacer algo estilo Spotify, el tema oscuro es un buen punto de partida
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Color de fondo típico de Spotify
        primaryColor: const Color.fromARGB(255, 227, 6, 6), // Verde Spotify
      ),
      // Apuntamos al HomeScreen que creamos en los pasos anteriores
      home:  HomeScreen(), 
    );
  }
}