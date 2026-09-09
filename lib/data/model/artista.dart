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

  factory Artista.fromJson(Map<String, dynamic> json) {
    String imagen = "";
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      imagen = json['images'][0]['url'] ?? "Imagen no disponible";
    }

    return Artista(
      id: json["id"] ?? "",
      nombre: json["name"] ?? "",
      urlImg: imagen,
      tipo: json["type"] ?? "artist",
    );
  }
  String get id => _id;
  String get nombre => _nombre;
  String get urlImg => _urlImg;
  String get tipo => _tipo;

  set setId(String id) => _id = id;
  set setUrlImg(String urlImg) => _urlImg = urlImg;
  set setNombre(String nombre) => _nombre = nombre;
  set setTipo(String tipo) => _tipo = tipo;
}
