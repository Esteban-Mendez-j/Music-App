import 'package:flutter/material.dart';
import 'package:musicapp/ui/view/home_view.dart';
import 'package:musicapp/ui/view_model/search_view_model.dart';
import 'package:musicapp/ui/widget/error_info.dart';
import 'package:musicapp/ui/widget/header.dart';
import 'package:musicapp/ui/widget/info_card.dart';
import 'package:musicapp/ui/widget/loading.dart';
import 'package:musicapp/ui/widget/not_found.dart';
import 'package:musicapp/ui/widget/search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final SearchViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SearchViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return Column(
              children: [
                // Barra de Búsqueda
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: searchBar(
                    onChanged: (val) => _viewModel.setTextoBusqueda(val),
                    onSubmitted: (_) => _viewModel.search(),
                  ),
                ),

                // Contenido Principal
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_viewModel.isLoading)
                          Loading()
                        else if (_viewModel.hasError)
                          ErrorInfo(
                            meensajeError: _viewModel.mensajeError,
                            onPressed: _viewModel.search,
                          )
                        else if (_viewModel.artistas.isEmpty &&
                            _viewModel.canciones.isEmpty &&
                            _viewModel.albums.isEmpty)
                          Notfound(texto: "No se encontraron resultados")
                        else ...[
                          if (_viewModel.artistas.isNotEmpty) ...[
                            _seccionBusqueda(
                              titulo: "Artistas",
                              cantidad: _viewModel.artistas.length,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _viewModel.artistas.length,
                                itemBuilder: (context, index) {
                                  final artista = _viewModel.artistas[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: SizedBox(
                                      width: 240,
                                      child: Infocard(
                                        imagen: artista.urlImg,
                                        titulo: artista.nombre,
                                        tipo: "Artista",
                                        subTitulo: "",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],

                          if (_viewModel.canciones.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            // CANCIONES
                            _seccionBusqueda(
                              titulo: "Canciones",
                              cantidad: _viewModel.canciones.length,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _viewModel.canciones.length,
                                itemBuilder: (context, index) {
                                  final cancion = _viewModel.canciones[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: SizedBox(
                                      width: 240,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomeView(
                                                // cancion: cancions TODO: colocar la vista de info de la cancion
                                              ),
                                            ),
                                          );
                                        },
                                        child: Infocard(
                                          imagen: cancion.urlImg,
                                          titulo: cancion.nombre,
                                          tipo: "Canción",
                                          subTitulo: cancion.artista.isEmpty
                                              ? "Desconocido"
                                              : cancion.artista[0],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],

                          if (_viewModel.albums.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            // ÁLBUMES
                            _seccionBusqueda(
                              titulo: "Álbumes",
                              cantidad: _viewModel.albums.length,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _viewModel.albums.length,
                                itemBuilder: (context, index) {
                                  final album = _viewModel.albums[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: SizedBox(
                                      width: 240,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomeView(
                                                // album:album TODO: colocar la vista de info del album
                                              ),
                                            ),
                                          );
                                        },
                                        child: Infocard(
                                          imagen: album.urlImg,
                                          titulo: album.nombre,
                                          tipo: album.tipo,
                                          subTitulo:
                                              '${album.artista?.nombre ?? "Desconocido"} - ${album.totalCanciones} canciones',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _seccionBusqueda({
  required String titulo,
  required int cantidad,
  required Widget child,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      header(titulo: titulo, subTitulo: "$cantidad resultados encontrados"),

      const SizedBox(height: 16),

      SizedBox(height: 300, child: child),
    ],
  );
}
