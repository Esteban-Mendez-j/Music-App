import 'package:musicapp/data/model/artista.dart';

class Album {
  String _id;
  String _nombre;
  String _tipo;
  int _totalCanciones;
  String _urlImg;
  DateTime _fechaLanzamiento;
  Artista _artista;
  String _derechos;
  List<String> _canciones;

  Album({
    required String id,
    required String nombre,
    required String tipo,
    required int totalCanciones,
    required String urlImg,
    required DateTime fechaLanzamiento,
    required Artista artista,
    required String derechos,
    required List<String> canciones,
  }) : _id = id,
       _nombre = nombre,
       _tipo = tipo,
       _totalCanciones = totalCanciones,
       _urlImg = urlImg,
       _fechaLanzamiento = fechaLanzamiento,
       _artista = artista,
       _derechos = derechos,
       _canciones = canciones;

  String get id => _id;
  String get nombre => _nombre;
  String get tipo => _tipo;
  int get totalCanciones => _totalCanciones;
  String get urlImg => _urlImg;
  DateTime get fechaLanzamiento => _fechaLanzamiento;
  Artista get artista => _artista;
  String get derechos => _derechos;
  List<String> get canciones => _canciones;

  set setId(String id) => _id = id;
  set setNombre(String nombre) => _nombre = nombre;
  set setTipo(String tipo) => _tipo = tipo;
  set setTotalCanciones(int totalCanciones) => _totalCanciones = totalCanciones;
  set setUrlImg(String urlImg) => _urlImg = urlImg;
  set setFechaLanzamiento(DateTime fechaLanzamiento) =>
      _fechaLanzamiento = fechaLanzamiento;
  set setArtista(Artista artista) => _artista = artista;
  set setDerechos(String derechos) => _derechos = derechos;
  set setCanciones(List<String> canciones) => _canciones = canciones;
}
