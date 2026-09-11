import 'package:flutter/material.dart';
import 'package:musicapp/ui/view_model/home_view_model.dart';
import 'package:musicapp/ui/widget/header.dart';
import 'package:musicapp/ui/widget/info_card.dart';
import 'package:musicapp/ui/widget/search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    // Carga inicial al montar la vista
    _viewModel.getAlbumRecientes();
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
                        const SizedBox(height: 8),
                        header(
                          titulo: "Álbumes Recién Lanzados",
                          subTitulo:
                              "Seleccione un álbum para ver sus detalles",
                        ),
                        const SizedBox(height: 18),

                        if (_viewModel.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CircularProgressIndicator(
                                color: Color(0xFFFF4081),
                              ),
                            ),
                          )
                        else if (_viewModel.hasError)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Column(
                                children: [
                                  Text(
                                    _viewModel.mensajeError,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: _viewModel.getAlbumRecientes,
                                    child: const Text("Reintentar"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (_viewModel.albums.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                "No se encontraron álbumes",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ),
                          )
                        else
                          LayoutBuilder(
                            builder: (context, constraints) {
                              int crossAxisCount = constraints.maxWidth > 600
                                  ? 2
                                  : 1;
                              double childAspectRatio = crossAxisCount == 1
                                  ? 0.85
                                  : 0.74;

                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _viewModel.albums.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: childAspectRatio,
                                    ),
                                itemBuilder: (context, index) {
                                  final album = _viewModel.albums[index];
                                  return infoCard(
                                    imagen: album.urlImg,
                                    titulo: album.nombre,
                                    tipo: album.tipo,
                                    subTitulo:
                                        '${album.artista?.nombre ?? "Desconocido"} - ${album.totalCanciones} canciones',
                                  );
                                },
                              );
                            },
                          ),
                        const SizedBox(height: 24),
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
