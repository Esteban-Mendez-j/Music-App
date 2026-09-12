import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/data/model/paginacion.dart';
import 'package:musicapp/data/service/busqueda_service.dart';
import 'package:musicapp/data/service/cancion_service.dart';

import '../widgets/album_header_card.dart';
import '../widgets/animated_background.dart'; // <-- Asegúrate de importar tu nuevo widget
import '../widgets/canciones_list_view.dart';
import '../widgets/saved_albums_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoadingCanciones = false;

  final BusquedaService busquedaService = BusquedaService();
  final CancionService _cancionService = CancionService();

  Album? _albumSeleccionado;            
  List<Cancion> _cancionesDelAlbum = []; 

  Future<void> _seleccionarAlbum(Album album) async {
    setState(() {
      _albumSeleccionado = album;
      _isLoadingCanciones = true;
    });

    try {
      final paginacion = Paginacion(limit: 20, offset: 0);
      final canciones = await _cancionService.fetchCancionesByAlbums(
        paginacion: paginacion,
        id: album.id,
      );

      setState(() {
        _cancionesDelAlbum = canciones;
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
    
    final String? urlImagen = _albumSeleccionado?.urlImg;
    final bool tieneImagen = urlImagen != null && urlImagen.isNotEmpty;

    return Scaffold(
      // Esto hace que el fondo se dibuje detrás de la AppBar transparente
      extendBodyBehindAppBar: true, 
      drawer: SavedAlbumsDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Autocomplete<Album>(
            displayStringForOption: (Album option) => option.nombre,
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.trim().isEmpty) {
                return const Iterable<Album>.empty();
              }
              try {
                return await busquedaService.searchAlbums(query: textEditingValue.text);
              } catch (e) {
                return const Iterable<Album>.empty();
              }
            },
            onSelected: (Album selection) {
              _seleccionarAlbum(selection);
            },
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Busca un álbum...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/150'),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      // --- AQUI VA LA MAGIA DEL FONDO ---
      body: tieneImagen
          ? AnimatedAlbumBackground(
              imageUrl: urlImagen,
              child: _buildContenidoCentral(), // Pasamos el contenido encima del fondo
            )
          : Container(
              color: Colors.white, // Fondo blanco genérico por defecto
              child: SafeArea(child: _buildContenidoCentral()),
            ),
    );
  }

  // Extraemos el contenido central para no duplicar código en el operador ternario
  Widget _buildContenidoCentral() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Espaciado para que no quede pegado arriba debajo de la AppBar
          const SizedBox(height: 100), 

          AlbumHeaderCard(albumSeleccionado: _albumSeleccionado),

          const SizedBox(height: 20),

          if (_albumSeleccionado != null) ...[
            CancionesListView(
              isLoadingCanciones: _isLoadingCanciones,
              cancionesDelAlbum: _cancionesDelAlbum,
            ),
          ] else ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: Text(
                  'Escribe en el buscador de arriba para empezar',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}