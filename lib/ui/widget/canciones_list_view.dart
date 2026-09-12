import 'package:flutter/material.dart';
import 'package:musicapp/data/model/cancion.dart';
import 'package:musicapp/ui/view/player_view.dart';

class CancionesListView extends StatelessWidget {
  final bool isLoadingCanciones;
  final List<Cancion> cancionesDelAlbum;

  const CancionesListView({
    super.key,
    required this.isLoadingCanciones,
    required this.cancionesDelAlbum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Canciones del álbum:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // Cambiamos a blanco para que resalte en el fondo oscuro
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        isLoadingCanciones
            ? const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
            : cancionesDelAlbum.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cancionesDelAlbum.length,
                itemBuilder: (context, index) {
                  final cancion = cancionesDelAlbum[index];
                  return ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    title: Text(
                      cancion.nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      cancion.artista.join(', '),
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(cancion: cancion),
                        ),
                      );
                    },
                  );
                },
              )
            : const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Este álbum no contiene canciones registradas.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ],
    );
  }
}
