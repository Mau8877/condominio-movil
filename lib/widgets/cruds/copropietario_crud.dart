import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_condominium/paletaColores.dart';
import 'dart:convert';

import 'package:smart_condominium/widgets/common/crudItem.dart';
import 'package:smart_condominium/widgets/forms/copropietarioForm.dart';

class UsuarioCrud extends StatefulWidget {
  const UsuarioCrud({super.key});
  @override
  State<UsuarioCrud> createState() => _UsuarioCrudState();
}
class _UsuarioCrudState extends State<UsuarioCrud> {
  late Future<List<Map<String, dynamic>>> _usuariosFuture;
  @override
  void initState() {
    super.initState();
    _usuariosFuture = fetchUsuarios();
  }
  /// ====== GET: listar usuarios ======
  Future<List<Map<String, dynamic>>> fetchUsuarios() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/copropietarios/"),
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => item["usuario"] as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception("Error al cargar usuarios");
    }
  }
  /// ====== DELETE: eliminar usuario ======
  Future<void> eliminarUsuario(int id) async {
    final response = await http.delete(
      Uri.parse("http://10.0.2.2:8000/usuarios/$id/"),
    );
    if (response.statusCode == 204) {
      setState(() {
        _usuariosFuture = fetchUsuarios();
      });
    } else {
      throw Exception("Error al eliminar usuario");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _usuariosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return  Center(child: TextButton(
              onPressed: () async {
                final updated = await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // esquinas redondeadas
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // importante para el contenido
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 350,
                            maxHeight: 500,
                          ),
                          child: RegisterForm(),
                        ),
                      ),
                    );
                  },
                );
                if (updated == true) {
                  setState(() {
                    _usuariosFuture = fetchUsuarios();
                  });
                }
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: Text(
                "Registrar un nuevo Copropietario",
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),);
        }
        final usuarios = snapshot.data!;
        return Column(
          children: [
            TextButton(
              onPressed: () async {
                final updated = await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // esquinas redondeadas
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // importante para el contenido
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 350,
                            maxHeight: 500,
                          ),
                          child: RegisterForm(),
                        ),
                      ),
                    );
                  },
                );
                if (updated == true) {
                  setState(() {
                    _usuariosFuture = fetchUsuarios();
                  });
                }
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: Text(
                "Registrar un nuevo Usuario",
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  return CrudItem(
                    mainTitle:
                        usuario["first_name"] + " " + usuario["last_name"] ??
                        "Sin nombre",
                    subTitle: usuario["ci"],
                    extraInfo: {"CI": usuario["ci"], "Tel": "789"},
                    onEdit: () async {
                      final updated = await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 500,
                                ),
                                child: RegisterForm(
                                  idUsuario: usuario['id'].toString(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      if (updated == true) {
                        setState(() {
                          _usuariosFuture = fetchUsuarios();
                        });
                      }
                    },
                    onDelete: () async {
                      await eliminarUsuario(usuario["id"]);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
