import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_condominium/widgets/common/inputChoise.dart';
import 'package:smart_condominium/widgets/common/inputText.dart';

class RegisterForm extends StatefulWidget {
  final String? idUsuario;

  const RegisterForm({super.key, this.idUsuario});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Controladores
  late TextEditingController ciController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController telefonoController;
  late TextEditingController fechaNacimientoController;
  late TextEditingController estadoController;
  late TextEditingController correoController;
  late TextEditingController passwordController;

  // Variables extra
  String tipo = '';
  String sexo = '';

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    // Inicializar controladores
    ciController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    telefonoController = TextEditingController();
    fechaNacimientoController = TextEditingController();
    estadoController = TextEditingController();
    correoController = TextEditingController();
    passwordController = TextEditingController();

    if (widget.idUsuario != null) {
      _fetchUsuario();
    }
  }

  Future<void> _fetchUsuario() async {
    setState(() => _loading = true);
    final url = Uri.parse("http://10.0.2.2:8000/copropietarios/${widget.idUsuario}/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data["usuario"];

        setState(() {
          ciController.text = user["ci"] ?? '';
          firstNameController.text = user["first_name"] ?? '';
          lastNameController.text = user["last_name"] ?? '';
          tipo = user["tipo"] ?? '';
          telefonoController.text = user["telefono"] ?? '';
          sexo = user["sexo"] ?? '';
          fechaNacimientoController.text = user["fecha_nacimiento"] ?? '';
          estadoController.text = user["estado"] ?? '';
          correoController.text = user["correo"] ?? '';
          passwordController.text = user["password"] ?? '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cargar usuario")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Excepción: $e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _guardarUsuario() async {
    final url = widget.idUsuario == null
        ? Uri.parse('http://10.0.2.2:8000/copropietarios/')
        : Uri.parse('http://10.0.2.2:8000/usuarios/${widget.idUsuario}/');

    Map<String, dynamic> usuario = widget.idUsuario == null? {
      "usuario": {
        "id": widget.idUsuario,
        "ci": ciController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "tipo": tipo,
        "telefono": telefonoController.text,
        "sexo": sexo,
        "fecha_nacimiento": fechaNacimientoController.text,
        "estado": estadoController.text,
        "correo": correoController.text,
        "password": passwordController.text,
      },
    }:
      {
        "id": widget.idUsuario,
        "ci": ciController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "tipo": tipo,
        "telefono": telefonoController.text,
        "sexo": sexo,
        "fecha_nacimiento": fechaNacimientoController.text,
        "estado": estadoController.text,
        "correo": correoController.text,
        "password": passwordController.text,
      }
    ;

    try {
      final response = await (widget.idUsuario == null
          ? http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(usuario))
          : http.put(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(usuario)));

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.idUsuario == null ? 'Usuario creado!' : 'Usuario actualizado!')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
      print("Request body: ${jsonEncode(usuario)}");
      print("Response body: ${response.body}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Excepción: $e")),
      );
    }
  }

  @override
  void dispose() {
    // Liberar controladores
    ciController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    telefonoController.dispose();
    fechaNacimientoController.dispose();
    estadoController.dispose();
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idUsuario == null ? "Crear Usuario" : "Editar Usuario"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            InputText(
              hintText: 'CI',
              icon: Icons.document_scanner,
              onChanged: (value) {},
              controller: ciController,
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Nombre',
              icon: Icons.person_outlined,
              onChanged: (value) {},
              controller: firstNameController,
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Apellido',
              icon: Icons.person,
              onChanged: (value) {},
              controller: lastNameController,
            ),
            SizedBox(height: 20),
            InputChoiceSingle(
              title: 'Rol',
              opciones: ["Copropietario", "Administrador", "Invitado"],
              onChanged: (value) => setState(() => tipo = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Telefono',
              keyboardType: TextInputType.number,
              icon: Icons.phone,
              onChanged: (value) {},
              controller: telefonoController,
            ),
            SizedBox(height: 20),
            InputChoiceSingle(
              title: 'Genero',
              opciones: ["M", "F"],
              onChanged: (value) => setState(() => sexo = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Fecha Nacimiento',
              icon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
              onChanged: (value) {},
              controller: fechaNacimientoController,
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Estado',
              icon: Icons.check_circle,
              onChanged: (value) {},
              controller: estadoController,
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Correo',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
              controller: correoController,
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Contraseña',
              icon: Icons.password_outlined,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
              controller: passwordController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarUsuario,
              child: Text(widget.idUsuario == null ? 'Crear Usuario' : 'Actualizar Usuario'),
            ),
            
          ],
          
        ),
        
      ),
      
    );
  }
}
