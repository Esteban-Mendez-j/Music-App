import 'package:flutter/material.dart';

class Infocard extends StatelessWidget {
  final String imagen;
  final String titulo;
  final String tipo;
  final String subTitulo;

  const Infocard({
    super.key,
    required this.imagen,
    required this.titulo,
    required this.tipo,
    required this.subTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF161426),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF26233D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Image.network(
                imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF242038),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white24,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF201D35),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF332E52)),
                ),
                child: Text(
                  tipo,
                  style: const TextStyle(
                    color: Color(0xFF9A96B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subTitulo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF7A7893), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
