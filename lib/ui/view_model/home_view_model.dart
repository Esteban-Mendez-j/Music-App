import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/artista.dart';
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/busqueda_service.dart';

class HomeViewModel extends ChangeNotifier {
  final BusquedaService _busquedaService;

  String _textoBusqueda = "";
  List<Album> _albumsRecientes = [];
  List<Album> _albums = [];
  List<Cancion> _canciones = [];
  List<Artista> _artistas = [];
  bool _isLoading = false;
  String _mensajeError = "";
  Paginacion _paginacionRecientes = Paginacion(limit: 10, offset: 0);

  String get textoBusqueda => _textoBusqueda;
  List<Album> get albumsRecientes => _albumsRecientes;
  List<Album> get albums => _albums;
  List<Cancion> get canciones => _canciones;
  List<Artista> get artistas => _artistas;
  bool get isLoading => _isLoading;
  String get mensajeError => _mensajeError;
  bool get hasError => _mensajeError.isNotEmpty;
  Paginacion get paginacionReciente => _paginacionRecientes;

  HomeViewModel({BusquedaService? busquedaService})
    : _busquedaService = busquedaService ?? BusquedaService();

  void setTextoBusqueda(String valor) {
    _textoBusqueda = valor;
    notifyListeners();
  }

  void next() {
    _paginacionRecientes.nextPage();
    getAlbumRecientes(
      limit: paginacionReciente.limit,
      offset: paginacionReciente.offset,
    );
  }

  void previous() {
    _paginacionRecientes.previousPage();
    getAlbumRecientes(
      limit: paginacionReciente.limit,
      offset: paginacionReciente.offset,
    );
  }

  Future<void> getAlbumRecientes({int limit = 10, int offset = 0}) async {
    _isLoading = true;
    _mensajeError = "";
    notifyListeners();

    try {
      Map<String, dynamic> data = await _busquedaService.fetchRecentAlbums(
        limit: limit,
        offset: offset,
      );

      _albumsRecientes = data["items"];
      _paginacionRecientes = data["paginacion"];
    } catch (e) {
      log("Error en getAlbumRecientes: $e");
      _mensajeError = "No se pudieron obtener los álbumes recientes.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> search() async {
    if (_textoBusqueda.trim().isEmpty) {
      await getAlbumRecientes();
      return;
    }

    _isLoading = true;
    _mensajeError = "";
    notifyListeners();

    try {
      final data = await _busquedaService.searchAll(
        query: _textoBusqueda,
        paginacion: Paginacion(limit: 10, offset: 0),
      );
      _albums = (data["albumes"] as List<Album>?) ?? [];
      _artistas = (data["artistas"] as List<Artista>?) ?? [];
      _canciones = (data["canciones"] as List<Cancion>?) ?? [];
    } catch (e) {
      log("Error en search: $e");
      _mensajeError = "Error al obtener resultados de la búsqueda.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
