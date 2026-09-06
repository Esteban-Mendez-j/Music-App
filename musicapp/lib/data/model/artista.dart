class Artista {
  String _id;
  String _nombre;
  String _urlImg;
  String _tipo;

  Artista({
    required String id,
    required String nombre,
    required String urlImg,
    required String tipo,
  }) : _id = id,
       _nombre = nombre,
       _urlImg = urlImg,
       _tipo = tipo;

  Artista.fromJson(Map<String, dynamic> json)
    : _id = json["id"],
      _nombre = json["name"],
      _urlImg = json["images"]["url"],
      _tipo = json["type"];

  String get id => _id;
  String get nombre => _nombre;
  String get urlImg => _urlImg;
  String get tipo => _tipo;

  set setId(String id) => _id = id;
  set setUrlImg(String urlImg) => _urlImg = urlImg;
  set setNombre(String nombre) => _nombre = nombre;
  set setTipo(String tipo) => _tipo = tipo;
}
