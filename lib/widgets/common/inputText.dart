import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType keyboardType;

  const InputText({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  String? _errorText;

  void _validate(String value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      onChanged: (value) {
        // 1. Ejecuta la validación interna como antes
        _validate(value);

        // 2. Notifica al widget padre (el formulario) sobre el cambio
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        filled: true,
        fillColor: const Color.fromARGB(255, 221, 221, 221),
        hoverColor: const Color.fromARGB(255, 128, 127, 127),
        errorText: _errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}