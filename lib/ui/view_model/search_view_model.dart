import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/artista.dart';
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/busqueda_service.dart';

class SearchViewModel extends ChangeNotifier {
  final BusquedaService _busquedaService;

  String _textoBusqueda = "";
  List<Album> _albums = [];
  List<Cancion> _canciones = [];
  List<Artista> _artistas = [];
  bool _isLoading = false;
  String _mensajeError = "";

  String get textoBusqueda => _textoBusqueda;
  List<Album> get albums => _albums;
  List<Cancion> get canciones => _canciones;
  List<Artista> get artistas => _artistas;
  bool get isLoading => _isLoading;
  String get mensajeError => _mensajeError;
  bool get hasError => _mensajeError.isNotEmpty;

  SearchViewModel({BusquedaService? busquedaService})
    : _busquedaService = busquedaService ?? BusquedaService();

  void setTextoBusqueda(String valor) {
    _textoBusqueda = valor;
    notifyListeners();
  }

  Future<void> search() async {
    if (_textoBusqueda.trim().isEmpty) {
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
