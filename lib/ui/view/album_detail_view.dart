import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/cancion_service.dart';

import '../widget/album_header_card.dart';
import '../widget/animated_background.dart';
import '../widget/canciones_list_view.dart';

class HomeScreen extends StatefulWidget {
  final Album album;

  const HomeScreen({super.key, required this.album});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoadingCanciones = false;

  final CancionService _cancionService = CancionService();

  List<Cancion> _cancionesDelAlbum = [];

  @override
  void initState() {
    super.initState();
    _cargarCanciones();
  }

  Future<void> _cargarCanciones() async {
    setState(() {
      _isLoadingCanciones = true;
    });

    try {
      final paginacion = Paginacion(limit: 20, offset: 0);

      final canciones = await _cancionService.fetchCancionesByAlbums(
        paginacion: paginacion,
        id: widget.album.id,
      );

      setState(() {
        _cancionesDelAlbum = canciones.map((cancion) {
          cancion.setUrlImg = widget.album.urlImg;
          return cancion;
        }).toList();
        _isLoadingCanciones = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCanciones = false;
      });

      print("Error al cargar canciones del álbum: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? urlImagen = widget.album.urlImg;

    final bool tieneImagen = urlImagen != null && urlImagen.isNotEmpty;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.album.nombre,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: tieneImagen
          ? AnimatedAlbumBackground(
              imageUrl: urlImagen,
              child: _buildContenidoCentral(),
            )
          : Container(
              color: Colors.white,
              child: SafeArea(child: _buildContenidoCentral()),
            ),
    );
  }

  Widget _buildContenidoCentral() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),

          AlbumHeaderCard(albumSeleccionado: widget.album),

          const SizedBox(height: 20),

          CancionesListView(
            isLoadingCanciones: _isLoadingCanciones,
            cancionesDelAlbum: _cancionesDelAlbum,
          ),
        ],
      ),
    );
  }
}
