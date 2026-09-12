import 'package:flutter/material.dart';
import 'package:musicapp/ui/widget/home_view.dart';
import 'package:musicapp/ui/view/search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _indiceActual = 0;

  final List<Widget> _vistas = [const HomeView(), const SearchView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _vistas[_indiceActual],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceActual,

        onDestinationSelected: (index) {
          setState(() {
            _indiceActual = index;
          });
        },

        backgroundColor: const Color(0xFF15141D),
        indicatorColor: const Color(0xFF292735),

        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            );
          }

          return const TextStyle(color: Colors.white54, fontSize: 13);
        }),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: Colors.white),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }
}
