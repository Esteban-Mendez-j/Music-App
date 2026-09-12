import 'package:flutter/material.dart';
import 'package:musicapp/ui/view_model/home_view_model.dart';
import 'package:musicapp/ui/widget/error_info.dart';
import 'package:musicapp/ui/widget/header.dart';
import 'package:musicapp/ui/widget/info_card.dart';
import 'package:musicapp/ui/widget/loading.dart';
import 'package:musicapp/ui/widget/not_found.dart';
import 'package:musicapp/ui/widget/paginacion_widget.dart';
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
    _viewModel.getAlbumRecientes(
      limit: _viewModel.paginacionReciente.limit,
      offset: _viewModel.paginacionReciente.offset,
    );
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
                          Loading()
                        else if (_viewModel.hasError)
                          ErrorInfo(
                            meensajeError: _viewModel.mensajeError,
                            onPressed: _viewModel.getAlbumRecientes,
                          )
                        else if (_viewModel.albumsRecientes.isEmpty)
                          Notfound(texto: "No se encontraron albums")
                        else
                          LayoutBuilder(
                            builder: (context, constraints) {
                              int crossAxisCount = 3;
                              if (constraints.maxWidth <= 900 &&
                                  constraints.maxWidth > 500) {
                                crossAxisCount = 2;
                              } else if (constraints.maxWidth <= 500) {
                                crossAxisCount = 1;
                              }
                              double childAspectRatio = crossAxisCount == 1
                                  ? 0.90
                                  : 0.84;

                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _viewModel.albumsRecientes.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: childAspectRatio,
                                    ),
                                itemBuilder: (context, index) {
                                  final album =
                                      _viewModel.albumsRecientes[index];
                                  return Infocard(
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
                        if (!_viewModel.isLoading)
                          PaginacionWidget(homeViewModel: _viewModel),
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
