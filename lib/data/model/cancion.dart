class Cancion {
  String _id;
  String _nombre;
  String _urlImg;
  bool _esExplicito;
  int _duracion; //Milisegundoa
  int _numeroEnAlbum;
  List<String> _nombreArtistas;

  Cancion({
    required String id,
    required String nombre,
    required String urlImg,
    required bool esExplicito,
    required int duracion,
    required int numeroEnAlbum,
    required List<String> nombreArtistas,
  }) : _id = id,
       _nombre = nombre,
       _urlImg = urlImg,
       _esExplicito = esExplicito,
       _duracion = duracion,
       _numeroEnAlbum = numeroEnAlbum,
       _nombreArtistas = nombreArtistas;

  factory Cancion.fromJson(Map<String, dynamic> json) {
    // Obtener imagen de la cancion
    String imagen = "";
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      imagen = json['images'][0]['url'] ?? "Imagen no disponible";
    }

    return Cancion(
      id: json['id'] ?? '',
      nombre: json['name'] ?? '',
      urlImg: imagen,
      esExplicito: json['explicit'] ?? false,
      duracion: json['duration_ms'] ?? 0,
      numeroEnAlbum: json['track_number'] ?? 0,
      nombreArtistas: (json['artists'] as List)
          .map<String>((item) => item['name'] as String)
          .toList(),
    );
  }

  String get id => _id;
  String get nombre => _nombre;
  String get urlImg => _urlImg;
  bool get esExplicito => _esExplicito;
  int get duracion => _duracion;
  int get numeroEnAlbum => _numeroEnAlbum;
  List<String> get artista => _nombreArtistas;

  set setId(String id) => _id = id;
  set setNombre(String nombre) => _nombre = nombre;
  set setUrlImg(String urlImg) => _urlImg = urlImg;
  set setEsExplicito(bool esExplicito) => _esExplicito = esExplicito;
  set setDuracion(int duracion) => _duracion = duracion;
  set setNumeroEnAlbum(int numeroEnAlbum) => _numeroEnAlbum = numeroEnAlbum;
  set setArtista(List<String> artista) => _nombreArtistas = artista;
}
