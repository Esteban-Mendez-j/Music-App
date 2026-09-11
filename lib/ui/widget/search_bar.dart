import 'package:flutter/material.dart';

Widget searchBar() {
  return Container(
    height: 44,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: const Color(0xFF1B192A),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFF2A2740)),
    ),
    child: Row(
      children: [
        const Icon(Icons.search_rounded, color: Color(0xFF7A7893), size: 20),
        const SizedBox(width: 8),
        const Expanded(
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Buscar pistas, artistas, álbumes...',
              hintStyle: TextStyle(
                color: Color(0xFF7A7893),
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    ),
  );
}
