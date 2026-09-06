import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/artista.dart';

class Cancion {
  String _id;
  String _nombre;
  String _urlImg;
  bool _esExplicito;
  int _duracion; //Milisegundoa
  int _numeroEnAlbum;
  List<Artista> _artista;
  Album _album;

  Cancion({
    required String id,
    required String nombre,
    required String urlImg,
    required bool esExplicito,
    required int duracion,
    required int numeroEnAlbum,
    required List<Artista> artistas,
    required Album album,
  }) : _id = id,
       _nombre = nombre,
       _urlImg = urlImg,
       _esExplicito = esExplicito,
       _duracion = duracion,
       _numeroEnAlbum = numeroEnAlbum,
       _artista = artistas,
       _album = album;

  String get id => _id;
  String get nombre => _nombre;
  String get urlImg => _urlImg;
  bool get esExplicito => _esExplicito;
  int get duracion => _duracion;
  int get numeroEnAlbum => _numeroEnAlbum;
  List<Artista> get artista => _artista;
  Album get album => _album;

  set setId(String id) => _id = id;
  set setNombre(String nombre) => _nombre = nombre;
  set setUrlImg(String urlImg) => _urlImg = urlImg;
  set setEsExplicito(bool esExplicito) => _esExplicito = esExplicito;
  set setDuracion(int duracion) => _duracion = duracion;
  set setNumeroEnAlbum(int numeroEnAlbum) => _numeroEnAlbum = numeroEnAlbum;
  set setArtista(List<Artista> artista) => _artista = artista;
  set setAlbum(Album album) => _album = album;
}
