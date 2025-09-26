import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_condominium/pages/adminScreen.dart';
import 'package:smart_condominium/pages/copropietarioScreen.dart';
import 'package:smart_condominium/pages/guardiaScreen.dart';
import 'package:smart_condominium/pages/residenteScreen.dart';
import 'package:smart_condominium/pages/trabajadorScreen.dart';
import 'package:smart_condominium/widgets/common/inputText.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ciController = TextEditingController();
  final passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    final url = Uri.parse("http://10.0.2.2:8000/login/"); // tu endpoint real
    final body = {
      "ci": ciController.text,
      "password": passwordController.text,
    };
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login exitoso")),
        );
        print(data);
        if(data['tipo']=='Copropietario'){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CopropietarioScreen(ci: data['ci'], nombreUsuario: (data['first_name']+' '+data['last_name']), correo: data['correo'], tipo: data['tipo'])),
        );
        }
        if(data['tipo']=='Administrador'){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => adminScreen(ci: data['ci'], nombreUsuario: (data['first_name'])+" "+(data['last_name']), correo: data['correo'], tipo: data['tipo'])),
        );
        }
        if(data['tipo']=='Trabajador'){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TrabajadorScreen()),
        );
        }
        if(data['tipo']=='Guardia'){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GuardiaScreen()),
        );
        }
        if(data['tipo']=='Residente'){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ResidenteScreen()),
        );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey.shade100, Colors.blueGrey.shade200],
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(32),
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'lib/assets/images/logo.png',
                    width: 120,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InputText(
                    hintText: "CI",
                    icon: Icons.person,
                    controller: ciController,
                  ),
                  const SizedBox(height: 16),
                  InputText(
                    hintText: "Contraseña",
                    icon: Icons.password,
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              "Iniciar Sesión",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
