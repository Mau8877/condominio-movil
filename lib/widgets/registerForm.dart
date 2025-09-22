import 'package:flutter/material.dart';
import 'package:smart_condominium/widgets/common/inputText.dart';
class Registerform extends StatelessWidget {
  const Registerform({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Text("Registrate"),
            SizedBox(height: 15,),
            InputText(hintText: "Nombre", icon: Icons.person),
            SizedBox(height: 15,),
            InputText(hintText: "Correo", icon: Icons.two_mp_outlined),
            SizedBox(height: 15,),
            InputText(hintText: "Contraseña", icon: Icons.password,obscureText: true,),
          ],
        ),
      ),
    );
  }
}