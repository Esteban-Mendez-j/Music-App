import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musicapp/config/environment.dart';
import 'package:musicapp/ui/view/home_view.dart';
import 'package:musicapp/ui/view/search_view.dart';
import 'package:flutter/gestures.dart';

Future<void> main() async {
  try {
    await dotenv.load();
    Environment.clientId;
    Environment.secretClient;
  } catch (e) {
    log("Error al cargar las variables de entorno: $e");
    return;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeView()),
    );
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
