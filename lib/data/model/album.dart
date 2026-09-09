import 'package:musicapp/data/model/artista.dart';

class Album {
  String _id;
  String _nombre;
  String _tipo;
  int _totalCanciones;
  String _urlImg;
  String _fechaLanzamiento;
  Artista? _artista;
  String _derechos;

  Album({
    required String id,
    required String nombre,
    required String tipo,
    required int totalCanciones,
    required String urlImg,
    required String fechaLanzamiento,
    Artista? artista,
    required String derechos,
  }) : _id = id,
       _nombre = nombre,
       _tipo = tipo,
       _totalCanciones = totalCanciones,
       _urlImg = urlImg,
       _fechaLanzamiento = fechaLanzamiento,
       _artista = artista,
       _derechos = derechos;

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json["id"] ?? "Sin id disponible",
      nombre: json["name"] ?? "Sin nombre disponible",
      tipo: json["type"] ?? "album",
      totalCanciones: json["total_tracks"] ?? 0,
      urlImg: json["images"][0]["url"] ?? "Sin imagen disponible",
      fechaLanzamiento: json["release_date"] ?? "Sin fecha disponible",
      artista: (json["artists"] == null || (json["artists"] as List).isEmpty)
          ? null
          : Artista.fromJson(json["artists"][0]),
      derechos:
          (json["copyrights"] == null || (json["copyrights"] as List).isEmpty)
          ? "sin derechos"
          : json["copyrights"][0]["text"],
    );
  }

  String get id => _id;
  String get nombre => _nombre;
  String get tipo => _tipo;
  int get totalCanciones => _totalCanciones;
  String get urlImg => _urlImg;
  String get fechaLanzamiento => _fechaLanzamiento;
  get artista => _artista;
  String get derechos => _derechos;

  set setId(String id) => _id = id;
  set setNombre(String nombre) => _nombre = nombre;
  set setTipo(String tipo) => _tipo = tipo;
  set setTotalCanciones(int totalCanciones) => _totalCanciones = totalCanciones;
  set setUrlImg(String urlImg) => _urlImg = urlImg;
  set setFechaLanzamiento(String fechaLanzamiento) =>
      _fechaLanzamiento = fechaLanzamiento;
  set setArtista(Artista artista) => _artista = artista;
  set setDerechos(String derechos) => _derechos = derechos;

  @override
  String toString() {
    return "id: $_id nombre: $_nombre fecha: $_fechaLanzamiento imagen: $_urlImg derechos: $_derechos";
  }
}
