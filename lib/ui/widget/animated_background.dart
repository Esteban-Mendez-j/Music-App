import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedAlbumBackground extends StatefulWidget {
  final String imageUrl;
  final Widget child; // El contenido principal (tu reproductor, botones, etc.)

  const AnimatedAlbumBackground({
    super.key,
    required this.imageUrl,
    required this.child,
  });

  @override
  State<AnimatedAlbumBackground> createState() => _AnimatedAlbumBackgroundState();
}

class _AnimatedAlbumBackgroundState extends State<AnimatedAlbumBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Controlador de la animación: 15 segundos para que el movimiento sea muy sutil y relajante
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat(reverse: true); // Hace que la animación vaya y venga infinitamente

    // Animación de escala: la imagen crecerá del 100% al 130% de su tamaño
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Agrupamos TODO el fondo dentro de IgnorePointer para que no bloquee los toques
        IgnorePointer(
          child: Stack(
            fit: StackFit.expand, // Asegura que llene toda la pantalla
            children: [
              // Imagen animada
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Efecto borroso (Blur) y oscurecimiento
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),

        // 2. El contenido principal de tu pantalla (los clics llegarán aquí directo)
        SafeArea(
          child: widget.child,
        ),
      ],
    );
  }
  }