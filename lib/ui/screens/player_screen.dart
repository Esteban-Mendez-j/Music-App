import 'package:flutter/material.dart';
import 'package:musicapp/data/model/cancion.dart';

class PlayerScreen extends StatefulWidget {
  final Cancion cancion;

  const PlayerScreen({super.key, required this.cancion});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _reproduciendo = false;
  bool _esFavorito = false;
  bool _shuffleActivo = false;
  bool _repeatActivo = false;
  double _progresoActual = 0; // en milisegundos

  // Convierte milisegundos a formato mm:ss
  String _formatearDuracion(int ms) {
    final duracion = Duration(milliseconds: ms);
    final minutos = duracion.inMinutes;
    final segundos = duracion.inSeconds % 60;
    return "$minutos:${segundos.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final cancion = widget.cancion;
    final nombreArtistas = cancion.artista.join(", ");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reproduciendo desde el álbum",
          style: TextStyle(fontSize: 12),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Menú de opciones
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Artwork card
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: cancion.urlImg.isNotEmpty
                    ? Image.network(
                        cancion.urlImg,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.music_note, size: 100),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.music_note, size: 100),
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Nombre de la canción + botón favorito
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cancion.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (cancion.esExplicito)
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text(
                                "E",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              nombreArtistas,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _esFavorito ? Icons.favorite : Icons.favorite_border,
                    color: _esFavorito ? Colors.green : null,
                  ),
                  onPressed: () {
                    setState(() => _esFavorito = !_esFavorito);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Barra de progreso
            Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Slider(
                    value: _progresoActual.clamp(
                      0,
                      cancion.duracion.toDouble(),
                    ),
                    max: cancion.duracion.toDouble(),
                    onChanged: (value) {
                      setState(() => _progresoActual = value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatearDuracion(_progresoActual.toInt()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        _formatearDuracion(cancion.duracion),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Controles de reproducción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shuffle,
                    color: _shuffleActivo ? Colors.green : null,
                  ),
                  onPressed: () {
                    setState(() => _shuffleActivo = !_shuffleActivo);
                  },
                ),
                IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    // Canción anterior
                  },
                ),
                IconButton(
                  iconSize: 56,
                  icon: Icon(
                    _reproduciendo
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                  ),
                  onPressed: () {
                    setState(() => _reproduciendo = !_reproduciendo);
                  },
                ),
                IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    // Siguiente canción
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: _repeatActivo ? Colors.green : null,
                  ),
                  onPressed: () {
                    setState(() => _repeatActivo = !_repeatActivo);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Barra de acciones inferior
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.devices),
                  onPressed: () {
                    // Dispositivos disponibles
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.playlist_play),
                      onPressed: () {
                        // Cola de reproducción
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // Compartir
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
