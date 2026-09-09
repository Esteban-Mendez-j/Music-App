import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:musicapp/config/environment.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/artista.dart';
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/auth_service.dart';

class BusquedaService {
  final apiUrl = Environment.apiUrl;

  // Busca simultaneamente albums, artistas y canciones en Spotify
  Future<Map<String, dynamic>> searchAll({
    required String query,
    Paginacion? paginacion,
  }) async {
    try {
      final token = await AuthService().getValidToken();
      final limit = paginacion?.limit ?? 10;
      final offset = paginacion?.offset ?? 0;

      final response = await http
          .get(
            Uri.parse(
              "$apiUrl/search?q=${Uri.encodeComponent(query)}&type=album,artist,track&limit=$limit&offset=$offset",
            ),
            headers: <String, String>{
              HttpHeaders.authorizationHeader: "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception("Tiempo de conexion agotado"),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List<dynamic> albumItems = data['albums']?['items'] ?? [];
        final List<dynamic> artistItems = data['artists']?['items'] ?? [];
        final List<dynamic> trackItems = data['tracks']?['items'] ?? [];

        return {
          'albumes': albumItems
              .map((item) => Album.fromJson(item as Map<String, dynamic>))
              .toList(),
          'artistas': artistItems
              .map((item) => Artista.fromJson(item as Map<String, dynamic>))
              .toList(),
          'canciones': trackItems
              .map((item) => Cancion.fromJson(item as Map<String, dynamic>))
              .toList(),
        };
      } else {
        throw Exception(
          "Error al realizar la busqueda: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error al buscar: $e");
    }
  }

  // Obtener los albumes mas recientes (ultimas dos semanas)
  Future<List<Album>> fetchRecentAlbums({Paginacion? paginacion}) async {
    try {
      final token = await AuthService().getValidToken();

      final limit = paginacion?.limit ?? 10;
      final offset = paginacion?.offset ?? 0;

      final response = await http
          .get(
            Uri.parse(
              "$apiUrl/search?q=tag:new&type=album&limit=$limit&offset=$offset",
            ),
            headers: <String, String>{
              HttpHeaders.authorizationHeader: "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception("Tiempo de conexion agotado"),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> items = data['albums']?['items'] ?? [];

        return items
            .map((item) => Album.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          "Error al obtener los albums recientes: ${response.statusCode}",
        );
      }
    } catch (e) {
      log("Error en la peticion : $e");
      throw Exception("Error al realizar la peticion: $e");
    }
  }
}
