import 'package:flutter/material.dart';
import 'package:smart_condominium/paletaColores.dart';

class InputChoiceSingle extends StatefulWidget {
  final List<String> opciones; // Lista de opciones
  final String? valorSeleccionado; // Valor inicial seleccionado (opcional)
  final Function(String)? onChanged; // Callback cuando cambia la selección
  final String title;

  const InputChoiceSingle({
    super.key,
    required this.opciones,
    this.valorSeleccionado,
    this.onChanged,
    required this.title,
  });

  @override
  State<InputChoiceSingle> createState() => _InputChoiceSingleState();
}

class _InputChoiceSingleState extends State<InputChoiceSingle> {
  String? _seleccionActual;

  @override
  void initState() {
    super.initState();
    _seleccionActual = widget.valorSeleccionado;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary, // Fondo suave
        borderRadius: BorderRadius.circular(16), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(widget.title),
          Column(
          children: widget.opciones.map((opcion) {
            return RadioListTile<String>(
              title: Text(opcion),
              value: opcion,
              groupValue: _seleccionActual,
              onChanged: (String? value) {
                setState(() {
                  _seleccionActual = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value!);
                }
              },
            );
          }).toList(),
      
        )],
      ),
    );
  }
}
