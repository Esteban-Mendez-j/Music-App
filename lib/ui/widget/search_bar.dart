import 'package:flutter/material.dart';

Widget searchBar({
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  VoidCallback? onFilterTap,
}) {
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
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white, fontSize: 13),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
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
