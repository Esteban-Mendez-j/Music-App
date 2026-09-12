import 'package:flutter/material.dart';

class SavedAlbumsDrawer extends StatelessWidget {
    SavedAlbumsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black87),
            child: Text(
              'Álbumes Guardados',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Simulamos algunos álbumes guardados
          ListTile(
            leading: const Icon(Icons.album),
            title: const Text('Álbum Favorito 1'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.album),
            title: const Text('Álbum Favorito 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}