import 'package:flutter/material.dart';
import 'package:musicapp/data/model/album.dart';
import 'package:musicapp/data/model/artista.dart';
import 'package:musicapp/ui/widget/header.dart';
import 'package:musicapp/ui/widget/info_card.dart';
import 'package:musicapp/ui/widget/search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  List<Album> albums = [
    Album(
      id: "12334",
      nombre: "Padre Tiempo",
      tipo: "Album",
      totalCanciones: 20,
      urlImg:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTczdRV_zAKMEt3KxN05Gctqo8emaIwiSwe2t_Yk2kQBQ&s=10",
      fechaLanzamiento: "15-09-2005",
      derechos: "derechos reservados",
      artista: Artista(
        id: "s",
        nombre: "Eladio Carrion",
        urlImg: "",
        tipo: "artist",
      ),
    ),
    Album(
      id: "5674",
      nombre: "El Gladiador - Remix",
      tipo: "Album",
      totalCanciones: 10,
      urlImg:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTczdRV_zAKMEt3KxN05Gctqo8emaIwiSwe2t_Yk2kQBQ&s=10",
      fechaLanzamiento: "25-09-2015",
      derechos: "derechos reservados",
      artista: Artista(
        id: "s",
        nombre: "Eladio Carrion",
        urlImg: "",
        tipo: "artist",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(child: searchBar()),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          header(
                            titulo: "Albumes Recien Lanzados",
                            subTitulo:
                                "Seleccione un album para ver sus detalles",
                          ),
                          const SizedBox(height: 18),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: albums.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 400,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.82,
                                ),
                            itemBuilder: (context, index) {
                              return infoCard(
                                imagen: albums[index].urlImg,
                                titulo: albums[index].nombre,
                                tipo: albums[index].tipo,
                                subTitulo:
                                    '${albums[index].artista?.nombre} - ${albums[index].totalCanciones} canciones',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
