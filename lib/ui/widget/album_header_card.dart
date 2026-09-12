import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';

class AlbumHeaderCard extends StatelessWidget {
  final Album? albumSeleccionado;

  const AlbumHeaderCard({Key? key, required this.albumSeleccionado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Verificamos si tenemos una URL de imagen válida
    final bool tieneImagen = albumSeleccionado?.urlImg != null && 
                             albumSeleccionado!.urlImg!.isNotEmpty;

    return Column(
      children: [
        // --- A. IMAGEN DEL ÁLBUM (O ICONO POR DEFECTO) ---
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            // Si hay imagen, la ponemos como fondo del contenedor
            image: tieneImagen
                ? DecorationImage(
                    image: NetworkImage(albumSeleccionado!.urlImg!),
                    fit: BoxFit.cover, // Para que llene todo el cuadrado
                  )
                : null,
          ),
          // Si NO hay imagen, mostramos el icono como hijo
          child: !tieneImagen
              ? const Icon(
                  Icons.music_note,
                  size: 100,
                  color: Colors.grey,
                )
              : null,
        ),

        const SizedBox(height: 20),

        // --- B. DESCRIPCIÓN CON EL NOMBRE DEL ÁLBUM SELECCIONADO ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    albumSeleccionado?.nombre ?? 'Nombre del Álbum',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    albumSeleccionado != null
                        ? 'Artista: ${albumSeleccionado?.artista?.nombre ?? "Desconocido"} • Lanzamiento: ${albumSeleccionado?.fechaLanzamiento ?? ""}'
                        : 'Usa el buscador superior para seleccionar un álbum.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}