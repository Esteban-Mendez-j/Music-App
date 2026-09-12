import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/busqueda_service.dart';

class HomeViewModel extends ChangeNotifier {
  final BusquedaService _busquedaService;

  String _textoBusqueda = "";
  List<Album> _albumsRecientes = [];
  bool _isLoading = false;
  String _mensajeError = "";
  Paginacion _paginacionRecientes = Paginacion(limit: 10, offset: 0);

  String get textoBusqueda => _textoBusqueda;
  List<Album> get albumsRecientes => _albumsRecientes;
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
}
