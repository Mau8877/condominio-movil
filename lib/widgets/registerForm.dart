import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_condominium/widgets/common/inputChoise.dart';
import 'package:smart_condominium/widgets/common/inputText.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String ci = '';
  String firstName = '';
  String lastName = '';
  String tipo = '';
  String telefono = '';
  String sexo = '';
  String fechaNacimiento = '';
  String estado = '';
  String correo = '';

  Future<void> crearUsuario() async {
    final url = Uri.parse('http://10.0.2.2:8000/copropietarios/');
    Map<String, dynamic> usuario = {
      "usuario": {
        "ci": ci,
        "first_name": firstName,
        "last_name": lastName,
        "tipo": tipo,
        "telefono": telefono,
        "sexo": sexo,
        "fecha_nacimiento": fechaNacimiento,
        "estado": estado,
        "correo": correo,
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(usuario),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario creado correctamente!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear usuario: ${response.statusCode}'),
          ),
        );
      }
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Request body: ${jsonEncode(usuario)}');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Excepción: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Usuario')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            InputText(
              hintText: 'CI',
              icon: Icons.document_scanner,
              onChanged: (value) => setState(() => ci = value),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Nombre',
              icon: Icons.person_outlined,
              onChanged: (value) => setState(() => firstName = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Apellido',
              icon: Icons.person,
              onChanged: (value) => setState(() => lastName = value),
            ),
            SizedBox(height: 20),
            InputChoiceSingle(
              opciones: ["Copropietario", "Administrador", "Invitado"],
              onChanged: (value) => setState(() => tipo = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Telefono',
              keyboardType: TextInputType.number,
              icon: Icons.document_scanner,
              onChanged: (value) => setState(() => telefono = value),
            ),
            SizedBox(height: 20),
            InputChoiceSingle(
              opciones: ["M", "F"],
              onChanged: (value) => setState(() => sexo = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Fecha Nacimiento',
              icon: Icons.document_scanner,
              keyboardType: TextInputType.datetime,
              onChanged: (value) => setState(() => fechaNacimiento = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Estado',
              icon: Icons.document_scanner,
              onChanged: (value) => setState(() => estado = value),
            ),
            SizedBox(height: 20),
            InputText(
              hintText: 'Correo',
              icon: Icons.document_scanner,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => setState(() => correo = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: crearUsuario,
              child: Text('Crear Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
