import 'package:flutter/material.dart';

Widget header({required String titulo, required String subTitulo}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF00E5FF),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            subTitulo,
            style: TextStyle(color: Color(0xFF7A7893), fontSize: 12),
          ),
        ],
      ),
    ],
  );
}
