import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musicapp/config/environment.dart';

import 'package:musicapp/data/model/auth.dart';

class AuthService {
  // Patron Singleton para compartir la misma instancia y token en toda la app
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  // Almacena los datos de la sesion actual
  Auth? _currentAuth;

  // obtencion de variables
  final apiUrl = Environment.apiUrl;
  final String grantType = "client_credentials";

  AuthService._internal();

  // Retorna un token valido (reutiliza el existente o pide uno nuevo si expiró)
  Future<String> getValidToken() async {
    if (_currentAuth == null || _currentAuth!.isExpired) {
      _currentAuth = await _fetchToken();
    }
    return _currentAuth!.token;
  }

  // Pide un token nuevo a la API
  Future<Auth> _fetchToken() async {
    final response = await http.post(
      Uri.parse("$apiUrl/token"),
      headers: <String, String>{"Content-Type": "x-www-form-urlencoded"},
      body: <String, String>{
        "grant_type": grantType,
        "client_id": Environment.clientId,
        "client_secret": Environment.secretClient,
      },
    );

    if (response.statusCode == 200) {
      return Auth.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error de autenticacion: ${response.statusCode}");
    }
  }
}
