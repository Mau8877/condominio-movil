import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_condominium/adminScreen.dart';
import 'package:smart_condominium/widgets/common/inputText.dart';
import 'package:smart_condominium/widgets/registerForm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/logo.png',
                width: 175,
                color: Colors.blueGrey,
              ),
              SizedBox(height: 15),
              InputText(hintText: "Correo", icon: Icons.person),
              SizedBox(height: 15),
              InputText(
                hintText: "Contraseña",
                icon: Icons.password,
                obscureText: true,
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => adminScreen()),
                  );
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                child: Text(
                  "Iniciar Sesion",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "¿No tienes una cuenta? ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: "\nRegístrate",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => registerScreen(),
                          //   ),
                          // );
                          showDialog(
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
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
