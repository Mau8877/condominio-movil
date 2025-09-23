import 'package:flutter/material.dart';
import 'package:smart_condominium/widgets/cruds/usuario_crud.dart';

class adminScreen extends StatefulWidget {
  const adminScreen({super.key});

  @override
  State<adminScreen> createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UsuarioCrud(),
    Center(child: Text("Página de Configuración", style: TextStyle(fontSize: 24))),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // cerrar el drawer después de seleccionar
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Screen")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text(
                "Menú",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Inicio"),
              onTap: () => _onItemTap(0)
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Configuración"),
              onTap: () => _onItemTap(1)
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
