import 'dart:convert';
import 'dart:io';

import 'package:musicapp/config/environment.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:http/http.dart' as http;
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/auth_service.dart';

class AlbumService {
  final apiUrl = Environment.apiUrl;

  // Obtener la informacion de un album
  Future<Album> fetchAlbum(String id) async {
    try {
      String token = await AuthService().getValidToken();

      final response = await http
          .get(
            Uri.parse("$apiUrl/albums/$id"),
            headers: <String, String>{
              HttpHeaders.authorizationHeader: "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception("tiempo de conexion agotado"),
          );

      if (response.statusCode == 200) {
        return Album.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Error al solicitar un album: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al obtener album: $e");
    }
  }

  // Obtener las canciones de un album
  Future<List<Cancion>> fetchCancionesByAlbums({
    required Paginacion paginacion,
    required String id,
  }) async {
    try {
      String token = await AuthService().getValidToken();

      final response = await http
          .get(
            Uri.parse(
              "$apiUrl/albums/$id/tracks?limit=${paginacion.limit}&offset=${paginacion.offset}",
            ),
            headers: <String, String>{
              HttpHeaders.authorizationHeader: "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception("tiempo de conexion agotado"),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        return items
            .map((item) => Cancion.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          "Error al solicitar canciones de un album: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error al obtener canciones de album: $e");
    }
  }
}
