import 'dart:convert';
import 'dart:io';

import 'package:musicapp/config/environment.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:http/http.dart' as http;
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

  // listado de albums de un artista
  Future<List<Album>> fetchAlbumsByArtist({required String id}) async {
    try {
      String token = await AuthService().getValidToken();

      final response = await http
          .get(
            Uri.parse("$apiUrl/artists/$id/albums"),
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
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> albums = data["items"] ?? [];
        return albums
            .map((album) => Album.fromJson(album as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          "Error al solicitar albums de un artista: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error al obtener album de un artista: $e");
    }
  }
}
