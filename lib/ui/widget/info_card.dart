import 'package:flutter/material.dart';

Widget infoCard({
  required String imagen,
  required String titulo,
  required String tipo,
  required String subTitulo,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF161426),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFF26233D)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Album Image
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: AspectRatio(
                aspectRatio: 1.05,
                child: Image.network(
                  width: 80,
                  height: 80,
                  imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF242038),
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white24,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF201D35),
                borderRadius: BorderRadius.circular(12),
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
          style: const TextStyle(color: Color(0xFF7A7893), fontSize: 13),
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}
