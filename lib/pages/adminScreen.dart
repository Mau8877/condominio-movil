import 'package:flutter/material.dart';
import 'package:smart_condominium/paletaColores.dart';
import 'package:smart_condominium/widgets/bitacora.dart';
import 'package:smart_condominium/widgets/cruds/administrador_crud.dart';
import 'package:smart_condominium/widgets/cruds/copropietario_crud.dart';
import 'package:smart_condominium/widgets/cruds/guardia_crud.dart';
import 'package:smart_condominium/widgets/cruds/residente_crud.dart';
import 'package:smart_condominium/widgets/cruds/trabajador_crud.dart';

class adminScreen extends StatefulWidget {
  final String nombreUsuario;
  final String correo;
  final String ci;
  final String tipo;

  const adminScreen({
    super.key,
    required this.nombreUsuario,
    required this.correo,
    required this.ci,
    required this.tipo,
  });

  @override
  State<adminScreen> createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UsuarioCrud(),
    TrabajadorCrud(),
    GuardiaCrud(),
    ResidenteCrud(),
    AdministradorCrud(),
    Bitacora(),
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
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primary, // Color principal
              ),
              accountName: Text(
                widget.nombreUsuario,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(widget.correo ?? "Sin correo"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: AppColors.primary),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Inicio"),
              onTap: () => _onItemTap(0),
            ),
            ExpansionTile(
              leading: const Icon(Icons.people),
              title: const Text("Gestionar Usuarios"),
              children: [
                ListTile(
                  leading: const Icon(Icons.people_outline),
                  title: const Text("Gestiones Copropietarios"),
                  onTap: () => _onItemTap(0),
                ),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text("Gestionar Trabajadores"),
                  onTap: () => _onItemTap(1),
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text("Gestionar Guardias"),
                  onTap: () => _onItemTap(2),
                ),
                ListTile(
                  leading: const Icon(Icons.home_work_outlined),
                  title: const Text("Gestionar Residentes"),
                  onTap: () => _onItemTap(3),
                ),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined),
                  title: const Text("Gestionar Administrador"),
                  onTap: () => _onItemTap(4),
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.money),
              title: Text("Finanzas y Administración"),
              children: [
                ListTile(
                  leading: const Icon(Icons.history_sharp),
                  title: const Text("Gestionar Bitacora"),
                  onTap: () => _onItemTap(5),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
